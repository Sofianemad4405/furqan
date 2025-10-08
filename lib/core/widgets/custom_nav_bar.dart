import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furqan/core/design/app_design_system.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/utils/constants_imgs.dart';

enum TabType { home, reading, search, stats, chat, settings }

class GlassBottomNavigation extends StatelessWidget {
  final TabType activeTab;
  final Function(TabType) onTabChange;
  final int currentIndex;

  const GlassBottomNavigation({
    super.key,
    required this.activeTab,
    required this.onTabChange,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'id': TabType.home, 'iconPath': ConstantsImgs.homeIcon, 'label': 'Home'},
      {
        'id': TabType.reading,
        'iconPath': ConstantsImgs.readingIcon,
        'label': 'Reading',
      },
      {
        'id': TabType.search,
        'iconPath': ConstantsImgs.searchIcon,
        'label': 'Search',
      },
      {
        'id': TabType.stats,
        'iconPath': ConstantsImgs.statsIcon,
        'label': 'Stats',
      },
      {'id': TabType.chat, 'iconPath': ConstantsImgs.chatIcon, 'label': 'Chat'},
      {
        'id': TabType.settings,
        'iconPath': ConstantsImgs.settingsIcon,
        'label': 'Settings',
      },
    ];

    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: QuranAppTheme.darkGlassDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.1),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(
                      0xFF10B981,
                    ).withValues(alpha: 0.04, colorSpace: ColorSpace.displayP3),
                    const Color(
                      0xFF14B8A6,
                    ).withValues(alpha: 0.04, colorSpace: ColorSpace.displayP3),
                    const Color(
                      0xFF06B6D4,
                    ).withValues(alpha: 0.04, colorSpace: ColorSpace.displayP3),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: tabs.map((tab) {
                    final isActive = activeTab == tab['id'];
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTabChange(tab['id'] as TabType),
                        child: AnimatedContainer(
                          height: 65,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: isActive
                                ? QuranDesignSystem
                                      .components
                                      .bottomNavigation
                                      .activeColor
                                      .withValues(alpha: 0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            // gradient: isActive
                            //     ? LinearGradient(
                            //         begin: Alignment.topLeft,
                            //         end: Alignment.bottomRight,
                            //         colors: [
                            //           const Color(
                            //             0xFF10B981,
                            //           ).withValues(alpha: 0.7),
                            //           const Color(
                            //             0xFF14B8A6,
                            //           ).withValues(alpha: 0.7),
                            //         ],
                            //       )
                            //     : null,
                            // boxShadow: isActive
                            //     ? [
                            //         BoxShadow(
                            //           color: const Color(
                            //             0xFF10B981,
                            //           ).withValues(alpha: 0.3),
                            //           blurRadius: 0.4,
                            //           offset: const Offset(0, 2),
                            //         ),
                            //       ]
                            //     : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 4,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    child: SvgPicture.asset(
                                      height: 20,
                                      width: 20,
                                      tab['iconPath'] as String,
                                      colorFilter: ColorFilter.mode(
                                        isActive
                                            ? QuranDesignSystem
                                                  .components
                                                  .bottomNavigation
                                                  .activeColor
                                            : QuranDesignSystem
                                                  .components
                                                  .bottomNavigation
                                                  .inactiveColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 300),
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: isActive
                                          ? FontWeight.w800
                                          : FontWeight.w600,
                                      color: isActive
                                          ? QuranDesignSystem
                                                .components
                                                .bottomNavigation
                                                .activeColor
                                          : Theme.of(context).brightness ==
                                                Brightness.dark
                                          ? Colors.grey[400]
                                          : Colors.grey[600],
                                    ),
                                    child: Text(tab['label'] as String),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
