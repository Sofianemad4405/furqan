import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/theme_provider.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/utils/constants.dart';
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CustomContainer(
            isDarkMood: context.read<ThemeProvider>().isDarkMode,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.read<ThemeProvider>().isDarkMode
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
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            todayChallenges[index].challengeDesc ?? "",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        "0/${todayChallenges[index].challengeCompletion}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const Gap(60),
                  LinearProgressIndicator(
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(12),
                    value: 0,
                    backgroundColor: QuranAppTheme.gray450,
                    color: QuranAppTheme.gray400,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
