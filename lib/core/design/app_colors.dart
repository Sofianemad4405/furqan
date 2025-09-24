import 'package:flutter/material.dart';

/// Comprehensive Color System for Islamic Quran App
/// Matches the React app's emerald/teal/cyan theme with glassmorphism effects

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ========================================
  // LIGHT MODE COLORS
  // ========================================

  /// Light Mode Color Palette
  static const LightColors light = LightColors._();

  /// Dark Mode Color Palette
  static const DarkColors dark = DarkColors._();
}

/// Light Mode Colors Class
class LightColors {
  const LightColors._();

  // ========================================
  // SCAFFOLD BACKGROUND GRADIENTS
  // ========================================

  /// Main scaffold gradient colors (from-emerald-50 via-teal-50 to-cyan-50)
  static const List<Color> scaffoldGradient = [
    Color(0xFFECFDF5), // emerald-50
    Color(0xFFF0FDFA), // teal-50
    Color(0xFFECFEFF), // cyan-50
  ];

  /// Alternative gradient combinations
  static const List<Color> headerGradient = [
    Color(0xFFD1FAE5), // emerald-100
    Color(0xFFCCFBF1), // teal-100
    Color(0xFFCFFAFE), // cyan-100
  ];

  // ========================================
  // GLASS CARD COLORS
  // ========================================

  /// Glass card background with transparency
  static const Color glassCardBackground = Color(
    0x1AFFFFFF,
  ); // rgba(255, 255, 255, 0.1)

  /// Glass card border color
  static const Color glassCardBorder = Color(
    0x33FFFFFF,
  ); // rgba(255, 255, 255, 0.2)

  /// Glass card shadow color
  static const Color glassCardShadow = Color(0x1A000000); // rgba(0, 0, 0, 0.1)

  // ========================================
  // STAT CARDS (Hasanat, Surahs, Minutes)
  // ========================================

  /// Hasanat card colors
  static const Color hasanatCardBackground = Color(0xFFF0FDF4); // green-50
  static const Color hasanatCardBorder = Color(0xFFBBF7D0); // green-200
  static const Color hasanatCardIcon = Color(0xFF16A34A); // green-600
  static const Color hasanatCardText = Color(0xFF15803D); // green-700
  static const Color hasanatCardNumber = Color(0xFF166534); // green-800

  /// Surahs card colors
  static const Color surahsCardBackground = Color(0xFFECFDF5); // emerald-50
  static const Color surahsCardBorder = Color(0xFFA7F3D0); // emerald-200
  static const Color surahsCardIcon = Color(0xFF059669); // emerald-600
  static const Color surahsCardText = Color(0xFF047857); // emerald-700
  static const Color surahsCardNumber = Color(0xFF064E3B); // emerald-900

  /// Minutes card colors
  static const Color minutesCardBackground = Color(0xFFF0FDFA); // teal-50
  static const Color minutesCardBorder = Color(0xFF99F6E4); // teal-200
  static const Color minutesCardIcon = Color(0xFF0D9488); // teal-600
  static const Color minutesCardText = Color(0xFF0F766E); // teal-700
  static const Color minutesCardNumber = Color(0xFF134E4A); // teal-900

  // ========================================
  // PRAYER TIMES CARD COLORS
  // ========================================

  static const Color prayerTimeCardBackground = Color(0xFFFEFEFE);
  static const Color prayerTimeCardBorder = Color(0xFFE5E7EB);
  static const Color prayerTimeCardIcon = Color(0xFF6366F1); // indigo-500
  static const Color prayerTimeActiveText = Color(0xFF059669); // emerald-600
  static const Color prayerTimeInactiveText = Color(0xFF6B7280); // gray-500

  // ========================================
  // CHALLENGE CARD COLORS
  // ========================================

  static const Color challengeCardBackground = Color(0xFFFFFBEB); // amber-50
  static const Color challengeCardBorder = Color(0xFFFED7AA); // amber-200
  static const Color challengeCardIcon = Color(0xFFD97706); // amber-600
  static const Color challengeCardProgress = Color(0xFFEA580C); // orange-600
  static const Color challengeCardProgressBg = Color(0xFFFFEDD5); // orange-100

  // ========================================
  // NAVIGATION COLORS
  // ========================================

