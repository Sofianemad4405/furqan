// @ts-nocheck

import { serve } from "https://deno.land/std@0.201.0/http/server.ts";
// use a Deno-friendly build of supabase-js
import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm";

serve(async (req) => {
  try {
    const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
    const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
      console.error("Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY env vars");
      return new Response("Missing env vars", { status: 500 });
    }

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
      global: { headers: { "x-upsert": "true" } },
    });

    const today = new Date().toISOString().split("T")[0]; // YYYY-MM-DD

    const { data: users, error: usersError } = await supabase
      .from("users")
      .select("id");

    if (usersError) {
      console.error("Error fetching users:", usersError);
      return new Response("Failed to fetch users", { status: 500 });
    }
    if (!users || users.length === 0) {
      console.log("No users found - nothing to do.");
      return new Response("No users", { status: 200 });
    }

    // 2) جلب التحديات الأساسية
    const { data: challenges, error: challengesError } = await supabase
      .from("daily_challenges")
      .select("id");

    if (challengesError) {
      console.error("Error fetching challenges:", challengesError);
      return new Response("Failed to fetch challenges", { status: 500 });
    }
    if (!challenges || challenges.length === 0) {
      console.log("No challenges defined - nothing to insert.");
      return new Response("No challenges", { status: 200 });
    }

    // 3) نعمل الإدخالات لكل مستخدم — لكن نحطها على دفعات (batch) لو المستخدمين كتير
    const BATCH_SIZE = 200; // غيّر لو عايز
    for (let i = 0; i < users.length; i += BATCH_SIZE) {
      const batchUsers = users.slice(i, i + BATCH_SIZE);

      const inserts: any[] = [];
      for (const u of batchUsers) {
        // نتأكد إن المستخدم مش عنده already entries لليوم
        // (بديل: ممكن نعمل UPSERT لكن الأسهل هو التأكد قبل الإدخال)
        const { data: existing } = await supabase
          .from("user_daily_challenges")
          .select("id")
          .eq("user_id", u.id)
          .eq("date", today)
          .limit(1);

        if (existing && existing.length > 0) {
          continue;
        }

        for (const c of challenges) {
          inserts.push({
            user_id: u.id,
            challenge_id: c.id,
            completed: 0,
            date: today,
            created_at: new Date().toISOString(),
          });
        }
      }

      if (inserts.length === 0) continue;

      const { error: insertError } = await supabase
        .from("user_daily_challenges")
        .insert(inserts);

      if (insertError) {
        console.error("Insert error for batch starting at", i, insertError);
        // لا نوقف التنفيذ بالكامل — نكمل على الباقي
      } else {
        console.log(`Inserted ${inserts.length} rows for batch starting at ${i}`);
      }
    }

    return new Response("✅ Daily challenges reset complete", { status: 200 });
  } catch (err) {
    console.error("Unhandled error in function:", err);
    return new Response("Internal server error", { status: 500 });
  }
});
