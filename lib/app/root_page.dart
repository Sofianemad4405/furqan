import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/theme_provider.dart';
import 'package:furqan/core/themes/theme_system.dart';
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.watch<ThemeProvider>().isDarkMode
              ? QuranAppTheme.darkScaffoldGradient.colors
              : QuranAppTheme.lightScaffoldGradient.colors,
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
        ),
      ),
      child: Scaffold(
        extendBody: true,
        body: _currentIndex == 0
            ? const HomeScreen()
            : _currentIndex == 1
            ? const ReadingScreen()
            : _currentIndex == 2
            ? const SearchScreen()
            : _currentIndex == 3
            ? const StatsScreen()
            : _currentIndex == 4
            ? const ChatScreen()
            : const SettingsScreen(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GlassBottomNavigation(
            activeTab: TabType.values[_currentIndex],
            onTabChange: (TabType tab) {
              log(tab.name);
              setState(() {
                _currentIndex = tab.index;
              });
            },
            currentIndex: _currentIndex,
          ),
        ),
      ),
    );
  }
}
