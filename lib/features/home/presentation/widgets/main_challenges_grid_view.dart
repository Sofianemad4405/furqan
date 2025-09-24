import 'package:flutter/material.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';

class MainChallengesGridView extends StatelessWidget {
  const MainChallengesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.5,
      ),
      physics: const NeverScrollableScrollPhysics(), // يمنع سكول داخلي
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CustomContainer(
          isDarkMood: false,
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
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  mainChallenges[index].challengeDesc ?? "Start your journey",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