  /// Bottom navigation glass effect
  static const Color bottomNavBackground = Color(
    0x1AFFFFFF,
  ); // rgba(255, 255, 255, 0.1)
  static const Color bottomNavBorder = Color(
    0x33FFFFFF,
  ); // rgba(255, 255, 255, 0.2)
  static const Color bottomNavActiveIcon = Color(0xFF059669); // emerald-600
  static const Color bottomNavInactiveIcon = Color(0xFF6B7280); // gray-500
  static const Color bottomNavActiveIndicator = Color(
    0x33059669,
  ); // emerald-600 with 0.2 opacity

  // ========================================
  // BUTTON COLORS
  // ========================================

  /// Primary button (emerald)
  static const Color primaryButtonBackground = Color(0xFF059669); // emerald-600
  static const Color primaryButtonText = Color(0xFFFFFFFF);
  static const Color primaryButtonHover = Color(0xFF047857); // emerald-700

  /// Secondary button (outline)
  static const Color secondaryButtonBorder = Color(0xFF059669); // emerald-600
  static const Color secondaryButtonText = Color(0xFF059669); // emerald-600
  static const Color secondaryButtonBackground = Color(
    0x00000000,
  ); // transparent

  // ========================================
  // TEXT COLORS
  // ========================================

  static const Color primaryText = Color(0xFF1F2937); // gray-800
  static const Color secondaryText = Color(0xFF4B5563); // gray-600
  static const Color mutedText = Color(0xFF6B7280); // gray-500
  static const Color arabicText = Color(0xFF1F2937); // gray-800
  static const Color ayahNumber = Color(0xFF059669); // emerald-600

  // ========================================
  // INPUT COLORS
  // ========================================

  static const Color inputBackground = Color(0xFFF3F4F6); // gray-100
  static const Color inputBorder = Color(0xFFD1D5DB); // gray-300
  static const Color inputFocusBorder = Color(0xFF059669); // emerald-600
  static const Color inputText = Color(0xFF1F2937); // gray-800
  static const Color inputPlaceholder = Color(0xFF9CA3AF); // gray-400

  // ========================================
  // ACCENT COLORS
  // ========================================

  static const Color accent = Color(0xFF06B6D4); // cyan-500
  static const Color accentLight = Color(0xFFE0F7FA); // cyan-50
  static const Color warning = Color(0xFFF59E0B); // amber-500
  static const Color warningLight = Color(0xFFFEF3C7); // amber-100
  static const Color error = Color(0xFFEF4444); // red-500
  static const Color errorLight = Color(0xFFFEE2E2); // red-100
  static const Color success = Color(0xFF10B981); // emerald-500
  static const Color successLight = Color(0xFFD1FAE5); // emerald-100

  // ========================================
  // OVERLAY COLORS
  // ========================================

  static const Color modalOverlay = Color(0x80000000); // rgba(0, 0, 0, 0.5)
  static const Color loadingOverlay = Color(0x40000000); // rgba(0, 0, 0, 0.25)
  static const Color shimmerBase = Color(0xFFE5E7EB); // gray-200
  static const Color shimmerHighlight = Color(0xFFF3F4F6); // gray-100
}

/// Dark Mode Colors Class
class DarkColors {
  const DarkColors._();

  // ========================================
  // SCAFFOLD BACKGROUND GRADIENTS
  // ========================================

  /// Main scaffold gradient colors (from-emerald-950 via-teal-950 to-cyan-950)
  static const List<Color> scaffoldGradient = [
    Color(0xFF064E3B), // emerald-950
    Color(0xFF0F766E), // teal-950
    Color(0xFF0E7490), // cyan-950
  ];

  /// Alternative gradient combinations
  static const List<Color> headerGradient = [
    Color(0xFF065F46), // emerald-900
    Color(0xFF134E4A), // teal-900
    Color(0xFF155E75), // cyan-900
  ];

  // ========================================
  // GLASS CARD COLORS
  // ========================================

  /// Glass card background with transparency
  static const Color glassCardBackground = Color(
    0x33000000,
  ); // rgba(0, 0, 0, 0.2)

  /// Glass card border color
  static const Color glassCardBorder = Color(
    0x1AFFFFFF,
  ); // rgba(255, 255, 255, 0.1)

  /// Glass card shadow color
  static const Color glassCardShadow = Color(0x4D000000); // rgba(0, 0, 0, 0.3)

  // ========================================
  // STAT CARDS (Hasanat, Surahs, Minutes)
  // ========================================

  /// Hasanat card colors
  static const Color hasanatCardBackground = Color(0xFF14532D); // green-900
  static const Color hasanatCardBorder = Color(0xFF166534); // green-800
  static const Color hasanatCardIcon = Color(0xFF22C55E); // green-500
  static const Color hasanatCardText = Color(0xFF4ADE80); // green-400
  static const Color hasanatCardNumber = Color(0xFF86EFAC); // green-300

