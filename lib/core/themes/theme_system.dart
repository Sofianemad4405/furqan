import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Complete Flutter Theme System for Islamic Quran App
/// Based on emerald/teal/cyan Islamic color palette with glassmorphism effects
/// This file contains all theme data and color definitions needed for the app

class QuranAppTheme {
  QuranAppTheme._();

  // ========================================
  // COLOR CONSTANTS - ISLAMIC PALETTE
  // ========================================

  // Emerald Colors (Primary Islamic Green)
  static const Color emerald50 = Color(0xFFECFDF5);
  static const Color emerald100 = Color(0xFFD1FAE5);
  static const Color emerald200 = Color(0xFFA7F3D0);
  static const Color emerald300 = Color(0xFF6EE7B7);
  static const Color emerald400 = Color(0xFF34D399);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald600 = Color(0xFF059669);
  static const Color emerald700 = Color(0xFF047857);
  static const Color emerald800 = Color(0xFF065F46);
  static const Color emerald900 = Color(0xFF064E3B);
  static const Color emerald950 = Color(0xFF022C22);
  static const Color green = Color(0xff00B578);
  static const Color containerBorderDark = Color(0xff0A0A0A);
  static const Color containerBorderLight = Color(0xffDCDCDC);
  static const Color readingModeContainerLight = Color(0xff009362);
  static const Color listeningModeContainerLight = Color(0xffA133F1);
  static const Color tafsirContainerBorderLight = Color(0xff9EEAC7);
  static const Color tafsirContainerBorderDark = Color(0xff005C42);
  static const Color tafsirSecondContainerBorderDark = Color(0xff0F1726);

  ///Azkar containers gredient
  static const List<Color> morningAzkar = [
    Color(0xFFF77900),
    Color(0xFFF7AC00),
  ];
  static const List<Color> nightAzkar = [Color(0xFF6D61F6), Color(0xFFB677FA)];
  static const List<Color> afterPrayerAzkar = [
    Color.fromARGB(255, 130, 198, 13),
    Color.fromARGB(255, 164, 166, 75),
  ];

  static const List<Color> theRest = [Color(0xFF00CE92), Color(0xFF00B9A1)];

  ///home icons containers colors (light Theme)

  static const List<Color> homeIconsContainersColorsLight = [
    Color(0xffC8F0DC),
    Color(0xffD2E1F4),
    Color(0xffF9E7F9),
  ];

  ///home icons containers colors (dark Theme)
  static const List<Color> homeIconsContainersColorsDark = [
    Color(0xff133236),
    Color(0xff1B2B4E),
    Color(0xff143236),
  ];

  // Teal Colors (Secondary Islamic Green)
  static const Color teal50 = Color(0xFFF0FDFA);
  static const Color teal100 = Color(0xFFCCFBF1);
  static const Color teal200 = Color(0xFF99F6E4);
  static const Color teal300 = Color(0xFF5EEAD4);
  static const Color teal400 = Color(0xFF2DD4BF);
  static const Color teal500 = Color(0xFF14B8A6);
  static const Color teal600 = Color(0xFF0D9488);
  static const Color teal700 = Color(0xFF0F766E);
  static const Color teal800 = Color(0xFF115E59);
  static const Color teal900 = Color(0xFF134E4A);
  static const Color teal950 = Color(0xFF042F2E);

  // Cyan Colors (Accent Blue)
  static const Color cyan50 = Color(0xFFECFEFF);
  static const Color cyan100 = Color(0xFFCFFAFE);
  static const Color cyan200 = Color(0xFFA5F3FC);
  static const Color cyan300 = Color(0xFF67E8F9);
  static const Color cyan400 = Color(0xFF22D3EE);
  static const Color cyan500 = Color(0xFF06B6D4);
  static const Color cyan600 = Color(0xFF0891B2);
  static const Color cyan700 = Color(0xFF0E7490);
  static const Color cyan800 = Color(0xFF155E75);
  static const Color cyan900 = Color(0xFF164E63);
  static const Color cyan950 = Color(0xFF083344);

  // Gray Colors (Neutral)
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray450 = Color(0xFFC2C4C7);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  static const Color gray950 = Color(0xFF030712);

  // ========================================
  // LIGHT THEME
  // ========================================

  static ThemeData get lightTheme {
    const ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      // Primary (Emerald)
      primary: emerald600,
      onPrimary: Colors.white,
      primaryContainer: emerald100,
      onPrimaryContainer: emerald900,
      // Secondary (Teal)
      secondary: teal600,
      onSecondary: Colors.white,
      secondaryContainer: teal100,
      onSecondaryContainer: teal900,
      // Tertiary (Cyan)
      tertiary: cyan600,
      onTertiary: Colors.white,
      tertiaryContainer: cyan100,
      onTertiaryContainer: cyan900,
      // Error
      error: Color(0xFFDC2626),
      onError: Colors.white,
      errorContainer: Color(0xFFFEE2E2),
      onErrorContainer: Color(0xFF7F1D1D),
      // Surface
      surface: Colors.white,
      onSurface: gray900,
      surfaceContainerHighest: gray50,
      onSurfaceVariant: gray600,
      // Outline
      outline: gray300,
      outlineVariant: gray200,
      // Others
      shadow: Colors.black26,
      scrim: Colors.black54,
      //sheikh container
      inverseSurface: Color(0xFFDCEFEC),
      //currentSurahBorder
      onInverseSurface: Color(0xFF9EEAC7),
      inversePrimary: emerald400,
      //modal bottom sheet
      surfaceTint: Color(0xff0F1726),
    );

