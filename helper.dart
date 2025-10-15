// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'dart:math' as math;

// /// Complete Auth Screen for Quran App with Theme Toggle
// /// This is a single-file implementation matching the exact design from React/Tailwind
// class QuranAuthScreen extends StatefulWidget {
//   final Function(UserData) onAuthComplete;

//   const QuranAuthScreen({Key? key, required this.onAuthComplete})
//     : super(key: key);

//   @override
//   State<QuranAuthScreen> createState() => _QuranAuthScreenState();
// }

// class _QuranAuthScreenState extends State<QuranAuthScreen>
//     with TickerProviderStateMixin {
//   bool _isLogin = true;
//   bool _showPassword = false;
//   bool _isLoading = false;
//   bool _isDarkMode = false;
//   String? _socialLoading;

//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   late AnimationController _circle1Controller;
//   late AnimationController _circle2Controller;
//   late AnimationController _circle3Controller;
//   late AnimationController _fadeController;

//   @override
//   void initState() {
//     super.initState();
//     _initAnimations();
//   }

//   void _initAnimations() {
//     _circle1Controller = AnimationController(
//       duration: const Duration(seconds: 8),
//       vsync: this,
//     )..repeat();

//     _circle2Controller = AnimationController(
//       duration: const Duration(seconds: 6),
//       vsync: this,
//     )..repeat();

//     _circle3Controller = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     )..repeat();

//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     )..forward();
//   }

//   @override
//   void dispose() {
//     _circle1Controller.dispose();
//     _circle2Controller.dispose();
//     _circle3Controller.dispose();
//     _fadeController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _nameController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _toggleTheme() {
//     setState(() {
//       _isDarkMode = !_isDarkMode;
//     });
//   }

//   Future<void> _handleSubmit() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isLoading = true;
//     });

//     // Simulate API call
//     await Future.delayed(const Duration(milliseconds: 1500));

//     widget.onAuthComplete(
//       UserData(
//         email: _emailController.text,
//         name: _nameController.text.isEmpty
//             ? _emailController.text.split('@')[0]
//             : _nameController.text,
//       ),
//     );

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   Future<void> _handleSocialAuth(String provider) async {
//     setState(() {
//       _socialLoading = provider;
//     });

//     await Future.delayed(const Duration(milliseconds: 2000));

//     final mockUsers = {
//       'google': UserData(email: 'user@gmail.com', name: 'Google User'),
//       'facebook': UserData(email: 'user@facebook.com', name: 'Facebook User'),
//       'github': UserData(email: 'user@github.com', name: 'GitHub User'),
//     };

//     widget.onAuthComplete(mockUsers[provider]!);

//     setState(() {
//       _socialLoading = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = _isDarkMode ? _DarkColors() : _LightColors();

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Animated Background
//           _buildAnimatedBackground(colors),

//           // Main Content
//           SafeArea(
//             child: Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: FadeTransition(
//                   opacity: _fadeController,
//                   child: SlideTransition(
//                     position:
//                         Tween<Offset>(
//                           begin: const Offset(0, 0.1),
//                           end: Offset.zero,
//                         ).animate(
//                           CurvedAnimation(
//                             parent: _fadeController,
//                             curve: Curves.easeOut,
//                           ),
//                         ),
//                     child: ConstrainedBox(
//                       constraints: const BoxConstraints(maxWidth: 448),
//                       child: _buildGlassContainer(colors),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Theme Toggle Button
//           Positioned(top: 48, right: 16, child: _buildThemeToggle(colors)),
//         ],
//       ),
//     );
//   }

//   Widget _buildAnimatedBackground(ColorScheme colors) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: colors.backgroundGradient,
//         ),
//       ),
//       child: Stack(
//         children: [
//           // Circle 1
//           AnimatedBuilder(
//             animation: _circle1Controller,
//             builder: (context, child) {
//               return Positioned(
//                 top: 40,
//                 left: 40,
//                 child: Transform.rotate(
//                   angle: _circle1Controller.value * 2 * math.pi,
//                   child: Transform.scale(
//                     scale:
//                         1.0 +
//                         0.2 * math.sin(_circle1Controller.value * 2 * math.pi),
//                     child: Container(
//                       width: 128,
//                       height: 128,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [
//                             colors.circleGradient1Start,
//                             colors.circleGradient1End,
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),

