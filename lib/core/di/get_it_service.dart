import 'package:furqan/core/network/dio_factory.dart';
import 'package:furqan/core/network/retrofit_client.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/reading/data/reading_data_source.dart';
import 'package:furqan/features/reading/domain/reading_repo.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<ReadingCubit>(() => ReadingCubit(sl<ReadingRepo>()));

  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<DioFactory>().getDio()),
  );
  sl.registerLazySingleton<DioFactory>(() => DioFactory());

  sl.registerLazySingleton<ReadingDataSource>(
    () => ReadingDataSourceImpl(sl<ApiService>()),
  );

  sl.registerLazySingleton<ReadingRepo>(
    () => ReadingRepoImpl(sl<ReadingDataSource>()),
  );
}
