import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/cubit/user_progress_cubit.dart';
import 'package:furqan/features/stats/data/models/achievement.dart';
import 'package:furqan/features/stats/data/models/user_achievement.dart';
import 'package:furqan/features/stats/data/models/weekly_progress.dart';
import 'package:furqan/features/stats/presentation/widgets/achievements_grid.dart';
import 'package:furqan/features/stats/presentation/widgets/additional_stats.dart';
import 'package:furqan/features/stats/presentation/widgets/headear.dart';
import 'package:furqan/features/stats/presentation/widgets/main_stats_grid.dart';
import 'package:furqan/features/stats/presentation/widgets/quran_progress.dart';
import 'package:furqan/features/stats/presentation/widgets/weekly_activity.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:gap/gap.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _cardAnimations;

  late UserProgress userProgress;

  final List<WeeklyProgress> weeklyProgress = [
    WeeklyProgress(day: 'Mon', hasanat: 45, time: 15),
    WeeklyProgress(day: 'Tue', hasanat: 67, time: 22),
    WeeklyProgress(day: 'Wed', hasanat: 23, time: 8),
    WeeklyProgress(day: 'Thu', hasanat: 89, time: 31),
    WeeklyProgress(day: 'Fri', hasanat: 156, time: 45),
    WeeklyProgress(day: 'Sat', hasanat: 78, time: 28),
    WeeklyProgress(day: 'Sun', hasanat: 134, time: 38),
  ];

  late List<Achievement> achievements;
  late List<UserAchievement> userAchievements;

  @override
  void initState() {
    super.initState();
    _loadUserProgress();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _cardAnimations = List.generate(
      6,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.1,
            (0.6 + (index * 0.1)).clamp(0.0, 1.0),
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _controller.forward();
  }

  void _loadUserProgress() {
    if (context.read<UserProgressCubit>().state is! UserProgressLoaded) {
      context.read<UserProgressCubit>().loadUserProgress();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDarkMood();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildAnimatedWidget(_cardAnimations[0], Headear(isDark: isDark)),
            const Gap(32),

            /// Main Stats Grid
            _buildAnimatedWidget(
              _cardAnimations[1],
              MainStatsGrid(isDark: isDark, userProgress: userProgress),
            ),
            const Gap(32),
            // Quran Progress
            _buildAnimatedWidget(
              _cardAnimations[2],
              QuranProgress(isDark: isDark, userProgress: userProgress),
            ),
            const Gap(32),
            // Weekly Activity
            _buildAnimatedWidget(
              _cardAnimations[3],
              WeeklyActivity(
                isDark: isDark,
                maxHassanat: 156,
                weeklyProgress: weeklyProgress,
              ),
            ),
            const Gap(32),

            // Achievements
            _buildAnimatedWidget(
              _cardAnimations[4],
              AchievementsGrid(
                isDark: isDark,
                achievements: achievements,
                userAchievements: userAchievements,
              ),
            ),
            const Gap(32),

            // Additional Stats
            _buildAnimatedWidget(
              _cardAnimations[5],
              AdditionalStats(isDark: isDark, userProgress: userProgress),
            ),
            const Gap(100), // Bottom padding for navigation
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedWidget(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
