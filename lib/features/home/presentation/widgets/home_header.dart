import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:gap/gap.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///Welcome
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(10),
            Text(
              "Continue your spiritual journey today",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: QuranAppTheme.gray400),
            ),
          ],
        ),
        const Spacer(),

        ///Avatar Image
        const CircleAvatar(
          backgroundColor: QuranAppTheme.cyan300,
          child: Icon(Icons.notifications, color: QuranAppTheme.gray400),
        ),
      ],
    );
  }
}
