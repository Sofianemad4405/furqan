import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/widgets/shimmer_container.dart';
import 'package:furqan/features/home/presentation/cubit/user_progress_cubit.dart';
import 'package:furqan/features/home/presentation/widgets/current_streak.dart';
import 'package:furqan/features/home/presentation/widgets/current_streak_shimmer.dart';
import 'package:furqan/features/home/presentation/widgets/home_header.dart';
import 'package:furqan/features/home/presentation/widgets/home_stats.dart';
import 'package:furqan/features/home/presentation/widgets/home_stats_shimmer.dart';
import 'package:furqan/features/home/presentation/widgets/main_challenges_grid_shimmer.dart';
import 'package:furqan/features/home/presentation/widgets/main_challenges_grid_view.dart';
import 'package:furqan/features/home/presentation/widgets/today.dart';
import 'package:furqan/features/home/presentation/widgets/today_challenges_list_view.dart';
import 'package:furqan/features/home/presentation/widgets/today_challenges_shimmer.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:furqan/features/user_data/services/user_progress_service.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    context.read<UserProgressCubit>().init();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // نازل من تحت شوية
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProgressCubit, UserProgresState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserProgressLoaded) {
          _controller.forward();
          return RefreshIndicator(
            onRefresh: () async {
              context.read<UserProgressCubit>().init();
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
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
                          HomeStats(userProgress: state.userProgress),
                          const Gap(30),

                          ///Today Challenges List View
                          Text(
                            "Today's Challenges",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Gap(10),
                          TodayChallengesListView(
                            userProgress: state.userProgress,
                          ),
                          const Gap(20),

                          ///Current Streak
                          CurrentStreak(userProgress: state.userProgress),
                          const Gap(20),

                          ///Main Challenges Grid View
                          const MainChallengesGridView(),
                          const Gap(120),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is UserProgressLoading) {
          return const HomeShimmer();
        } else {
          return const Center(child: Text("Error"));
        }
      },
    );
  }
}

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerContainer(height: 60), // Header
              Gap(20),
              HomeStatsShimmer(),
              Gap(30),
              ShimmerContainer(height: 40), // "Today's Challenges"
              Gap(10),
              TodayChallengesShimmer(),
              Gap(20),
              CurrentStreakShimmer(),
              Gap(20),
              MainChallengesGridShimmer(),
            ],
          ),
        ),
      ),
    );
  }
}
