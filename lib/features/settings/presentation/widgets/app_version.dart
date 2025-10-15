import 'package:flutter/material.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key, required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'FurQan v1.0.0',
          style: TextStyle(
            fontSize: 12,
            color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Made with ❤️ for the Muslim community',
          style: TextStyle(
            fontSize: 10,
            color: isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB),
          ),
        ),
      ],
    );
  }
}