//           // Circle 2
//           AnimatedBuilder(
//             animation: _circle2Controller,
//             builder: (context, child) {
//               return Positioned(
//                 top: 160,
//                 right: 64,
//                 child: Transform.rotate(
//                   angle: -_circle2Controller.value * 2 * math.pi,
//                   child: Transform.scale(
//                     scale:
//                         1.2 -
//                         0.2 * math.sin(_circle2Controller.value * 2 * math.pi),
//                     child: Container(
//                       width: 96,
//                       height: 96,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [
//                             colors.circleGradient2Start,
//                             colors.circleGradient2End,
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),

//           // Circle 3
//           AnimatedBuilder(
//             animation: _circle3Controller,
//             builder: (context, child) {
//               return Positioned(
//                 bottom: 128,
//                 left: MediaQuery.of(context).size.width * 0.25,
//                 child: Transform.translate(
//                   offset: Offset(
//                     0,
//                     -20 * math.sin(_circle3Controller.value * 2 * math.pi),
//                   ),
//                   child: Transform.scale(
//                     scale:
//                         1.0 +
//                         0.3 * math.sin(_circle3Controller.value * 2 * math.pi),
//                     child: Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [
//                             colors.circleGradient3Start,
//                             colors.circleGradient3End,
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildThemeToggle(ColorScheme colors) {
//     return TweenAnimationBuilder<double>(
//       duration: const Duration(milliseconds: 200),
//       tween: Tween(begin: 0.0, end: 1.0),
//       builder: (context, value, child) {
//         return GestureDetector(
//           onTap: _toggleTheme,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//               child: Container(
//                 width: 56,
//                 height: 56,
//                 decoration: BoxDecoration(
//                   color: colors.glassBackground,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: colors.glassBorder, width: 1),
//                   boxShadow: [
//                     BoxShadow(
//                       color: colors.buttonShadow,
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 300),
//                   transitionBuilder: (child, animation) {
//                     return RotationTransition(
//                       turns: animation,
//                       child: FadeTransition(opacity: animation, child: child),
//                     );
//                   },
//                   child: Icon(
//                     _isDarkMode
//                         ? Icons.nightlight_round
//                         : Icons.wb_sunny_rounded,
//                     key: ValueKey(_isDarkMode),
//                     color: _isDarkMode
//                         ? const Color(0xFF60A5FA)
//                         : const Color(0xFFF59E0B),
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildGlassContainer(ColorScheme colors) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(24),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//         child: Container(
//           decoration: BoxDecoration(
//             color: colors.glassBackground,
//             borderRadius: BorderRadius.circular(24),
//             border: Border.all(color: colors.glassBorder, width: 1),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 40,
//                 offset: const Offset(0, 20),
//               ),
//             ],
//           ),
//           child: Column(children: [_buildHeader(colors), _buildForm(colors)]),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(ColorScheme colors) {
//     return Container(
//       padding: const EdgeInsets.all(32),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: colors.headerGradient,
//         ),
//       ),
//       child: Column(
//         children: [
//           // Logo
//           TweenAnimationBuilder<double>(
//             duration: const Duration(milliseconds: 600),
//             tween: Tween(begin: 0.0, end: 1.0),
//             curve: Curves.elasticOut,
//             builder: (context, value, child) {
//               return Transform.scale(
//                 scale: value,
//                 child: Container(
//                   width: 64,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     gradient: const LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Color(0xFF10B981), // emerald-500
//                         Color(0xFF0D9488), // teal-600
//                       ],
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF10B981).withOpacity(0.3),
//                         blurRadius: 16,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'ق',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 16),

//           // Title
//           ShaderMask(
//             shaderCallback: (bounds) => const LinearGradient(
//               colors: [
//                 Color(0xFF059669), // emerald-600
//                 Color(0xFF0D9488), // teal-600
//               ],
//             ).createShader(bounds),
//             child: const Text(
//               'Al-Quran',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),

//           // Subtitle
//           Text(
//             _isLogin
//                 ? 'Welcome back to your spiritual journey'
//                 : 'Begin your journey with the Quran',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 14, color: colors.subtitleColor),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildForm(ColorScheme colors) {
//     return Padding(
//       padding: const EdgeInsets.all(32),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             // Social Login Buttons
//             _buildSocialButton(
//               colors: colors,
//               provider: 'google',
//               label: 'Continue with Google',
//               icon: _GoogleIcon(),
//               buttonColor: colors.googleButtonColor,
//               textColor: colors.socialButtonText,
//             ),
//             const SizedBox(height: 12),
//             _buildSocialButton(
//               colors: colors,
//               provider: 'facebook',
//               label: 'Continue with Facebook',
//               icon: const Icon(
//                 Icons.facebook,
//                 color: Color(0xFF1877F2),
//                 size: 20,
//               ),
//               buttonColor: colors.facebookButtonColor,
//               textColor: colors.facebookButtonText,
//             ),
//             const SizedBox(height: 12),
//             _buildSocialButton(
//               colors: colors,
//               provider: 'github',
//               label: 'Continue with GitHub',
//               icon: Icon(Icons.code, color: colors.githubIconColor, size: 20),
//               buttonColor: colors.githubButtonColor,
//               textColor: colors.githubButtonText,
//             ),
//             const SizedBox(height: 24),

