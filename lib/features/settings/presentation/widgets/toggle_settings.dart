import 'package:flutter/material.dart';

class ToggleSettings extends StatelessWidget {
  const ToggleSettings({
    super.key,
    required this.isDark,
    required this.label,
    required this.value,
    required this.onChanged,
  });
  final bool isDark;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF4B5563),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF10B981),
          activeTrackColor: const Color(0xFF34D399),
        ),
      ],
    );
  }
}
