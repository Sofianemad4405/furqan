// import 'dart:ui';

// abstract class ColorScheme {
//   List<Color> get backgroundGradient;
//   List<Color> get headerGradient;
//   Color get glassBackground;
//   Color get glassBorder;
//   Color get buttonShadow;
//   Color get textColor;
//   Color get subtitleColor;
//   Color get hintColor;
//   Color get iconColor;
//   Color get inputBackground;
//   Color get dividerColor;
//   Color get dividerTextColor;
//   Color get googleButtonColor;
//   Color get facebookButtonColor;
//   Color get githubButtonColor;
//   Color get socialButtonText;
//   Color get facebookButtonText;
//   Color get githubButtonText;
//   Color get githubIconColor;
//   Color get circleGradient1Start;
//   Color get circleGradient1End;
//   Color get circleGradient2Start;
//   Color get circleGradient2End;
//   Color get circleGradient3Start;
//   Color get circleGradient3End;
// }

// class LightColors implements ColorScheme {
//   @override
//   List<Color> get backgroundGradient => [
//     const Color(0xFFECFDF5), // emerald-50
//     const Color(0xFFCCFBF1), // teal-50
//     const Color(0xFFECFEFF), // cyan-50
//   ];

//   @override
//   List<Color> get headerGradient => [
//     const Color(0x1A10B981), // emerald-500/10
//     const Color(0x1A14B8A6), // teal-500/10
//     const Color(0x1A06B6D4), // cyan-500/10
//   ];

//   @override
//   Color get glassBackground => const Color(0x1AFFFFFF); // white/10

//   @override
//   Color get glassBorder => const Color(0x33FFFFFF); // white/20

//   @override
//   Color get buttonShadow => const Color(0x14000000);

//   @override
//   Color get textColor => const Color(0xFF111827); // gray-900

//   @override
//   Color get subtitleColor => const Color(0xFF4B5563); // gray-600

//   @override
//   Color get hintColor => const Color(0xFF9CA3AF); // gray-400

//   @override
//   Color get iconColor => const Color(0xFF9CA3AF); // gray-400

//   @override
//   Color get inputBackground => const Color(0x0DFFFFFF); // white/5

//   @override
//   Color get dividerColor => const Color(0x33FFFFFF); // white/20

//   @override
//   Color get dividerTextColor => const Color(0xFF6B7280); // gray-500

//   @override
//   Color get googleButtonColor => const Color(0x0DFFFFFF); // white/5

//   @override
//   Color get facebookButtonColor => const Color(0x1A3B82F6); // blue-500/10

//   @override
//   Color get githubButtonColor => const Color(0x1A1F2937); // gray-800/10

//   @override
//   Color get socialButtonText => const Color(0xFF374151); // gray-700

//   @override
//   Color get facebookButtonText => const Color(0xFF2563EB); // blue-600

//   @override
//   Color get githubButtonText => const Color(0xFF1F2937); // gray-800

//   @override
//   Color get githubIconColor => const Color(0xFF1F2937); // gray-800

//   @override
//   Color get circleGradient1Start => const Color(0x3310B981); // emerald-400/20

//   @override
//   Color get circleGradient1End => const Color(0x3314B8A6); // teal-400/20

//   @override
//   Color get circleGradient2Start => const Color(0x3306B6D4); // cyan-400/20

//   @override
//   Color get circleGradient2End => const Color(0x333B82F6); // blue-400/20

//   @override
//   Color get circleGradient3Start => const Color(0x3314B8A6); // teal-400/20

//   @override
//   Color get circleGradient3End => const Color(0x3310B981); // emerald-400/20
// }

// class DarkColors implements ColorScheme {
//   @override
//   List<Color> get backgroundGradient => [
//     const Color(0xFF022C22), // emerald-950
//     const Color(0xFF042F2E), // teal-950
//     const Color(0xFF083344), // cyan-950
//   ];

//   @override
//   List<Color> get headerGradient => [
//     const Color(0x0D10B981), // emerald-400/5
//     const Color(0x0D14B8A6), // teal-400/5
//     const Color(0x0D06B6D4), // cyan-400/5
//   ];

//   @override
//   Color get glassBackground => const Color(0x33000000); // black/20

//   @override
//   Color get glassBorder => const Color(0x1AFFFFFF); // white/10

//   @override
//   Color get buttonShadow => const Color(0x33000000);

//   @override
//   Color get textColor => const Color(0xFFF9FAFB); // gray-50

//   @override
//   Color get subtitleColor => const Color(0xFFD1D5DB); // gray-300

//   @override
//   Color get hintColor => const Color(0xFF9CA3AF); // gray-400

//   @override
//   Color get iconColor => const Color(0xFF9CA3AF); // gray-400

//   @override
//   Color get inputBackground => const Color(0x1A000000); // black/10

//   @override
//   Color get dividerColor => const Color(0x1AFFFFFF); // white/10

//   @override
//   Color get dividerTextColor => const Color(0xFF9CA3AF); // gray-400

//   @override
//   Color get googleButtonColor => const Color(0x1A000000); // black/10

//   @override
//   Color get facebookButtonColor => const Color(0x333B82F6); // blue-500/20

//   @override
//   Color get githubButtonColor => const Color(0x1AE5E7EB); // gray-200/10

//   @override
//   Color get socialButtonText => const Color(0xFFE5E7EB); // gray-200

//   @override
//   Color get facebookButtonText => const Color(0xFF60A5FA); // blue-400

//   @override
//   Color get githubButtonText => const Color(0xFFE5E7EB); // gray-200

//   @override
//   Color get githubIconColor => const Color(0xFFE5E7EB); // gray-200

//   @override
//   Color get circleGradient1Start => const Color(0x3310B981); // emerald-400/20

//   @override
//   Color get circleGradient1End => const Color(0x3314B8A6); // teal-400/20

//   @override
//   Color get circleGradient2Start => const Color(0x3306B6D4); // cyan-400/20

//   @override
//   Color get circleGradient2End => const Color(0x333B82F6); // blue-400/20

//   @override
//   Color get circleGradient3Start => const Color(0x3314B8A6); // teal-400/20

//   @override
//   Color get circleGradient3End => const Color(0x3310B981); // emerald-400/20
// }
