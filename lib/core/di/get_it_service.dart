import 'package:furqan/core/network/adhkar_client.dart';
import 'package:furqan/core/network/dio_factory.dart';
import 'package:furqan/core/network/retrofit_client.dart';
import 'package:furqan/core/network/tafsir_client.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:furqan/features/home/data/abstract_remote_data_source.dart';
import 'package:furqan/features/home/data/remote_data_source_impl.dart';
import 'package:furqan/features/home/domain/home_repo_abstract.dart';
import 'package:furqan/features/home/domain/home_repo_impl.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:furqan/features/reading/data/reading_data_source.dart';
import 'package:furqan/features/reading/domain/reading_repo.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<ReadingCubit>(() => ReadingCubit(sl<ReadingRepo>()));
  sl.registerLazySingleton<AdhkarCubit>(
    () => AdhkarCubit(sl<HomeRepoAbstract>()),
  );
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit());

  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<DioFactory>().getDio()),
  );

  sl.registerLazySingleton<TafsirClient>(
    () => TafsirClient(sl<DioFactory>().getDio()),
  );

  sl.registerLazySingleton<DioFactory>(() => DioFactory());

  sl.registerLazySingleton<ReadingDataSource>(
    () => ReadingDataSourceImpl(sl<ApiService>(), sl<TafsirClient>()),
  );

  sl.registerLazySingleton<AdhkarClient>(
    () => AdhkarClient(sl<DioFactory>().getDio()),
  );

  sl.registerLazySingleton<ReadingRepo>(
    () => ReadingRepoImpl(sl<ReadingDataSource>()),
  );
  sl.registerLazySingleton<HomeRepoAbstract>(
    () => HomeRepoImpl(sl<RemoteDataSource>()),
  );
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(sl<AdhkarClient>()),
  );

  ///supabase
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => Prefs(prefs));
}
