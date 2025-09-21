import 'package:flutter/material.dart';
import 'package:furqan/core/design/app_design_system.dart';

class QuranTheme {
  /// Light Theme
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: QuranDesignSystem.colors.primary.emerald[500],
      scaffoldBackgroundColor: QuranDesignSystem.colors.neutral.c50,

      colorScheme: ColorScheme.light(
        primary:
            QuranDesignSystem.colors.primary.emerald[600] ?? Color(0xFF059669),
        secondary:
            QuranDesignSystem.colors.primary.teal[500] ?? Color(0xFF0d9488),
        surface: QuranDesignSystem.colors.neutral.c50,
        background: QuranDesignSystem.colors.neutral.c100,
        error: QuranDesignSystem.colors.semantic.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: QuranDesignSystem.colors.neutral.c900,
        onError: Colors.white,
      ),

      fontFamily: QuranDesignSystem.typography.fontFamilies["ui"],

      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: QuranDesignSystem.typography.fontSizes["base"],
          fontWeight: QuranDesignSystem.typography.fontWeights["normal"],
          height: QuranDesignSystem.typography.lineHeights["normal"],
          color: QuranDesignSystem.colors.neutral.c900,
        ),
        bodyMedium: TextStyle(
          fontSize: QuranDesignSystem.typography.fontSizes["sm"],
          fontWeight: QuranDesignSystem.typography.fontWeights["normal"],
          height: QuranDesignSystem.typography.lineHeights["normal"],
          color: QuranDesignSystem.colors.neutral.c800,
        ),
        titleLarge: TextStyle(
          fontSize: QuranDesignSystem.typography.fontSizes["2xl"],
          fontWeight: QuranDesignSystem.typography.fontWeights["bold"],
          height: QuranDesignSystem.typography.lineHeights["tight"],
          color: QuranDesignSystem.colors.primary.emerald[700],
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: QuranDesignSystem.colors.primary.emerald[600],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(QuranDesignSystem.radius.lg),
          ),
          padding: EdgeInsets.symmetric(
            vertical: QuranDesignSystem.spacing.values[3] ?? 12,
            horizontal: QuranDesignSystem.spacing.values[6] ?? 24,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: QuranDesignSystem.components.card.background,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            QuranDesignSystem.components.card.borderRadius,
          ),
        ),
        margin: EdgeInsets.all(QuranDesignSystem.spacing.values[4] ?? 16),
      ),
    );
  }

  /// Dark Theme
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: QuranDesignSystem.colors.primary.emerald[400],
      scaffoldBackgroundColor: QuranDesignSystem.colors.neutral.c900,

      colorScheme: ColorScheme.dark(
        primary:
            QuranDesignSystem.colors.primary.emerald[400] ?? Colors.transparent,
        secondary:
            QuranDesignSystem.colors.primary.teal[400] ?? Colors.transparent,
        surface: QuranDesignSystem.colors.neutral.c800,
        background: QuranDesignSystem.colors.neutral.c900,
        error: QuranDesignSystem.colors.semantic.error,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: QuranDesignSystem.colors.neutral.c50,
        onError: Colors.black,
      ),

      fontFamily: QuranDesignSystem.typography.fontFamilies["ui"],

      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: QuranDesignSystem.typography.fontSizes["base"],
          fontWeight: QuranDesignSystem.typography.fontWeights["normal"],
          height: QuranDesignSystem.typography.lineHeights["normal"],
          color: QuranDesignSystem.colors.neutral.c50,
        ),
        bodyMedium: TextStyle(
          fontSize: QuranDesignSystem.typography.fontSizes["sm"],
          fontWeight: QuranDesignSystem.typography.fontWeights["normal"],
          height: QuranDesignSystem.typography.lineHeights["normal"],
          color: QuranDesignSystem.colors.neutral.c200,
        ),
        titleLarge: TextStyle(
          fontSize: QuranDesignSystem.typography.fontSizes["2xl"],
          fontWeight: QuranDesignSystem.typography.fontWeights["bold"],
          height: QuranDesignSystem.typography.lineHeights["tight"],
          color: QuranDesignSystem.colors.primary.emerald[400],
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: QuranDesignSystem.colors.primary.emerald[400],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(QuranDesignSystem.radius.lg),
          ),
          padding: EdgeInsets.symmetric(
            vertical: QuranDesignSystem.spacing.values[3] ?? 12,
            horizontal: QuranDesignSystem.spacing.values[6] ?? 24,
          ),
        ),
      ),

      cardTheme: CardThemeData(
        color: QuranDesignSystem.colors.neutral.c800,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            QuranDesignSystem.components.card.borderRadius,
          ),
        ),
        margin: EdgeInsets.all(QuranDesignSystem.spacing.values[4] ?? 16),
      ),
    );
  }
}
