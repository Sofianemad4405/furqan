import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/app/furqan.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';

Future<void> main() async {
  init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ThemeCubit>()),
        BlocProvider(create: (context) => sl<ReadingCubit>()),
        BlocProvider(create: (context) => sl<AdhkarCubit>()),
      ],
      child: const Furqan(),
    ),
  );
}
