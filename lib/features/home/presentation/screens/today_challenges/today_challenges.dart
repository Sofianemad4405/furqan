import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/features/home/presentation/cubit/user_progress_cubit.dart';
import 'package:furqan/features/home/presentation/screens/today_challenges/widgets/challeange.dart';
import 'package:furqan/features/home/presentation/screens/today_challenges/widgets/header.dart';
import 'package:furqan/features/home/presentation/screens/today_challenges/widgets/streak.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class TodayChallenges extends StatefulWidget {
  const TodayChallenges({super.key});

  @override
  State<TodayChallenges> createState() => _TodayChallengesState();
}

class _TodayChallengesState extends State<TodayChallenges> {
  @override
  void initState() {
    super.initState();
    context.read<UserProgressCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserProgressCubit, UserProgresState>(
        builder: (context, state) {
          if (state is UserProgressLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Gap(MediaQuery.of(context).padding.top + 20),

                    ///Header
                    Header(
                      totalChallenges: 3,
                      completedChallenges: state.userDailyChallenges
                          .where(
                            (challenge) =>
                                challenge.completed >=
                                state.todayChallenges
                                    .firstWhere(
                                      (tc) => tc.id == challenge.challengeId,
                                    )
                                    .target,
                          )
                          .length,
                    ),
                    const Gap(20),
                    const Divider(),
                    const Gap(20),

                    //streak and completed
                    Streak(
                      currentStreak: state.userProgress.currentStreak,
                      challengesCompleted: state.userDailyChallenges
                          .where(
                            (challenge) =>
                                challenge.completed >=
                                state.todayChallenges
                                    .firstWhere(
                                      (tc) => tc.id == challenge.challengeId,
                                    )
                                    .target,
                          )
                          .length,
                    ),
                    const Gap(20),
                    //today's challenges
                    Row(
                      children: [
                        const Icon(
                          Iconsax.clock,
                          color: Color(0xFF0FB980),
                          size: 20,
                        ),
                        const Gap(5),
                        Text(
                          "Today's Challenges",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const Gap(20),

                    ///Complete Surah
                    Challeange(
                      challengeTitle: state.todayChallenges[0].title,
                      challengeDesc: state.todayChallenges[0].description,
                      numberOfSteps: state.todayChallenges[0].target,
                      completed: state.userDailyChallenges[0].completed,
                      percentage:
                          state.userDailyChallenges[0].completed /
                          state.todayChallenges[0].target,
                      hasanatReward: 20,
                      isCompleted:
                          state.userDailyChallenges[0].completed ==
                          state.todayChallenges[0].target,
                    ),
                    const Gap(20),

                    ///Dhikr Session
                    Challeange(
                      challengeTitle: state.todayChallenges[1].title,
                      challengeDesc: state.todayChallenges[1].description,
                      numberOfSteps: state.todayChallenges[1].target,
                      completed: state.userDailyChallenges[1].completed,
                      percentage:
                          state.userDailyChallenges[1].completed /
                          state.todayChallenges[1].target,
                      hasanatReward: 50,
                      isCompleted: state.userProgress.surahsRead >= 1,
                    ),
                    const Gap(20),

                    ///Morning Duas
                    Challeange(
                      challengeTitle: state.todayChallenges[2].title,
                      challengeDesc: state.todayChallenges[2].description,
                      numberOfSteps: state.todayChallenges[2].target,
                      completed: state.userDailyChallenges[2].completed,
                      percentage:
                          state.userDailyChallenges[2].completed /
                          state.todayChallenges[2].target,
                      hasanatReward: 30,
                      isDuaa: true,
                      isCompleted: state.userProgress.duasRecited >= 3,
                    ),
                    const Gap(30),
                    CustomContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  height: 20,
                                  width: 20,
                                  "assets/svgs/target-svgrepo-com.svg",
                                ),
                                const Gap(10),
                                Text(
                                  "Challenge Tips",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            const Gap(10),
                            Text(
                              "• Challenges reset daily at midnight",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Gap(5),
                            Text(
                              "• Complete all challenges for bonus hasanat",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Gap(5),
                            Text(
                              "• Maintain your streak for additional rewards",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Gap(5),
                            Text(
                              "• Progress is saved automatically",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(150),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
