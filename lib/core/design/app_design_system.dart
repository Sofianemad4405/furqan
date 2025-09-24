import 'package:flutter/material.dart';

/// Root Design System
class QuranDesignSystem {
  static final colors = _AppColors();
  static const typography = _AppTypography();
  static const spacing = _AppSpacing();
  static const radius = _AppRadius();
  static const shadows = _AppShadows();
  static final components = _AppComponents();
  static const animations = _AppAnimations();
  static const gradients = _AppGradients();
  static const breakpoints = _AppBreakpoints();
  static const icons = _AppIcons();
  static final islamic = _IslamicTheme();
}

/// ---------------- Colors ----------------
class _AppColors {
  _AppColors();

  final primary = const _PrimaryColors();
  final neutral = _NeutralColors();
  final semantic = _SemanticColors();
}

class _PrimaryColors {
  const _PrimaryColors();

  final emerald = const {
    50: Color(0xFFecfdf5),
    100: Color(0xFFd1fae5),
    500: Color(0xFF10b981),
    600: Color(0xFF059669),
    700: Color(0xFF047857),
  };

  final teal = const {
    50: Color(0xFFf0fdfa),
    100: Color(0xFFccfbf1),
    500: Color(0xFF14b8a6),
    600: Color(0xFF0d9488),
    700: Color(0xFF0f766e),
  };
}

class _NeutralColors {
  _NeutralColors();

  final c50 = const Color(0xFFf9fafb);
  final c100 = const Color(0xFFf3f4f6);
  final c200 = const Color(0xFFe5e7eb);
  final c400 = const Color(0xFF9ca3af);
  final c500 = const Color(0xFF6b7280);
  final c700 = const Color(0xFF374151);
  final c800 = const Color(0xFF1f2937);
  final c900 = const Color(0xFF111827);
}

class _SemanticColors {
  _SemanticColors();

  final success = const Color(0xFF10b981);
  final warning = const Color(0xFFf59e0b);
  final error = const Color(0xFFef4444);
  final info = const Color(0xFF3b82f6);
}

/// ---------------- Typography ----------------
class _AppTypography {
  const _AppTypography();

  final fontFamilies = const {"arabic": "Amiri", "ui": "system-ui"};

  final fontSizes = const {
    "xs": 12.0,
    "sm": 14.0,
    "base": 16.0,
    "lg": 18.0,
    "xl": 20.0,
    "2xl": 24.0,
    "3xl": 30.0,
  };

  final fontWeights = const {
    "normal": FontWeight.w400,
    "medium": FontWeight.w500,
    "semibold": FontWeight.w600,
    "bold": FontWeight.w700,
  };

  final lineHeights = const {"tight": 1.25, "normal": 1.5, "relaxed": 1.8};
}

/// ---------------- Spacing ----------------
class _AppSpacing {
  const _AppSpacing();

  final values = const {
    1: 4.0,
    2: 8.0,
    3: 12.0,
    4: 16.0,
    5: 20.0,
    6: 24.0,
    8: 32.0,
    10: 40.0,
    12: 48.0,
    16: 64.0,
    20: 80.0,
    24: 96.0,
  };
}

/// ---------------- Radius ----------------
class _AppRadius {
  const _AppRadius();

  final sm = 4.0;
  final md = 8.0;
  final lg = 12.0;
  final xl = 16.0;
  final x2l = 20.0;
  final full = 9999.0;
}

/// ---------------- Shadows ----------------
class _AppShadows {
  const _AppShadows();

  final BoxShadow sm = const BoxShadow(
    color: Color(0x0C000000),
    offset: Offset(0, 1),
    blurRadius: 2,
  );

  final BoxShadow md = const BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 4),
    blurRadius: 6,
  );
}

/// ---------------- Components ----------------
class _AppComponents {
  _AppComponents();

  final button = const _ButtonStyles();
  final card = const _CardStyles();
  final bottomNavigation = _BottomNavigationStyles();
  final ayahCard = _AyahCardStyles();
}

class ButtonStyleProps {
  final Color? background;
  final Gradient? gradient;
  final Color color;
  final BorderSide? border;

  const ButtonStyleProps({
    this.background,
    this.gradient,
    required this.color,
    this.border,
  });
}

class _ButtonStyles {
  const _ButtonStyles();

  final ButtonStyleProps primary = const ButtonStyleProps(
    gradient: LinearGradient(
      colors: [Color(0xFF10b981), Color(0xFF059669)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    color: Colors.white,
  );

  final ButtonStyleProps secondary = const ButtonStyleProps(
    background: Colors.transparent,
    color: Color(0xFF059669),
    border: BorderSide(color: Color(0xFF10b981), width: 2),
  );

  final ButtonStyleProps ghost = const ButtonStyleProps(
    background: Colors.transparent,
    color: Color(0xFF6b7280),
  );
}

class _CardStyles {
  const _CardStyles();

  final background = Colors.white70;
  final borderRadius = 16.0;
  final padding = 20.0;
}

class _BottomNavigationStyles {
  _BottomNavigationStyles();

  final background = Colors.white70;
  final activeColor = const Color(0xFF10b981);
  final inactiveColor = const Color(0xFF6b7280);
}

class _AyahCardStyles {
  _AyahCardStyles();

  final arabicFontSize = 24.0;
  final arabicLineHeight = 1.8;
  final translationFontSize = 16.0;
  final translationLineHeight = 1.6;
  final padding = 24.0;
  final borderRadius = 16.0;
  final background = Colors.white;
}

/// ---------------- Animations ----------------
class _AppAnimations {
  const _AppAnimations();

  final fadeIn = const {
    "duration": Duration(milliseconds: 600),
    "curve": Curves.easeOut,
  };

  final slideIn = const {
    "duration": Duration(milliseconds: 400),
    "curve": Curves.easeOut,
  };
}

/// ---------------- Gradients ----------------
class _AppGradients {
  const _AppGradients();

  final primary = const LinearGradient(
    colors: [Color(0xFF10b981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final secondary = const LinearGradient(
    colors: [Color(0xFF14b8a6), Color(0xFF0d9488)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// ---------------- Breakpoints ----------------
class _AppBreakpoints {
  const _AppBreakpoints();

  final mobile = 375.0;
  final tablet = 768.0;
  final desktop = 1024.0;
}

/// ---------------- Icons ----------------
class _AppIcons {
  const _AppIcons();

  final size = const {"sm": 16.0, "md": 20.0, "lg": 24.0, "xl": 32.0};

  final strokeWidth = 2.0;
}

/// ---------------- Islamic Theme ----------------
class _IslamicTheme {
  _IslamicTheme();

  final green = const Color(0xFF10b981);
  final gold = const Color(0xFFf59e0b);
  final cream = const Color(0xFFfef7ed);
}
