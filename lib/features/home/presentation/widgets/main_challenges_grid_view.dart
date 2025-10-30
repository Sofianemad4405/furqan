import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/models/main_challenges.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/azkar_screen.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/presentation/screens/prayer_times_screen.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:get/get.dart';

class MainChallengesGridView extends StatelessWidget {
  const MainChallengesGridView({super.key, required this.mainChallenges});
  final List<MainChallenge> mainChallenges;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.5,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  GetPageRoute(
                    page: () => index == 2
                        ? const DhikrScreen()
                        : const PrayerTimesScreen(),
                  ),
                );
              },
              child: CustomContainer(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mainChallenges[index].challengeIcon,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        mainChallenges[index].challengeName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        mainChallenges[index].challengeDesc ,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
