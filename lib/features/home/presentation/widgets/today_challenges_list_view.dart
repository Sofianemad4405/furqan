import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/features/home/presentation/screens/today_challenges/today_challenges.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';

class TodayChallengesListView extends StatelessWidget {
  const TodayChallengesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodayChallenges()),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: context.read<ThemeCubit>().isDarkMood()
                                ? QuranAppTheme
                                      .homeIconsContainersColorsDark[index]
                                : QuranAppTheme
                                      .homeIconsContainersColorsLight[index],
                          ),
                          child: Center(
                            child: Text(
                              todayChallenges[index].challengeIcon,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todayChallenges[index].challengeName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              todayChallenges[index].challengeDesc ?? "",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "0/${todayChallenges[index].challengeCompletion}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Gap(40),
                    LinearProgressIndicator(
                      minHeight: 5,
                      borderRadius: BorderRadius.circular(12),
                      value: 0.5,
                      backgroundColor: QuranAppTheme.gray450,
                      color: QuranAppTheme.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
