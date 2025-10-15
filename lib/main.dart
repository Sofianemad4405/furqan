import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/app/furqan.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:furqan/features/home/presentation/cubit/user_progress_cubit.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await setupLocator();
  await Supabase.initialize(
    url: 'https://cnuahoupcouqorghsemr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNudWFob3VwY291cW9yZ2hzZW1yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3ODUwNzQsImV4cCI6MjA3NTM2MTA3NH0.q02YLI-m4DmhCwpV8mO1OWUPDgKGepbpW5Z87E_wokc',
  );
  final prefs = sl<Prefs>();
  final supabase = sl<SupabaseClient>();
  final isLoggedIn =
      (await prefs.isLoggedIn()) && (supabase.auth.currentSession != null);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ThemeCubit>()..init()),
        BlocProvider(create: (context) => sl<ReadingCubit>()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<AdhkarCubit>()),
        BlocProvider(create: (context) => sl<UserProgressCubit>()..init()),
      ],
      child: Furqan(isLoggedIn: isLoggedIn),
    ),
  );
}
