import 'package:flutter/material.dart';
import 'package:furqan/features/settings/data/models/quick_action.dart';
import 'package:furqan/features/settings/presentation/widgets/glass_card.dart';
import 'package:furqan/features/settings/presentation/widgets/quick_action_button.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key, required this.isDark, required this.actions});
  final bool isDark;
  final List<QuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: actions.map((action) {
              return _buildQuickActionButton(isDark, action);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(bool isDark, QuickAction action) {
    return QuickActionButton(isDark: isDark, action: action);
  }
}