//             // Divider
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(height: 1, color: colors.dividerColor),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     'or',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: colors.dividerTextColor,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(height: 1, color: colors.dividerColor),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Name Field (only for signup)
//             AnimatedSize(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               child: !_isLogin
//                   ? Column(
//                       children: [
//                         _buildTextField(
//                           colors: colors,
//                           controller: _nameController,
//                           hint: 'Full Name',
//                           icon: Icons.person_outline,
//                           validator: (value) {
//                             if (!_isLogin && (value == null || value.isEmpty)) {
//                               return 'Please enter your name';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//                     )
//                   : const SizedBox.shrink(),
//             ),

//             // Email Field
//             _buildTextField(
//               colors: colors,
//               controller: _emailController,
//               hint: 'Email Address',
//               icon: Icons.email_outlined,
//               keyboardType: TextInputType.emailAddress,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your email';
//                 }
//                 if (!value.contains('@')) {
//                   return 'Please enter a valid email';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),

//             // Password Field
//             _buildTextField(
//               colors: colors,
//               controller: _passwordController,
//               hint: 'Password',
//               icon: Icons.lock_outline,
//               obscureText: !_showPassword,
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   _showPassword ? Icons.visibility_off : Icons.visibility,
//                   color: colors.iconColor,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _showPassword = !_showPassword;
//                   });
//                 },
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your password';
//                 }
//                 if (value.length < 6) {
//                   return 'Password must be at least 6 characters';
//                 }
//                 return null;
//               },
//             ),

//             // Confirm Password Field (only for signup)
//             AnimatedSize(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               child: !_isLogin
//                   ? Column(
//                       children: [
//                         const SizedBox(height: 16),
//                         _buildTextField(
//                           colors: colors,
//                           controller: _confirmPasswordController,
//                           hint: 'Confirm Password',
//                           icon: Icons.lock_outline,
//                           obscureText: !_showPassword,
//                           validator: (value) {
//                             if (!_isLogin &&
//                                 value != _passwordController.text) {
//                               return 'Passwords do not match';
//                             }
//                             return null;
//                           },
//                         ),
//                       ],
//                     )
//                   : const SizedBox.shrink(),
//             ),
//             const SizedBox(height: 24),

//             // Submit Button
//             _buildSubmitButton(colors),
//             const SizedBox(height: 24),

//             // Toggle Auth Mode
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _isLogin = !_isLogin;
//                 });
//               },
//               child: RichText(
//                 text: TextSpan(
//                   style: TextStyle(fontSize: 14, color: colors.subtitleColor),
//                   children: [
//                     TextSpan(
//                       text: _isLogin
//                           ? "Don't have an account? "
//                           : "Already have an account? ",
//                     ),
//                     const TextSpan(
//                       text: ' ',
//                       style: TextStyle(
//                         color: Color(0xFF059669),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     TextSpan(
//                       text: _isLogin ? 'Sign Up' : 'Sign In',
//                       style: const TextStyle(
//                         color: Color(0xFF059669),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),

