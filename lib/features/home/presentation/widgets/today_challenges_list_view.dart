import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/screens/today_challenges/today_challenges.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/user_data/models/daily_challenge_model.dart';
import 'package:furqan/features/user_data/models/user_daily_challenge.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TodayChallengesList extends StatelessWidget {
  const TodayChallengesList({
    super.key,
    required this.userProgress,
    required this.dailyChallenges,
    required this.userDailyChallenge,
  });
  final UserProgress userProgress;
  final List<DailyChallengeModel> dailyChallenges;
  final List<UserDailyChallenge> userDailyChallenge;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDarkMood();
    final colors = isDark ? _DarkMood() : _LightMood();
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(GetPageRoute(page: () => const TodayChallenges()));
          },
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ///challenge icon
                            _buildChallengeIconAndTitle(
                              color: colors.iconsColors[index],
                              userProgress: userProgress,
                              context: context,
                              index: index,
                              dailyChallenges: dailyChallenges,
                            ),
                            const Spacer(),
                            Text(
                              "${userDailyChallenge[index].completed}/${dailyChallenges[index].target}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Gap(20),
                        Text(
                          dailyChallenges[index].description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Gap(20),
                        LinearProgressIndicator(
                          minHeight: 5,
                          borderRadius: BorderRadius.circular(12),
                          value:
                              userDailyChallenge[index].completed /
                              dailyChallenges[index].target,
                          backgroundColor: Colors.grey,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

Widget _buildChallengeIconAndTitle({
  required Color color,
  required UserProgress userProgress,
  required List<DailyChallengeModel> dailyChallenges,
  required BuildContext context,
  required int index,
}) {
  return Row(
    children: [
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Center(
          child: Text(
            dailyChallenges[index].icon,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      const Gap(10),
      Text(
        dailyChallenges[index].title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ],
  );
}

abstract class ColorScheme {
  List<Color> get iconsColors;
}

class _DarkMood implements ColorScheme {
  @override
  List<Color> get iconsColors => [
    ///Complete a Surah
    const Color(0xFF143236),

    ///Dhikr Session
    const Color(0xFF1C2B4E),

    ///Morning Duaas
    const Color(0xFF2D224D),
  ];
}

class _LightMood implements ColorScheme {
  @override
  List<Color> get iconsColors => [
    ///Complete a Surah
    const Color(0xFFC8F0DC),

    ///Dhikr Session
    const Color(0xFFD2E1F4),

    ///Morning Duaas
    const Color(0xFFE9DFF5),
  ];
}