  /// Surahs card colors
  static const Color surahsCardBackground = Color(0xFF064E3B); // emerald-950
  static const Color surahsCardBorder = Color(0xFF065F46); // emerald-900
  static const Color surahsCardIcon = Color(0xFF10B981); // emerald-500
  static const Color surahsCardText = Color(0xFF34D399); // emerald-400
  static const Color surahsCardNumber = Color(0xFF6EE7B7); // emerald-300

  /// Minutes card colors
  static const Color minutesCardBackground = Color(0xFF0F766E); // teal-950
  static const Color minutesCardBorder = Color(0xFF134E4A); // teal-900
  static const Color minutesCardIcon = Color(0xFF14B8A6); // teal-500
  static const Color minutesCardText = Color(0xFF2DD4BF); // teal-400
  static const Color minutesCardNumber = Color(0xFF5EEAD4); // teal-300

  // ========================================
  // PRAYER TIMES CARD COLORS
  // ========================================

  static const Color prayerTimeCardBackground = Color(0xFF1F2937); // gray-800
  static const Color prayerTimeCardBorder = Color(0xFF374151); // gray-700
  static const Color prayerTimeCardIcon = Color(0xFF818CF8); // indigo-400
  static const Color prayerTimeActiveText = Color(0xFF10B981); // emerald-500
  static const Color prayerTimeInactiveText = Color(0xFF9CA3AF); // gray-400

  // ========================================
  // CHALLENGE CARD COLORS
  // ========================================

  static const Color challengeCardBackground = Color(0xFF92400E); // amber-800
  static const Color challengeCardBorder = Color(0xFFB45309); // amber-700
  static const Color challengeCardIcon = Color(0xFFFBBF24); // amber-400
  static const Color challengeCardProgress = Color(0xFFF59E0B); // amber-500
  static const Color challengeCardProgressBg = Color(0xFF78350F); // amber-900

  // ========================================
  // NAVIGATION COLORS
  // ========================================

  /// Bottom navigation glass effect
  static const Color bottomNavBackground = Color(
    0x33000000,
  ); // rgba(0, 0, 0, 0.2)
  static const Color bottomNavBorder = Color(
    0x1AFFFFFF,
  ); // rgba(255, 255, 255, 0.1)
  static const Color bottomNavActiveIcon = Color(0xFF10B981); // emerald-500
  static const Color bottomNavInactiveIcon = Color(0xFF9CA3AF); // gray-400
  static const Color bottomNavActiveIndicator = Color(
    0x3310B981,
  ); // emerald-500 with 0.2 opacity

  // ========================================
  // BUTTON COLORS
  // ========================================

  /// Primary button (emerald)
  static const Color primaryButtonBackground = Color(0xFF10B981); // emerald-500
  static const Color primaryButtonText = Color(0xFF064E3B); // emerald-950
  static const Color primaryButtonHover = Color(0xFF059669); // emerald-600

  /// Secondary button (outline)
  static const Color secondaryButtonBorder = Color(0xFF10B981); // emerald-500
  static const Color secondaryButtonText = Color(0xFF10B981); // emerald-500
  static const Color secondaryButtonBackground = Color(
    0x00000000,
  ); // transparent

  // ========================================
  // TEXT COLORS
  // ========================================

  static const Color primaryText = Color(0xFFF9FAFB); // gray-50
  static const Color secondaryText = Color(0xFFE5E7EB); // gray-200
  static const Color mutedText = Color(0xFF9CA3AF); // gray-400
  static const Color arabicText = Color(0xFFF3F4F6); // gray-100
  static const Color ayahNumber = Color(0xFF34D399); // emerald-400

  // ========================================
  // INPUT COLORS
  // ========================================

  static const Color inputBackground = Color(0xFF374151); // gray-700
  static const Color inputBorder = Color(0xFF4B5563); // gray-600
  static const Color inputFocusBorder = Color(0xFF10B981); // emerald-500
  static const Color inputText = Color(0xFFF9FAFB); // gray-50
  static const Color inputPlaceholder = Color(0xFF9CA3AF); // gray-400

  // ========================================
  // ACCENT COLORS
  // ========================================

