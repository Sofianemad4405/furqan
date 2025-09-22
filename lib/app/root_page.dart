import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_modes.dart';
import 'package:furqan/core/widgets/custom_nav_bar.dart';
import 'package:furqan/features/chat/presentation/screens/chat_screen.dart';
import 'package:furqan/features/home/presentation/screens/home_screen.dart';
import 'package:furqan/features/reading/presentation/screens/reading_page.dart';
import 'package:furqan/features/search/presentation/screens/search_page.dart';
import 'package:furqan/features/settings/presentation/screens/settings_page.dart';
import 'package:furqan/features/stats/presentation/screens/stats_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      isDarkMode: true,
      body: _currentIndex == 0
          ? HomeScreen()
          : _currentIndex == 1
          ? ReadingScreen()
          : _currentIndex == 2
          ? SearchScreen()
          : _currentIndex == 3
          ? StatsScreen()
          : _currentIndex == 4
          ? ChatScreen()
          : SettingsScreen(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: 100,
        child: GlassBottomNavigation(
          activeTab: TabType.values[_currentIndex],
          onTabChange: (TabType tab) {
            setState(() {
              _currentIndex = tab.index;
            });
          },
          currentIndex: _currentIndex,
        ),
      ),
    );
  }
}
