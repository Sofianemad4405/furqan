import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/app/furqan.dart';
import 'package:furqan/core/themes/theme_provider.dart';

Future<void> main() async {
  runApp(
    BlocProvider(
      create: (context) => ThemeProvider(ThemeMode.light),
      child: const Furqan(),
    ),
  );
}
