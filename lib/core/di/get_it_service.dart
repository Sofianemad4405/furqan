import 'package:furqan/core/network/adhkar_client.dart';
import 'package:furqan/core/network/dio_factory.dart';
import 'package:furqan/core/network/prayer_times_client.dart';
import 'package:furqan/core/network/retrofit_client.dart';
import 'package:furqan/core/network/tafsir_client.dart';
import 'package:furqan/core/services/location_service.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:furqan/features/home/data/abstract_remote_data_source.dart';
import 'package:furqan/features/home/data/remote_data_source_impl.dart';
import 'package:furqan/features/home/domain/home_repo_abstract.dart';
import 'package:furqan/features/home/domain/home_repo_impl.dart';
import 'package:furqan/features/home/presentation/cubit/user_progress_cubit.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/data/prayer_times_abstract.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/data/prayer_times_impl.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/domain/prayer_times_repo_abstract.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/domain/prayer_times_repo_impl.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:furqan/features/reading/data/reading_data_source.dart';
import 'package:furqan/features/reading/domain/reading_repo.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:furqan/features/user_data/controller/user_data_controller.dart';
import 'package:furqan/features/user_data/services/user_progress_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core Services
  sl.registerLazySingleton<DioFactory>(() => DioFactory());
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // API Clients
  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<DioFactory>().getDio()),
  );
  sl.registerLazySingleton<TafsirClient>(
    () => TafsirClient(sl<DioFactory>().getDio()),
  );
  sl.registerLazySingleton<AdhkarClient>(
    () => AdhkarClient(sl<DioFactory>().getDio()),
  );
  sl.registerLazySingleton<PrayerTimesClient>(
    () => PrayerTimesClient(sl<DioFactory>().getDio()),
  );

  // Data Sources
  sl.registerLazySingleton<ReadingDataSource>(
    () => ReadingDataSourceImpl(sl<ApiService>(), sl<TafsirClient>()),
  );
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(sl<AdhkarClient>()),
  );
  sl.registerLazySingleton<PrayerTimesDataAbstract>(
    () => PrayerTimesImpl(sl<PrayerTimesClient>()),
  );
  sl.registerLazySingleton<UserProgressService>(() => UserProgressService());

  // Repositories
  sl.registerLazySingleton<ReadingRepo>(
    () => ReadingRepoImpl(sl<ReadingDataSource>()),
  );
  sl.registerLazySingleton<HomeRepoAbstract>(
    () => HomeRepoImpl(sl<RemoteDataSource>()),
  );
  sl.registerLazySingleton<PrayerTimesRepoAbstract>(
    () => PrayerTimesRepoImpl(sl<PrayerTimesDataAbstract>()),
  );

  // Controllers
  sl.registerLazySingleton<UserDataController>(
    () => UserDataController(sl<UserProgressService>()),
  );

  // Cubits
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl<Prefs>()));
  sl.registerLazySingleton<ReadingCubit>(() => ReadingCubit(sl<ReadingRepo>()));
  sl.registerLazySingleton<AdhkarCubit>(
    () => AdhkarCubit(sl<HomeRepoAbstract>()),
  );
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit());
  sl.registerLazySingleton<UserProgressCubit>(
    () => UserProgressCubit(sl<UserDataController>(), sl<Prefs>()),
  );
  sl.registerLazySingleton<PrayerTimesCubit>(() => PrayerTimesCubit());
}

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<LocationService>(
    () => LocationService(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton(() => Prefs(prefs));
}
