import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/features/auth/presentation/cubit/auth_cubit.dart';
import 'dart:ui';
import 'dart:math' as math;

import 'package:iconsax/iconsax.dart';

/// Complete Reset Password Screen for Quran App
/// Matches the exact design from React/Tailwind with glassmorphism and animations
class ResetPasswordScreen extends StatefulWidget {
  final VoidCallback onBackToLogin;

  const ResetPasswordScreen({Key? key, required this.onBackToLogin})
    : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;
  bool _isDarkMode = false;

  late AnimationController _circle1Controller;
  late AnimationController _circle2Controller;
  late AnimationController _circle3Controller;
  late AnimationController _fadeController;
  late AnimationController _successController;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _circle1Controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _circle2Controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    _circle3Controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();

    _successController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _circle1Controller.dispose();
    _circle2Controller.dispose();
    _circle3Controller.dispose();
    _fadeController.dispose();
    _successController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await context.read<AuthCubit>().resetPassword(
      email: _emailController.text,
      context: context,
    );
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isLoading = false;
      _isSuccess = true;
    });

    _successController.forward();
  }

  Future<void> _handleResend() async {
    setState(() {
      _isSuccess = false;
    });
    _successController.reset();
    await _handleSubmit();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _isDarkMode ? _DarkColors() : _LightColors();

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          _buildAnimatedBackground(colors),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: FadeTransition(
                  opacity: _fadeController,
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _fadeController,
                            curve: Curves.easeOut,
                          ),
                        ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 448),
                      child: _buildGlassContainer(colors),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Theme Toggle Button
          Positioned(top: 48, right: 16, child: _buildThemeToggle(colors)),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(ColorScheme colors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors.backgroundGradient,
        ),
      ),
      child: Stack(
        children: [
          // Circle 1
          AnimatedBuilder(
            animation: _circle1Controller,
            builder: (context, child) {
              return Positioned(
                top: 40,
                left: 40,
                child: Transform.rotate(
                  angle: _circle1Controller.value * 2 * math.pi,
                  child: Transform.scale(
                    scale:
                        1.0 +
                        0.2 * math.sin(_circle1Controller.value * 2 * math.pi),
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            colors.circleGradient1Start,
                            colors.circleGradient1End,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Circle 2
          AnimatedBuilder(
            animation: _circle2Controller,
            builder: (context, child) {
              return Positioned(
                top: 160,
                right: 64,
                child: Transform.rotate(
                  angle: -_circle2Controller.value * 2 * math.pi,
                  child: Transform.scale(
                    scale:
                        1.2 -
                        0.2 * math.sin(_circle2Controller.value * 2 * math.pi),
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            colors.circleGradient2Start,
                            colors.circleGradient2End,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Circle 3
          AnimatedBuilder(
            animation: _circle3Controller,
            builder: (context, child) {
              return Positioned(
                bottom: 128,
                left: MediaQuery.of(context).size.width * 0.25,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    -20 * math.sin(_circle3Controller.value * 2 * math.pi),
                  ),
                  child: Transform.scale(
                    scale:
                        1.0 +
                        0.3 * math.sin(_circle3Controller.value * 2 * math.pi),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            colors.circleGradient3Start,
                            colors.circleGradient3End,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(ColorScheme colors) {
    return GestureDetector(
      onTap: _toggleTheme,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colors.glassBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.glassBorder, width: 1),
              boxShadow: [
                BoxShadow(
                  color: colors.buttonShadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Icon(
                _isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                key: ValueKey(_isDarkMode),
                color: _isDarkMode
                    ? const Color(0xFF60A5FA)
                    : const Color(0xFFF59E0B),
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassContainer(ColorScheme colors) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: colors.glassBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.glassBorder, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            children: [_buildHeader(colors), _buildContent(colors)],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors.headerGradient,
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isSuccess ? _buildSuccessHeader(colors) : _buildFormHeader(),
      ),
    );
  }

  Widget _buildFormHeader() {
    return Column(
      key: const ValueKey('form'),
      children: [
        // Icon
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 600),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF10B981), // emerald-500
                      Color(0xFF0D9488), // teal-600
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Iconsax.sms, color: Colors.white, size: 32),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // Title
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFF059669), // emerald-600
              Color(0xFF0D9488), // teal-600
            ],
          ).createShader(bounds),
          child: const Text(
            'Reset Password',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle
        Text(
          'Enter your email to receive a reset link',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: _isDarkMode
                ? const Color(0xFFD1D5DB)
                : const Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessHeader(ColorScheme colors) {
    return ScaleTransition(
      scale: _successController,
      child: Column(
        key: const ValueKey('success'),
        children: [
          // Success Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF10B981), // emerald-500
                  Color(0xFF0D9488), // teal-600
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xFF059669), // emerald-600
                Color(0xFF0D9488), // teal-600
              ],
            ).createShader(bounds),
            child: const Text(
              'Check Your Email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            'We\'ve sent a password reset link to',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: _isDarkMode
                  ? const Color(0xFFD1D5DB)
                  : const Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 8),

          // Email
          Text(
            _emailController.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF059669),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isSuccess
            ? _buildSuccessContent(colors)
            : _buildFormContent(colors),
      ),
    );
  }

  Widget _buildFormContent(ColorScheme colors) {
    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey('form'),
        children: [
          // Email Field
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.inputBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.glassBorder, width: 1),
                ),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: colors.textColor),
                  decoration: InputDecoration(
                    fillColor: colors.inputBackground,
                    hintText: 'Email Address',
                    hintStyle: TextStyle(color: colors.hintColor),
                    prefixIcon: Icon(
                      Iconsax.sms,
                      color: colors.iconColor,
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Info Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF06B6D4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF06B6D4).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Text(
              'We\'ll send you an email with instructions to reset your password.',
              style: TextStyle(fontSize: 14, color: colors.subtitleColor),
            ),
          ),
          const SizedBox(height: 24),

          // Submit Button
          _buildGradientButton(
            onPressed: _isLoading ? null : _handleSubmit,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Send Reset Link',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          const SizedBox(height: 12),

          // Back to Login
          _buildOutlineButton(
            colors: colors,
            onPressed: widget.onBackToLogin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 8),
                const Text('Back to Login'),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Security Note
          _buildSecurityNote(),
        ],
      ),
    );
  }

  Widget _buildSuccessContent(ColorScheme colors) {
    return Column(
      key: const ValueKey('success'),
      children: [
        // Instructions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF10B981).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            'Click the link in the email to create a new password. The link will expire in 24 hours.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: colors.subtitleColor),
          ),
        ),
        const SizedBox(height: 24),

        // Didn't receive email
        Column(
          children: [
            Text(
              'Didn\'t receive the email?',
              style: TextStyle(fontSize: 14, color: colors.dividerTextColor),
            ),
            const SizedBox(height: 12),
            _buildOutlineButton(
              colors: colors,
              onPressed: _handleResend,
              child: const Text('Resend Email'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Back to Login
        _buildGradientButton(
          onPressed: widget.onBackToLogin,
          child: const Text(
            'Back to Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Security Note
        _buildSecurityNote(),
      ],
    );
  }

  Widget _buildGradientButton({
    required VoidCallback? onPressed,
    required Widget child,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF10B981), // emerald-500
                Color(0xFF0D9488), // teal-600
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(alignment: Alignment.center, child: child),
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required ColorScheme colors,
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: colors.inputBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.glassBorder, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: colors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: _isDarkMode
                ? const Color(0x1AFFFFFF)
                : const Color(0x33FFFFFF),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFF10B981), size: 16),
          const SizedBox(width: 8),
          Text(
            'Your data is secure and encrypted',
            style: TextStyle(
              fontSize: 12,
              color: _isDarkMode
                  ? const Color(0xFF9CA3AF)
                  : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

// Color Schemes (same as auth screen)
abstract class ColorScheme {
  List<Color> get backgroundGradient;
  List<Color> get headerGradient;
  Color get glassBackground;
  Color get glassBorder;
  Color get buttonShadow;
  Color get textColor;
  Color get subtitleColor;
  Color get hintColor;
  Color get iconColor;
  Color get inputBackground;
  Color get dividerColor;
  Color get dividerTextColor;
  Color get circleGradient1Start;
  Color get circleGradient1End;
  Color get circleGradient2Start;
  Color get circleGradient2End;
  Color get circleGradient3Start;
  Color get circleGradient3End;
}

class _LightColors implements ColorScheme {
  @override
  List<Color> get backgroundGradient => [
    const Color(0xFFECFDF5), // emerald-50
    const Color(0xFFCCFBF1), // teal-50
    const Color(0xFFECFEFF), // cyan-50
  ];

  @override
  List<Color> get headerGradient => [
    const Color(0x1A10B981), // emerald-500/10
    const Color(0x1A14B8A6), // teal-500/10
    const Color(0x1A06B6D4), // cyan-500/10
  ];

  @override
  Color get glassBackground => const Color(0x1AFFFFFF); // white/10

  @override
  Color get glassBorder => const Color(0x33FFFFFF); // white/20

  @override
  Color get buttonShadow => const Color(0x14000000);

  @override
  Color get textColor => const Color(0xFF111827); // gray-900

  @override
  Color get subtitleColor => const Color(0xFF4B5563); // gray-600

  @override
  Color get hintColor => const Color(0xFF9CA3AF); // gray-400

  @override
  Color get iconColor => const Color(0xFF9CA3AF); // gray-400

  @override
  Color get inputBackground => const Color(0x0DFFFFFF); // white/5

  @override
  Color get dividerColor => const Color(0x33FFFFFF); // white/20

  @override
  Color get dividerTextColor => const Color(0xFF6B7280); // gray-500

  @override
  Color get circleGradient1Start => const Color(0x3310B981); // emerald-400/20

  @override
  Color get circleGradient1End => const Color(0x3314B8A6); // teal-400/20

  @override
  Color get circleGradient2Start => const Color(0x3306B6D4); // cyan-400/20

  @override
  Color get circleGradient2End => const Color(0x333B82F6); // blue-400/20

  @override
  Color get circleGradient3Start => const Color(0x3314B8A6); // teal-400/20

  @override
  Color get circleGradient3End => const Color(0x3310B981); // emerald-400/20
}

class _DarkColors implements ColorScheme {
  @override
  List<Color> get backgroundGradient => [
    const Color(0xFF022C22), // emerald-950
    const Color(0xFF042F2E), // teal-950
    const Color(0xFF083344), // cyan-950
  ];

  @override
  List<Color> get headerGradient => [
    const Color(0x0D10B981), // emerald-400/5
    const Color(0x0D14B8A6), // teal-400/5
    const Color(0x0D06B6D4), // cyan-400/5
  ];

  @override
  Color get glassBackground => const Color(0x33000000); // black/20

  @override
  Color get glassBorder => const Color(0x1AFFFFFF); // white/10

  @override
  Color get buttonShadow => const Color(0x33000000);

  @override
  Color get textColor => const Color(0xFFF9FAFB); // gray-50

  @override
  Color get subtitleColor => const Color(0xFFD1D5DB); // gray-300

  @override
  Color get hintColor => const Color(0xFF9CA3AF); // gray-400

  @override
  Color get iconColor => const Color(0xFF9CA3AF); // gray-400

  @override
  Color get inputBackground => const Color(0x1A000000); // black/10

  @override
  Color get dividerColor => const Color(0x1AFFFFFF); // white/10

  @override
  Color get dividerTextColor => const Color(0xFF9CA3AF); // gray-400

  @override
  Color get circleGradient1Start => const Color(0x3310B981); // emerald-400/20

  @override
  Color get circleGradient1End => const Color(0x3314B8A6); // teal-400/20

  @override
  Color get circleGradient2Start => const Color(0x3306B6D4); // cyan-400/20

  @override
  Color get circleGradient2End => const Color(0x333B82F6); // blue-400/20

  @override
  Color get circleGradient3Start => const Color(0x3314B8A6); // teal-400/20

  @override
  Color get circleGradient3End => const Color(0x3310B981); // emerald-400/20
}
