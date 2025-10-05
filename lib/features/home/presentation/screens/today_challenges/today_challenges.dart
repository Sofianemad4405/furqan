import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/core/themes/theme_system.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            const Header(),
            const Gap(20),

            //streak and completed
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Streak(),
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

                  ///Read 5 Ayahs
                  const Challeange(
                    challengeTitle: 'Read 5 Ayahs',
                    challengeDesc: 'Read at least 5 Ayahs with reflection',
                    numberOfSteps: 5,
                    completed: 0,
                    percentage: 0,
                    hasanatReward: 20,
                  ),
                  const Gap(20),

                  ///Complete Surah
                  const Challeange(
                    challengeTitle: 'Complete a Surah',
                    challengeDesc: 'Read any complete Surah today',
                    numberOfSteps: 1,
                    completed: 0,
                    percentage: 0,
                    hasanatReward: 50,
                  ),
                  const Gap(20),

                  ///Morning Duas
                  const Challeange(
                    challengeTitle: 'Morning Duas',
                    challengeDesc: 'Recite 3 morning duas',
                    numberOfSteps: 3,
                    completed: 0,
                    percentage: 0,
                    hasanatReward: 30,
                    isDuaa: true,
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
                                style: Theme.of(context).textTheme.titleMedium,
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
          ],
        ),
      ),
    );
  }
}
