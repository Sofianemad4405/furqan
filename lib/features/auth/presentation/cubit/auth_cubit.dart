import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/features/stats/data/models/achievement.dart';
import 'package:furqan/features/user_data/models/daily_challenge_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final supabase = sl<SupabaseClient>();
  final prefs = sl<Prefs>();

  Future<void> googleSignIn() async {
    try {
      emit(GoogleAuthLoading());

      const webClientId =
          '885310355539-7vksih53bkloogp9mb3ra6vst8jjnsah.apps.googleusercontent.com';

      final googleSignIn = GoogleSignIn(serverClientId: webClientId);
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(const GoogleAuthError("Sign in cancelled"));
        return;
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        emit(const GoogleAuthError("Missing token"));
        return;
      }

      final authResponse = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      final user = authResponse.user;
      if (user != null) {
        await prefs.saveUser(
          name: user.userMetadata?['name'] ?? '',
          email: user.email ?? '',
          photo: user.userMetadata?['picture'] ?? '',
          userId: user.id,
        );
        log("message");
      }
      emit(GoogleAuthSuccess(authResponse: authResponse));
    } catch (e) {
      log(e.toString());
      emit(GoogleAuthError(e.toString()));
    }
  }

  Future<void> addDefaultChallengesAndAchievements() async {
    final supabase = sl<SupabaseClient>();
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;
    final existing = await supabase
        .from('daily_challenges')
        .select('id')
        .eq('user_id', userId);

    if (existing.isNotEmpty) return;

    final challenges = [
      DailyChallengeModel(
        userId: userId,
        title: 'Complete 3 Surahs',
        icon: "📖",
        description: "Read any 3 Surahs today",
        target: 3,
        completed: 0,
        createdAt: DateTime.now().toIso8601String(),
      ),
      DailyChallengeModel(
        userId: userId,
        title: 'Morning Duas',
        icon: "🤲",
        description: "Recite 5 morning duas",
        target: 5,
        completed: 0,
        createdAt: DateTime.now().toIso8601String(),
      ),
      DailyChallengeModel(
        userId: userId,
        title: 'Evening Duas',
        icon: "🌙",
        description: "Recite 5 evening duas",
        target: 5,
        completed: 0,
        createdAt: DateTime.now().toIso8601String(),
      ),
    ];
    final achievements = [
      Achievement(
        title: 'First Steps',
        description: 'Read your first Ayah',
        icon: '🌟',
        unlocked: false,
        id: 1,
      ),
      Achievement(
        title: 'Consistent Reader',
        description: '7 day reading streak',
        icon: '🔥',
        unlocked: false,
        id: 2,
      ),
      Achievement(
        title: 'Surah Master',
        description: 'Complete 10 Surahs',
        icon: '📚',
        unlocked: false,
        id: 3,
      ),
      Achievement(
        title: 'Night Reader',
        description: 'Read after Isha prayer',
        icon: '🌙',
        unlocked: false,
        id: 4,
      ),
      Achievement(
        title: 'Challenge Champion',
        description: 'Complete 50 challenges',
        icon: '🏆',
        unlocked: false,
        id: 5,
      ),
      Achievement(
        title: 'Duas Master',
        description: 'Recite 100 Duas',
        icon: '🤲',
        unlocked: false,
        id: 6,
      ),
      Achievement(
        title: 'Dhikr Champion',
        description: 'Complete 1000 Dhikr',
        icon: '✨',
        unlocked: false,
        id: 7,
      ),
      Achievement(
        title: 'Devoted Reader',
        description: '30 day streak',
        icon: '💎',
        unlocked: false,
        id: 8,
      ),
    ];
    await supabase
        .from('daily_challenges')
        .insert(challenges.map((c) => c.toJson()).toList());
    await supabase
        .from('achievements')
        .insert(achievements.map((a) => a.toJson()).toList());
    log('Default challenges and achievements added for user $userId');
  }

  Future<void> signInWithFacebook() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: kIsWeb ? null : 'io.supabase.flutter://callback',
      authScreenLaunchMode: kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
  }

  Future<void> signInWithGithub() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.github,
      redirectTo: kIsWeb ? null : 'my.scheme://my-host',
      authScreenLaunchMode: kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
  }

  Future<void> signUpNewUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      emit(SignUpLoading());
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
        emailRedirectTo: "io.supabase.flutter://login-callback",
      );
      log(res.user.toString());
      final user = res.user;
      if (user != null) {
        await addDefaultChallengesAndAchievements();
      }
      emit(SignUpSuccess(authResponse: res));
    } on AuthApiException catch (e) {
      log(e.toString());
      emit(SignUpError(e.message));
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      emit(SignInLoading());

      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user != null) {
        await prefs.saveUser(
          name: res.user!.userMetadata?['name'] ?? '',
          email: res.user!.email ?? '',
          photo: res.user!.userMetadata?['photo'] ?? '',
          userId: res.user!.id,
        );

        emit(SignInSuccess(authResponse: res));
      }
    } on AuthApiException catch (e) {
      log(e.toString());
      emit(SignInError(e.message));
    }
  }

  Future<void> signInWithEmailOtp({
    required String email,
    required BuildContext context,
  }) async {
    try {
      emit(SignInOtpLoading());
      await supabase.auth.signInWithOtp(email: email);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("OTP sent!")));
      emit(SignInOtpSuccess());
    } on Exception catch (e) {
      emit(SignInOtpError(e.toString()));
    }
  }

  // Future<void> verifyOtp(String email, String otp) async {
  //   try {
  //     await supabase.auth.verifyOTP(
  //       email: email,
  //       token: otp,
  //       type: OtpType.email,
  //     );
  //     emit(SignInSuccess(authResponse: AuthResponse()));
  //   } on Exception catch (e) {
  //     emit(SignInError(e.toString()));
  //   }
  // }

  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.flutter://reset-password',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent to your email!'),
          backgroundColor: Colors.green,
        ),
      );
    } on AuthApiException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    await prefs.clear();
  }

  Future<bool> checkSession() async {
    final session = supabase.auth.currentSession;
    final isLoggedIn = await prefs.isLoggedIn();
    return session != null && isLoggedIn;
  }
}
