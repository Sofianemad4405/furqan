import 'package:flutter/material.dart';

class Headear extends StatelessWidget {
  const Headear({super.key, required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.grey[200] : Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Track your spiritual journey',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