//             // Features
//             Container(
//               padding: const EdgeInsets.only(top: 24),
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(color: colors.dividerColor, width: 1),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.auto_awesome,
//                     color: Color(0xFF10B981),
//                     size: 16,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     'Sync progress across devices',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: colors.dividerTextColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialButton({
//     required ColorScheme colors,
//     required String provider,
//     required String label,
//     required Widget icon,
//     required Color buttonColor,
//     required Color textColor,
//   }) {
//     final isLoading = _socialLoading == provider;

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: _socialLoading != null
//             ? null
//             : () => _handleSocialAuth(provider),
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: buttonColor,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: colors.glassBorder, width: 1),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
//               child: Center(
//                 child: isLoading
//                     ? SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           valueColor: AlwaysStoppedAnimation<Color>(textColor),
//                         ),
//                       )
//                     : Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           icon,
//                           const SizedBox(width: 12),
//                           Text(
//                             isLoading ? 'Connecting...' : label,
//                             style: TextStyle(
//                               color: textColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required ColorScheme colors,
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//     bool obscureText = false,
//     TextInputType? keyboardType,
//     Widget? suffixIcon,
//     String? Function(String?)? validator,
//   }) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
//         child: Container(
//           decoration: BoxDecoration(
//             color: colors.inputBackground,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: colors.glassBorder, width: 1),
//           ),
//           child: TextFormField(
//             controller: controller,
//             obscureText: obscureText,
//             keyboardType: keyboardType,
//             validator: validator,
//             style: TextStyle(color: colors.textColor),
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: TextStyle(color: colors.hintColor),
//               prefixIcon: Icon(icon, color: colors.iconColor, size: 20),
//               suffixIcon: suffixIcon,
//               border: InputBorder.none,
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 14,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmitButton(ColorScheme colors) {
//     return SizedBox(
//       width: double.infinity,
//       height: 48,
//       child: ElevatedButton(
//         onPressed: (_isLoading || _socialLoading != null)
//             ? null
//             : _handleSubmit,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           padding: EdgeInsets.zero,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Ink(
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [
//                 Color(0xFF10B981), // emerald-500
//                 Color(0xFF0D9488), // teal-600
//               ],
//             ),
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF10B981).withOpacity(0.3),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Container(
//             alignment: Alignment.center,
//             child: _isLoading
//                 ? const SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   )
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         _isLogin ? 'Sign In' : 'Create Account',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       const Icon(
//                         Icons.arrow_forward,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Google Icon SVG
// class _GoogleIcon extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 20,
//       height: 20,
//       child: CustomPaint(painter: _GoogleIconPainter()),
//     );
//   }
// }

// class _GoogleIconPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..style = PaintingStyle.fill;

//     // Blue
//     paint.color = const Color(0xFF4285F4);
//     canvas.drawPath(
//       Path()
//         ..moveTo(size.width * 0.94, size.height * 0.51)
//         ..lineTo(size.width * 0.94, size.height * 0.51)
//         ..cubicTo(
//           size.width * 0.94,
//           size.height * 0.48,
//           size.width * 0.94,
//           size.height * 0.45,
//           size.width * 0.93,
//           size.height * 0.42,
//         )
//         ..lineTo(size.width * 0.50, size.height * 0.42)
//         ..lineTo(size.width * 0.50, size.height * 0.60)
//         ..lineTo(size.width * 0.75, size.height * 0.60)
//         ..cubicTo(
//           size.width * 0.74,
//           size.height * 0.66,
//           size.width * 0.70,
//           size.height * 0.71,
//           size.width * 0.66,
//           size.height * 0.74,
//         )
//         ..lineTo(size.width * 0.66, size.height * 0.86)
//         ..lineTo(size.width * 0.81, size.height * 0.86)
//         ..cubicTo(
//           size.width * 0.90,
//           size.height * 0.78,
//           size.width * 0.94,
//           size.height * 0.65,
//           size.width * 0.94,
//           size.height * 0.51,
//         )
//         ..close(),
//       paint,
//     );

//     // Green
//     paint.color = const Color(0xFF34A853);
//     canvas.drawPath(
//       Path()
//         ..moveTo(size.width * 0.50, size.height * 0.96)
//         ..cubicTo(
//           size.width * 0.62,
//           size.height * 0.96,
//           size.width * 0.73,
//           size.height * 0.92,
//           size.width * 0.81,
//           size.height * 0.86,
//         )
//         ..lineTo(size.width * 0.66, size.height * 0.74)
//         ..cubicTo(
//           size.width * 0.62,
//           size.height * 0.77,
//           size.width * 0.56,
//           size.height * 0.79,
//           size.width * 0.50,
//           size.height * 0.79,
//         )
//         ..cubicTo(
//           size.width * 0.38,
//           size.height * 0.79,
//           size.width * 0.28,
//           size.height * 0.71,
//           size.width * 0.24,
//           size.height * 0.60,
//         )
//         ..lineTo(size.width * 0.09, size.height * 0.60)
//         ..lineTo(size.width * 0.09, size.height * 0.72)
//         ..cubicTo(
//           size.width * 0.17,
//           size.height * 0.86,
//           size.width * 0.32,
//           size.height * 0.96,
//           size.width * 0.50,
//           size.height * 0.96,
//         )
//         ..close(),
//       paint,
//     );

//     // Yellow
//     paint.color = const Color(0xFFFBBC05);
//     canvas.drawPath(
//       Path()
//         ..moveTo(size.width * 0.24, size.height * 0.59)
//         ..cubicTo(
//           size.width * 0.23,
//           size.height * 0.56,
//           size.width * 0.23,
//           size.height * 0.53,
//           size.width * 0.23,
//           size.height * 0.50,
//         )
//         ..cubicTo(
//           size.width * 0.23,
//           size.height * 0.47,
//           size.width * 0.23,
//           size.height * 0.44,
//           size.width * 0.24,
//           size.height * 0.41,
//         )
//         ..lineTo(size.width * 0.24, size.height * 0.29)
//         ..lineTo(size.width * 0.09, size.height * 0.29)
//         ..cubicTo(
//           size.width * 0.06,
//           size.height * 0.36,
//           size.width * 0.04,
//           size.height * 0.43,
//           size.width * 0.04,
//           size.height * 0.50,
//         )
//         ..cubicTo(
//           size.width * 0.04,
//           size.height * 0.57,
//           size.width * 0.06,
//           size.height * 0.64,
//           size.width * 0.09,
//           size.height * 0.71,
//         )
//         ..lineTo(size.width * 0.15, size.height * 0.68)
//         ..lineTo(size.width * 0.19, size.height * 0.65)
//         ..close(),
//       paint,
//     );

//     // Red
//     paint.color = const Color(0xFFEA4335);
//     canvas.drawPath(
//       Path()
//         ..moveTo(size.width * 0.50, size.height * 0.22)
//         ..cubicTo(
//           size.width * 0.57,
//           size.height * 0.22,
//           size.width * 0.63,
//           size.height * 0.24,
//           size.width * 0.68,
//           size.height * 0.29,
//         )
//         ..lineTo(size.width * 0.81, size.height * 0.16)
//         ..cubicTo(
//           size.width * 0.73,
//           size.height * 0.09,
//           size.width * 0.62,
//           size.height * 0.04,
//           size.width * 0.50,
//           size.height * 0.04,
//         )
//         ..cubicTo(
//           size.width * 0.32,
//           size.height * 0.04,
//           size.width * 0.17,
//           size.height * 0.14,
//           size.width * 0.09,
//           size.height * 0.29,
//         )
//         ..lineTo(size.width * 0.24, size.height * 0.41)
//         ..cubicTo(
//           size.width * 0.28,
//           size.height * 0.30,
//           size.width * 0.38,
//           size.height * 0.22,
//           size.width * 0.50,
//           size.height * 0.22,
//         )
//         ..close(),
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// // Color Schemes
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

// class _LightColors implements ColorScheme {
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

// class _DarkColors implements ColorScheme {
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

// // User Data Model
// class UserData {
//   final String email;
//   final String name;

//   UserData({required this.email, required this.name});
// }

// // // Example Usage
// // void main() {
// //   runApp(const QuranAuthApp());
// // }

// // class QuranAuthApp extends StatelessWidget {
// //   const QuranAuthApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Quran Auth',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(useMaterial3: true, fontFamily: 'SF Pro'),
// //       home: QuranAuthScreen(
// //         onAuthComplete: (user) {
// //           print('User authenticated: ${user.name} (${user.email})');
// //           // Navigate to your main app
// //         },
// //       ),
// //     );
// //   }
// // }

//   // Future<AuthResponse> _googleSignIn() async {
//   //   /// TODO: update the Web client ID with your own.
//   //   ///
//   //   /// Web Client ID that you registered with Google Cloud.
//   //   const webClientId =
//   //       '885310355539-7vksih53bkloogp9mb3ra6vst8jjnsah.apps.googleusercontent.com';

//   //   /// TODO: update the iOS client ID with your own.
//   //   ///
//   //   /// iOS Client ID that you registered with Google Cloud.
//   //   // const iosClientId = 'my-ios.apps.googleusercontent.com';

//   //   // Google sign in on Android will work without providing the Android
//   //   // Client ID registered on Google Cloud.

//   //   final GoogleSignIn googleSignIn = GoogleSignIn(
//   //     // clientId: iosClientId,
//   //     serverClientId: webClientId,
//   //   );
//   //   final googleUser = await googleSignIn.signIn();
//   //   final googleAuth = await googleUser!.authentication;
//   //   final accessToken = googleAuth.accessToken;
//   //   final idToken = googleAuth.idToken;

//   //   if (accessToken == null) {
//   //     throw 'No Access Token found.';
//   //   }
//   //   if (idToken == null) {
//   //     throw 'No ID Token found.';
//   //   }

//   //   return Supabase.instance.client.auth.signInWithIdToken(
//   //     provider: OAuthProvider.google,
//   //     idToken: idToken,
//   //     accessToken: accessToken,
//   //   );
//   // }
