import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/screens/today_challenges/today_challenges.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:gap/gap.dart';

class TodayChallengesList extends StatelessWidget {
  const TodayChallengesList({super.key, required this.userProgress});
  final UserProgress userProgress;

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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodayChallenges()),
          ),
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
                            ),
                            const Spacer(),
                            Text(
                              "${userProgress.todayChallenges[index].finished}/${userProgress.todayChallenges[index].target}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Gap(20),
                        Text(
                          userProgress.todayChallenges[index].description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Gap(20),
                        LinearProgressIndicator(
                          minHeight: 5,
                          borderRadius: BorderRadius.circular(12),
                          value: userProgress.todayChallenges[index].progress,
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
            userProgress.todayChallenges[index].icon,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      const Gap(10),
      Text(
        userProgress.todayChallenges[index].title,
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
