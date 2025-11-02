import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/widgets/custom_nav_bar.dart';
import 'package:furqan/features/chat/presentation/screens/chat_screen.dart';
import 'package:furqan/features/home/presentation/cubit/user_progress_cubit.dart';
import 'package:furqan/features/home/presentation/screens/home_screen.dart';
import 'package:furqan/features/home/presentation/widgets/app_bar.dart';
import 'package:furqan/features/reading/presentation/screens/reading_page.dart';
import 'package:furqan/features/search/presentation/screens/search_page.dart';
import 'package:furqan/features/settings/presentation/screens/settings_screen.dart';
import 'package:furqan/features/stats/presentation/screens/stats_page.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';

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
        observers: [_RouteObserver(() => _refresh())],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => child);
        },
      ),
    );
  }

  UserProgress? userProgress;

  @override
  void initState() {
    super.initState();
    _loadUserProgress();
  }

  Future<void> _loadUserProgress() async {
    final userCubit = sl<UserProgressCubit>();

    final progress = await userCubit.getUserProgress();

    setState(() {
      userProgress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<ThemeCubit>().isDarkMood();

    // final canPop = _navKeys[_currentIndex].currentState?.canPop() ?? false;
    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? QuranAppTheme.darkScaffoldGradient
            : QuranAppTheme.lightScaffoldGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ModernAppBar(title: "FurQan"),
        extendBody: true,
        body: userProgress == null
            ? const HomeShimmer()
            : IndexedStack(
                index: _currentIndex,
                children: [
                  _buildOffstageNavigator(0, const HomeScreen()),
                  _buildOffstageNavigator(
                    1,
                    ReadingScreen(userProgress: userProgress!),
                  ),
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

class AnimatedThemeSwitcher extends StatefulWidget {
  const AnimatedThemeSwitcher({
    super.key,
    required this.isDark,
    required this.onChanged,
    this.width = 64,
    this.height = 36,
    this.duration = const Duration(milliseconds: 300),
  });

  final bool isDark;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final Duration duration;

  @override
  State<AnimatedThemeSwitcher> createState() => _AnimatedThemeSwitcherState();
}

class _AnimatedThemeSwitcherState extends State<AnimatedThemeSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.isDark ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedThemeSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDark != widget.isDark) {
      if (widget.isDark) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _controller.value = _controller.value.clamp(0.0, 1.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    final newVal = !widget.isDark;
    widget.onChanged(newVal);
  }

  @override
  Widget build(BuildContext context) {
    final double knobSize = widget.height - 8;

    return GestureDetector(
      onTap: _toggle,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = Curves.easeInOut.transform(_controller.value);

            // background color interpolates between light and dark
            final bgColor = Color.lerp(
              Colors.grey.shade300,
              Colors.indigo.shade700,
              t,
            )!.withValues(alpha: .95);

            // knob position
            final alignment = Alignment.lerp(
              Alignment.centerLeft,
              Alignment.centerRight,
              t,
            )!;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(widget.height / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12 * (t)),
                    blurRadius: 6,
                    offset: Offset(0, 2 * t),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // optional icons behind knob
                  Positioned(
                    left: 8,
                    child: Opacity(
                      opacity: 1 - t,
                      child: Icon(
                        Icons.wb_sunny,
                        size: 16,
                        color: Colors.yellow.shade700,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    child: Opacity(
                      opacity: t,
                      child: const Icon(
                        Icons.nights_stay,
                        size: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),

                  // moving knob
                  Align(
                    alignment: alignment,
                    child: Container(
                      width: knobSize,
                      height: knobSize,
                      decoration: BoxDecoration(
                        color: Color.lerp(Colors.white, Colors.black, t),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.18),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Transform.rotate(
                          angle: lerpDouble(0, 0.35, t)!,
                          child: Icon(
                            widget.isDark
                                ? Icons.nightlight_round
                                : Icons.sunny,
                            size: 16,
                            color: widget.isDark
                                ? Colors.yellow.shade600
                                : Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
