import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:furqan/app/furqan.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:furqan/features/home/presentation/cubit/user_progress_cubit.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await setupLocator();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
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
        BlocProvider(create: (context) => sl<PrayerTimesCubit>()),
      ],
      child: Furqan(isLoggedIn: isLoggedIn),
    ),
  );
}
