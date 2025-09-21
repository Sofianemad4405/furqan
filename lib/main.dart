import 'package:flutter/material.dart';
import 'package:furqan/app/furqan.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

Future<void> main() async {
  runApp(const GlassMorphismThemeProvider(child: Furqan()));
}
