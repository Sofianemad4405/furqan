import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';

class AdditionalStatsCard extends StatelessWidget {
  const AdditionalStatsCard({
    super.key,
    required this.isDark,
    required this.icon,
    required this.value,
    required this.label,
  });
  final bool isDark;
  final String icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(16),
      //   border: Border.all(
      //     color: isDark
      //         ? Colors.white.withOpacity(0.1)
      //         : Colors.black.withOpacity(0.1),
      //   ),
      //   // boxShadow: [
      //   //   BoxShadow(
      //   //     color: Colors.black.withOpacity(0.1),
      //   //     blurRadius: 2,
      //   //     offset: const Offset(0, 4),
      //   //   ),
      //   // ],
      // ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey[200] : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
