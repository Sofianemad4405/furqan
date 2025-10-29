import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SelectSetting extends StatelessWidget {
  const SelectSetting({
    super.key,
    required this.label,
    required this.isDark,
    required this.value,
    required this.options,
    required this.onChanged,
  });
  final String label;
  final bool isDark;
  final String value;
  final Map<String, String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF4B5563),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: DropdownButton<String>(
            icon: const Icon(Iconsax.arrow_down5),
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            dropdownColor: isDark
                ? const Color(0xFF1F2937)
                : const Color(0xFFFFFFFF),
            style: TextStyle(
              fontSize: 13,
              color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
            ),
            items: options.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(
                  entry.value,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
        ),
      ],
    );
  }
}
