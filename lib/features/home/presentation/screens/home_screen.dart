import 'package:flutter/material.dart';
import 'package:furqan/core/design/app_design_system.dart';
import 'package:furqan/core/themes/theme_modes.dart';
import 'package:furqan/features/home/presentation/widgets/custom_card.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(10),
                      Text(
                        "Continue your spiritual journey today",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: QuranDesignSystem.colors.neutral.c400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor:
                        QuranDesignSystem.colors.primary.emerald[500],
                  ),
                ],
              ),
              const Gap(20),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    QuranDesignSystem.radius.lg,
                  ),
                  border: Border.all(
                    color: QuranDesignSystem.colors.neutral.c500,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: days
                      .map(
                        (d) => Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: isToday(d)
                                ? QuranDesignSystem.colors.primary.emerald[500]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(child: Text(d)),
                        ),
                      )
                      .toList(),
                ),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: const CustomCard(totalHasanat: 3)),
                  Gap(20),
                  Expanded(child: const CustomCard(totalHasanat: 3)),
                  Gap(20),
                  Expanded(child: const CustomCard(totalHasanat: 3)),
                ],
              ),
              const Gap(20),
              Text(
                "Today's Challenges",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(20),
              GlassContainer(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Act of Kindness",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "Perform one act of charity or kindness",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          const Text("0/1"),
                          const Gap(20),
                        ],
                      ),
                      const Gap(40),
                      const LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.grey,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20),
              GlassContainer(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Act of Kindness",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "Perform one act of charity or kindness",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          const Text("0/1"),
                          const Gap(20),
                        ],
                      ),
                      const Gap(40),
                      const LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.grey,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20),
              GlassContainer(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Act of Kindness",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "Perform one act of charity or kindness",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          const Text("0/1"),
                          const Gap(20),
                        ],
                      ),
                      const Gap(40),
                      const LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.grey,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> days = ["Su", "M", "T", "W", "T", "F", "Sa"];

bool isToday(String day) {
  final now = DateTime.now();
  final weekday = now.weekday;
  final currentDayIndex = weekday % 7;
  final currentDayAbbr = days[currentDayIndex];
  return day == currentDayAbbr;
}