  static const Color accent = Color(0xFF06B6D4); // cyan-500
  static const Color accentLight = Color(0xFF0E7490); // cyan-700
  static const Color warning = Color(0xFFFBBF24); // amber-400
  static const Color warningLight = Color(0xFF92400E); // amber-800
  static const Color error = Color(0xFFF87171); // red-400
  static const Color errorLight = Color(0xFF7F1D1D); // red-900
  static const Color success = Color(0xFF34D399); // emerald-400
  static const Color successLight = Color(0xFF064E3B); // emerald-950

  // ========================================
  // OVERLAY COLORS
  // ========================================

  static const Color modalOverlay = Color(0xCC000000); // rgba(0, 0, 0, 0.8)
  static const Color loadingOverlay = Color(0x66000000); // rgba(0, 0, 0, 0.4)
  static const Color shimmerBase = Color(0xFF374151); // gray-700
  static const Color shimmerHighlight = Color(0xFF4B5563); // gray-600
}

/// Utility class for glassmorphism effects
class GlassEffects {
  GlassEffects._();

  /// Light mode glass container decoration
  static BoxDecoration lightGlass({
    double borderRadius = 16.0,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? LightColors.glassCardBackground,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? LightColors.glassCardBorder,
        width: 1,
      ),
      boxShadow: const [
        BoxShadow(
          color: LightColors.glassCardShadow,
          blurRadius: 20,
          offset: Offset(0, 8),
        ),
      ],
    );
  }

  /// Dark mode glass container decoration
  static BoxDecoration darkGlass({
    double borderRadius = 16.0,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? DarkColors.glassCardBackground,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? DarkColors.glassCardBorder,
        width: 1,
      ),
      boxShadow: const [
        BoxShadow(
          color: DarkColors.glassCardShadow,
          blurRadius: 20,
          offset: Offset(0, 8),
        ),
      ],
    );
  }

  /// Adaptive glass decoration based on theme
  static BoxDecoration adaptiveGlass(
    BuildContext context, {
    double borderRadius = 16.0,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? darkGlass(
            borderRadius: borderRadius,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
          )
        : lightGlass(
            borderRadius: borderRadius,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
          );
  }
}

/// Gradient utilities for scaffold and components
class AppGradients {
  AppGradients._();

  /// Light mode scaffold gradient
  static const LinearGradient lightScaffold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: LightColors.scaffoldGradient,
  );

  /// Dark mode scaffold gradient
  static const LinearGradient darkScaffold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: DarkColors.scaffoldGradient,
  );

  /// Adaptive scaffold gradient
  static LinearGradient adaptiveScaffold(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkScaffold : lightScaffold;
  }

  /// Emerald gradient for buttons and accents
  static const LinearGradient emerald = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF10B981), // emerald-500
      Color(0xFF059669), // emerald-600
    ],
  );

  /// Teal gradient for secondary elements
  static const LinearGradient teal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF14B8A6), // teal-500
      Color(0xFF0D9488), // teal-600
    ],
  );

  /// Multi-color Islamic gradient
  static const LinearGradient islamic = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF10B981), // emerald-500
      Color(0xFF14B8A6), // teal-500
      Color(0xFF06B6D4), // cyan-500
    ],
  );
}

/// Extension methods for easy color access
extension AppColorsExtension on BuildContext {
  /// Get current theme colors
  LightColors get lightColors => AppColors.light;
  DarkColors get darkColors => AppColors.dark;

  /// Check if current theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get adaptive colors based on current theme
  Color get adaptiveGlassBackground => isDarkMode
      ? DarkColors.glassCardBackground
      : LightColors.glassCardBackground;

  Color get adaptiveGlassBorder =>
      isDarkMode ? DarkColors.glassCardBorder : LightColors.glassCardBorder;

  Color get adaptivePrimaryText =>
      isDarkMode ? DarkColors.primaryText : LightColors.primaryText;

  Color get adaptiveSecondaryText =>
      isDarkMode ? DarkColors.secondaryText : LightColors.secondaryText;

  /// Get stat card colors
  Color get hasanatCardBg => isDarkMode
      ? DarkColors.hasanatCardBackground
      : LightColors.hasanatCardBackground;

  Color get surahsCardBg => isDarkMode
      ? DarkColors.surahsCardBackground
      : LightColors.surahsCardBackground;

  Color get minutesCardBg => isDarkMode
      ? DarkColors.minutesCardBackground
      : LightColors.minutesCardBackground;

  /// Get adaptive gradient
  LinearGradient get adaptiveScaffoldGradient =>
      AppGradients.adaptiveScaffold(this);
}
