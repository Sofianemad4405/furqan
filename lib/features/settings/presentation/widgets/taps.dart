import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class Taps extends StatelessWidget {
  const Taps({super.key, required this.isDark, required this.tabController});
  final bool isDark;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0x33000000) : const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0x1AFFFFFF) : const Color(0x33FFFFFF),
          width: 1,
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF10B981), const Color(0xFF059669)]
                : [const Color(0xFF059669), const Color(0xFF0D9488)],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: isDark
            ? const Color(0xFF9CA3AF)
            : const Color(0xFF6B7280),
        tabs: const [
          Tab(text: 'General'),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Iconsax.heart, size: 16), Gap(4), Text('Liked')],
            ),
          ),
        ],
      ),
    );
  }
}
