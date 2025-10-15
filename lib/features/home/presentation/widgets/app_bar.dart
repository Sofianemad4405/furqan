import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';

/// Modern Glassmorphic App Bar for Quran App
/// Matches the exact design from React/Tailwind ModernAppBar component
///
/// Features:
/// - Glassmorphism effect with backdrop blur
/// - Theme toggle (Light/Dark)
/// - Language selector with 5 languages
/// - Animated sparkle effects
/// - Gradient overlay
/// - Professional logo with Arabic letter
class ModernAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showLanguageToggle;
  final VoidCallback? onMenuClick;
  final ValueChanged<bool>? onThemeChanged;
  final ValueChanged<String>? onLanguageChanged;
  final bool isDarkMode;
  final String currentLanguage;

  const ModernAppBar({
    super.key,
    this.title = 'FurQan',
    this.showLanguageToggle = true,
    this.onMenuClick,
    this.onThemeChanged,
    this.onLanguageChanged,
    this.isDarkMode = false,
    this.currentLanguage = 'en',
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<ModernAppBar> createState() => _ModernAppBarState();
}

class _ModernAppBarState extends State<ModernAppBar>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _sparkle1Controller;
  late AnimationController _sparkle2Controller;
  late AnimationController _flagController;

  final List<Language> _languages = [
    Language(code: 'en', name: 'English', flag: '🇺🇸', shortName: 'EN'),
    Language(code: 'ar', name: 'العربية', flag: '🇸🇦', shortName: 'AR'),
    Language(code: 'ur', name: 'اردو', flag: '🇵🇰', shortName: 'UR'),
    Language(code: 'bn', name: 'বাংলা', flag: '🇧🇩', shortName: 'BN'),
    Language(code: 'uz', name: 'O\'zbek', flag: '🇺🇿', shortName: 'UZ'),
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _gradientController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _sparkle1Controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _sparkle2Controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _flagController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _sparkle1Controller.dispose();
    _sparkle2Controller.dispose();
    _flagController.dispose();
    super.dispose();
  }

  void _handleThemeToggle() {
    context.read<ThemeCubit>().toggleTheme();
  }

  Language get _currentLanguage {
    return _languages.firstWhere(
      (lang) => lang.code == widget.currentLanguage,
      orElse: () => _languages[0],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        final isDark = state == ThemeMode.dark;
        return Padding(
          padding: const EdgeInsets.only(top: 32),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, -50 * (1 - value)),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? const Color(0x1AFFFFFF) // white/10
                        : const Color(0x4DFFFFFF), // white/30
                    width: 1,
                  ),
                ),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0x99000000) // black/60
                          : const Color(0xCCFFFFFF), // white/80
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? const Color(0x1A10B981) // emerald-400/10
                              : const Color(0x0D10B981), // emerald-500/5
                          blurRadius: 40,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Animated Gradient Overlay
                        _buildGradientOverlay(),

                        // Sparkle Effects
                        _buildSparkles(),

                        // Main Content
                        _buildContent(isDark),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGradientOverlay() {
    return AnimatedBuilder(
      animation: _gradientController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1 + (_gradientController.value * 2), 0),
              end: Alignment(1 + (_gradientController.value * 2), 0),
              colors: widget.isDarkMode
                  ? [
                      const Color(0x0D10B981), // emerald-300/5
                      const Color(0x0D14B8A6), // teal-300/5
                      const Color(0x0D06B6D4), // cyan-300/5
                    ]
                  : [
                      const Color(0x1A10B981), // emerald-400/10
                      const Color(0x0D14B8A6), // teal-400/5
                      const Color(0x1A06B6D4), // cyan-400/10
                    ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSparkles() {
    return Stack(
      children: [
        // Sparkle 1
        AnimatedBuilder(
          animation: _sparkle1Controller,
          builder: (context, child) {
            final scale =
                1.0 + 0.5 * math.sin(_sparkle1Controller.value * 2 * math.pi);
            final opacity =
                0.6 + 0.4 * math.sin(_sparkle1Controller.value * 2 * math.pi);

            return Positioned(
              top: 8,
              right: 64,
              child: Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981), // emerald-400
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Sparkle 2
        AnimatedBuilder(
          animation: _sparkle2Controller,
          builder: (context, child) {
            final scale =
                1.0 + 1.0 * math.sin(_sparkle2Controller.value * 2 * math.pi);
            final opacity =
                0.4 + 0.4 * math.sin(_sparkle2Controller.value * 2 * math.pi);

            return Positioned(
              top: 16,
              left: 80,
              child: Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 2,
                    height: 2,
                    decoration: const BoxDecoration(
                      color: Color(0xFF14B8A6), // teal-400
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContent(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          // Logo Section
          Expanded(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              tween: Tween(begin: 0.0, end: 1.0),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(-20 * (1 - value), 0),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: Row(
                children: [
                  // Logo
                  _buildLogo(),
                  const SizedBox(width: 16),

                  // Title
                  _buildTitle(isDark),
                ],
              ),
            ),
          ),

          // Controls Section
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 600),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(20 * (1 - value), 0),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Row(
              children: [
                // Language Selector
                if (widget.showLanguageToggle) ...[
                  _buildLanguageButton(isDark),
                  const SizedBox(width: 12),
                ],

                // Theme Toggle
                _buildThemeButton(isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: widget.onMenuClick,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF059669), // emerald-600
              Color(0xFF0D9488), // teal-600
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'ق',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark
                ? const Color(0xFFE5E7EB) // gray-200
                : const Color(0xFF1F2937), // gray-800
          ),
        ),
        Text(
          'Digital Companion',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: isDark
                ? const Color(0xFF9CA3AF) // gray-400
                : const Color(0xFF4B5563), // gray-600
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageButton(bool isDark) {
    return GestureDetector(
      onTap: () => _showLanguageMenu(context),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0x33000000) // black/20
              : const Color(0x33FFFFFF), // white/20
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? const Color(0x1AFFFFFF) // white/10
                : const Color(0x4DFFFFFF), // white/30
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Row(
              children: [
                // Animated Flag
                AnimatedBuilder(
                  animation: _flagController,
                  builder: (context, child) {
                    final rotation =
                        math.sin(_flagController.value * 2 * math.pi) *
                        0.174533; // 10 degrees in radians
                    return Transform.rotate(
                      angle: rotation,
                      child: Text(
                        _currentLanguage.flag,
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),

                // Short Name
                Text(
                  _currentLanguage.shortName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? const Color(0xFFE2E8F0) // slate-200
                        : const Color(0xFF334155), // slate-700
                  ),
                ),
                const SizedBox(width: 4),

                // Globe Icon
                Icon(
                  Icons.language,
                  size: 16,
                  color: isDark
                      ? const Color(0xFFCBD5E1) // slate-300
                      : const Color(0xFF475569), // slate-600
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeButton(bool isDark) {
    return GestureDetector(
      onTap: _handleThemeToggle,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0x33000000) // black/20
              : const Color(0x33FFFFFF), // white/20
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? const Color(0x1AFFFFFF) // white/10
                : const Color(0x4DFFFFFF), // white/30
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Stack(
              children: [
                // Glow Effect
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              const Color(0x3360A5FA), // blue-400/20
                              const Color(0x33A855F7), // purple-400/20
                            ]
                          : [
                              const Color(0x33FBBF24), // yellow-400/20
                              const Color(0x33FB923C), // orange-400/20
                            ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                // Icon
                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: Tween<double>(
                          begin: widget.isDarkMode ? -0.5 : 0.5,
                          end: 0.0,
                        ).animate(animation),
                        child: ScaleTransition(scale: animation, child: child),
                      );
                    },
                    child: Icon(
                      isDark ? Icons.wb_sunny : Icons.nightlight_round,
                      key: ValueKey(isDark),
                      size: 20,
                      color: isDark
                          ? const Color(0xFFFBBF24) // amber-500
                          : const Color(0xFF475569), // slate-600
                    ),
                  ),
                ),

                // Sparkle Animation
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageMenu(BuildContext context) {
    final isDark = widget.isDarkMode;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xCC000000) // black/80
                    : const Color(0xE6FFFFFF), // white/90
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? const Color(0x1AFFFFFF) // white/10
                        : const Color(0x4DFFFFFF), // white/30
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Handle
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0x4DFFFFFF)
                              : const Color(0x33000000),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // Languages
                      ..._languages.asMap().entries.map((entry) {
                        final index = entry.key;
                        final lang = entry.value;
                        final isSelected = widget.currentLanguage == lang.code;

                        return TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 200 + (index * 50)),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, -10 * (1 - value)),
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                widget.onLanguageChanged?.call(lang.code);
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0x0D10B981)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      lang.flag,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        lang.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: isDark
                                              ? const Color(0xFFE5E7EB)
                                              : const Color(0xFF1F2937),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      lang.shortName,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? const Color(0xFF9CA3AF)
                                            : const Color(0xFF6B7280),
                                      ),
                                    ),
                                    if (isSelected) ...[
                                      const SizedBox(width: 8),
                                      const Text(
                                        '✓',
                                        style: TextStyle(
                                          color: Color(0xFF10B981),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Language Model
class Language {
  final String code;
  final String name;
  final String flag;
  final String shortName;

  Language({
    required this.code,
    required this.name,
    required this.flag,
    required this.shortName,
  });
}
