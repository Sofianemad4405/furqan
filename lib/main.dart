import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:furqan/app/furqan.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.setEffect(
    effect: WindowEffect.acrylic,
    color: Colors.transparent,
  );
  runApp(const Furqan());
}