    return ThemeData(
      fontFamilyFallback: const ['Ubuntu', 'IBM Plex Sans Arabic', 'Amiri'],
      useMaterial3: true,
      colorScheme: lightColorScheme,
      fontFamily: 'System',

      // ========================================
      // SCAFFOLD THEME
      // ========================================
      scaffoldBackgroundColor:
          Colors.transparent, // Will use gradient container
      // ========================================
      // APP BAR THEME
      // ========================================
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: gray900,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: gray900,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: gray900, size: 24),
        actionsIconTheme: IconThemeData(color: gray900, size: 24),
      ),

      // ========================================
      // CARD THEME (Glassmorphism)
      // ========================================
      cardTheme: CardThemeData(
        color: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // ========================================
      // BUTTON THEMES
      // ========================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: emerald600,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: emerald600,
          side: const BorderSide(color: emerald600, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: emerald600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // ========================================
      // INPUT THEME
      // ========================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: gray100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: emerald600, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: const TextStyle(color: gray500, fontSize: 16),
      ),

      // ========================================
      // BOTTOM NAVIGATION THEME
      // ========================================
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: emerald600,
        unselectedItemColor: gray500,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ========================================
      // TEXT THEME
      // ========================================
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: gray900,
          height: 1.2,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.3,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.3,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.4,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.4,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.4,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.5,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.5,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.5,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: gray900,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: gray900,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: gray600,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: gray900,
          height: 1.4,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: gray600,
          height: 1.4,
        ),
      ),

      // ========================================
      // DIVIDER THEME
      // ========================================
      dividerTheme: const DividerThemeData(
        color: gray200,
        thickness: 1,
        space: 1,
      ),

      // ========================================
      // CHIP THEME
      // ========================================
      chipTheme: ChipThemeData(
        backgroundColor: emerald100,
        deleteIconColor: emerald600,
        disabledColor: gray200,
        selectedColor: emerald600,
        secondarySelectedColor: emerald500,
        shadowColor: Colors.transparent,
        elevation: 0,
        labelStyle: const TextStyle(
          color: emerald900,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  // ========================================
  // DARK THEME
  // ========================================

  static ThemeData get darkTheme {
    const ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      // Primary (Emerald)
      primary: emerald500,
      onPrimary: emerald950,
      primaryContainer: emerald900,
      onPrimaryContainer: emerald200,
      // Secondary (Teal)
      secondary: teal500,
      onSecondary: teal950,
      secondaryContainer: teal900,
      onSecondaryContainer: teal200,
      // Tertiary (Cyan)
      tertiary: cyan500,
      onTertiary: cyan950,
      tertiaryContainer: cyan900,
      onTertiaryContainer: cyan200,
      // Error
      error: Color(0xFFF87171),
      onError: Color(0xFF7F1D1D),
      errorContainer: Color(0xFF7F1D1D),
      onErrorContainer: Color(0xFFFEE2E2),
      // Surface
      surface: Colors.black,
      onSurface: gray50,
      surfaceContainerHighest: gray800,
      onSurfaceVariant: gray400,
      // Outline
      outline: gray600,
      outlineVariant: gray700,
      // Others
      shadow: Colors.black54,
      scrim: Colors.black87,
      inverseSurface: Color(0xFF00231D),
      onInverseSurface: Color(0xff005C42),
      inversePrimary: emerald600,
      surfaceTint: emerald500,
    );

    return ThemeData(
      fontFamilyFallback: const ['Ubuntu', 'IBM Plex Sans Arabic'],
      useMaterial3: true,
      colorScheme: darkColorScheme,
      fontFamily: 'System',

      // ========================================
      // SCAFFOLD THEME
      // ========================================
      scaffoldBackgroundColor:
          Colors.transparent, // Will use gradient container
      // ========================================
      // APP BAR THEME
      // ========================================
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: gray50,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: gray50,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: gray50, size: 24),
        actionsIconTheme: IconThemeData(color: gray50, size: 24),
      ),

      // ========================================
      // CARD THEME (Glassmorphism)
      // ========================================
      cardTheme: CardThemeData(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.2),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          // ignore: deprecated_member_use
          side: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // ========================================
      // BUTTON THEMES
      // ========================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: emerald500,
          foregroundColor: emerald950,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: emerald500,
          side: const BorderSide(color: emerald500, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: emerald500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // ========================================
      // INPUT THEME
      // ========================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: gray800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: emerald500, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF87171), width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: const TextStyle(color: gray400, fontSize: 16),
      ),

      // ========================================
      // BOTTOM NAVIGATION THEME
      // ========================================
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: emerald500,
        unselectedItemColor: gray400,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ========================================
      // TEXT THEME
      // ========================================
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'IBM Plex Sans Arabic',
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: gray50,
          height: 1.2,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.3,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.3,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.4,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.4,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.4,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.5,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.5,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.5,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: gray50,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: gray50,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: gray400,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: gray50,
          height: 1.4,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: gray400,
          height: 1.4,
        ),
      ),

      // ========================================
      // DIVIDER THEME
      // ========================================
      dividerTheme: const DividerThemeData(
        color: gray700,
        thickness: 1,
        space: 1,
      ),

      // ========================================
      // CHIP THEME
      // ========================================
      chipTheme: ChipThemeData(
        backgroundColor: emerald900,
        deleteIconColor: emerald500,
        disabledColor: gray700,
        selectedColor: emerald500,
        secondarySelectedColor: emerald600,
        shadowColor: Colors.transparent,
        elevation: 0,
        labelStyle: const TextStyle(
          color: emerald200,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: const TextStyle(
          color: emerald950,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  // ========================================
  // GRADIENT DEFINITIONS
  // ========================================

  /// Light mode scaffold gradient (emerald-50 → teal-50 → cyan-50)
  static const LinearGradient lightScaffoldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFECFDF5), // emerald-50
      Color(0xFFCCFBF1), // teal-50
      Color(0xFFECFEFF), // cyan-50
    ],
  );

  /// Dark mode scaffold gradient (emerald-950 → teal-950 → cyan-950)
  static const LinearGradient darkScaffoldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF022C22), // emerald-950
      Color(0xFF042F2E), // teal-950
      Color(0xFF083344),
    ],

    // dark:from-emerald-950 dark:via-teal-950 dark:to-cyan-950
  );

  /// Primary emerald gradient for buttons and accents
  static const LinearGradient emeraldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald500, emerald600],
  );

  /// Secondary teal gradient
  static const LinearGradient tealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [teal500, teal600],
  );

  /// Multi-color Islamic gradient
  static const LinearGradient islamicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald500, teal500, cyan500],
  );

  // ========================================
  // STAT CARD COLORS (Hasanat, Surahs, Minutes)
  // ========================================

  // ========================================
  // GLASSMORPHISM UTILITIES
  // ========================================

  /// Light mode glass container decoration
  static BoxDecoration lightGlassDecoration({
    double borderRadius = 16.0,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? Colors.white.withValues(alpha: 0.2),
        width: 0.3,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  /// Dark mode glass container decoration
  static BoxDecoration darkGlassDecoration({
    double borderRadius = 20.0,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? Colors.black.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? Colors.white.withValues(alpha: 0.2),
        width: 0.8,
      ),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black.withValues(alpha: 0.1),
      //     blurRadius: 10,
      //     // offset: const Offset(0, 2),
      //   ),
      // ],
    );
  }

  /// Adaptive glass decoration that changes with theme
  static BoxDecoration adaptiveGlassDecoration(
    BuildContext context, {
    double borderRadius = 16.0,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? darkGlassDecoration(
            borderRadius: borderRadius,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
          )
        : lightGlassDecoration(
            borderRadius: borderRadius,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
          );
  }

  // ========================================
  // ARABIC TEXT STYLES
  // ========================================

  static const TextStyle arabicTextStyle = TextStyle(
    fontFamily: 'Amiri',
    fontSize: 24,
    height: 1.8,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle arabicLargeTextStyle = TextStyle(
    fontFamily: 'Amiri',
    fontSize: 28,
    height: 1.8,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle arabicSmallTextStyle = TextStyle(
    fontFamily: 'Amiri',
    fontSize: 20,
    height: 1.6,
    fontWeight: FontWeight.w400,
  );
}

/// Extension methods for easy theme access
extension QuranThemeExtension on BuildContext {
  /// Check if current theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get scaffold gradient based on current theme
  LinearGradient get scaffoldGradient => isDarkMode
      ? QuranAppTheme.darkScaffoldGradient
      : QuranAppTheme.lightScaffoldGradient;

  /// Get adaptive glass decoration
  BoxDecoration glassDecoration({double borderRadius = 16.0}) =>
      QuranAppTheme.adaptiveGlassDecoration(this, borderRadius: borderRadius);

  /// Get stat card colors
  // Map<String, Color> getStatCardColors(String cardType) {
  //   final colors = isDarkMode
  //       ? QuranAppTheme.darkStatCardColors
  //       : QuranAppTheme.lightStatCardColors;
  //   return colors[cardType] ?? colors['hasanat']!;
  // }
}
