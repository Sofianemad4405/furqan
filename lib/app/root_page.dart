import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
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

  final _navKeys = List.generate(6, (_) => GlobalKey<NavigatorState>());

  void _refresh() => setState(() {});

  Widget _buildOffstageNavigator(int index, Widget child) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navKeys[index],
        observers: [_RouteObserver(_refresh)],
        onGenerateRoute: (settings) => MaterialPageRoute(builder: (_) => child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canPop = _navKeys[_currentIndex].currentState?.canPop() ?? false;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.watch<ThemeCubit>().isDarkMood()
              ? QuranAppTheme.darkScaffoldGradient.colors
              : QuranAppTheme.lightScaffoldGradient.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: canPop
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    _navKeys[_currentIndex].currentState?.maybePop();
                  },
                )
              : const Icon(Icons.menu),
          title: const Text("Furqan"),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.red),
              onPressed: () {
                log("toggling");
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ],
        ),
        extendBody: true,
        body: Stack(
          children: [
            _buildOffstageNavigator(0, const HomeScreen()),
            _buildOffstageNavigator(1, const ReadingScreen()),
            _buildOffstageNavigator(2, const SearchScreen()),
            _buildOffstageNavigator(3, const StatsScreen()),
            _buildOffstageNavigator(4, const ChatScreen()),
            _buildOffstageNavigator(5, const SettingsScreen()),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GlassBottomNavigation(
            activeTab: TabType.values[_currentIndex],
            onTabChange: (TabType tab) {
              if (_currentIndex == tab.index) {
                // لو دوست على نفس التاب رجع للرووت
                _navKeys[tab.index].currentState!.popUntil(
                  (route) => route.isFirst,
                );
              } else {
                setState(() {
                  _currentIndex = tab.index;
                });
              }
            },
            currentIndex: _currentIndex,
          ),
        ),
      ),
    );
  }
}

class _RouteObserver extends NavigatorObserver {
  final VoidCallback onChange;
  _RouteObserver(this.onChange);

  void _safeNotify() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange();
    });
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _safeNotify();
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _safeNotify();
    super.didPush(route, previousRoute);
  }
}
