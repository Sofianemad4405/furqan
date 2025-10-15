import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key, required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: isDark
                  ? [const Color(0xFF34D399), const Color(0xFF2DD4BF)]
                  : [const Color(0xFF059669), const Color(0xFF0D9488)],
            ).createShader(bounds),
            child: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Gap(4),
          Text(
            'Customize your Quran experience',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }
}
