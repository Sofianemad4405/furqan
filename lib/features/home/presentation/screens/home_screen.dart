import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/widgets/current_streak.dart';
import 'package:furqan/features/home/presentation/widgets/home_header.dart';
import 'package:furqan/features/home/presentation/widgets/home_stats.dart';
import 'package:furqan/features/home/presentation/widgets/main_challenges_grid_view.dart';
import 'package:furqan/features/home/presentation/widgets/today.dart';
import 'package:furqan/features/home/presentation/widgets/today_challenges_list_view.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              const HomeHeader(),
              const Gap(10),

              ///Today View
              const Today(),
              const Gap(40),

              //// Home Stats
              const HomeStats(),
              const Gap(30),

              ///Today Challenges List View
              Text(
                "Today's Challenges",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(10),
              const TodayChallengesListView(),
              const Gap(20),

              ///Current Streak
              const CurrentStreak(),
              const Gap(20),

              ///Main Challenges Grid View
              const MainChallengesGridView(),
              const Gap(120),
            ],
          ),
        ),
      ),
    );
  }
}
