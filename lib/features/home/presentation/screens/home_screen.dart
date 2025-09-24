import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_provider.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/features/home/presentation/models/challenge_model.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/home/presentation/widgets/home_stats.dart';
import 'package:furqan/features/home/presentation/widgets/today.dart';
import 'package:furqan/features/home/presentation/widgets/today_challenge.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              Row(
                children: [
                  ///Welcome
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const Gap(10),
                      Text(
                        "Continue your spiritual journey today",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: QuranAppTheme.gray400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  ///Avatar Image
                  const CircleAvatar(
                    backgroundColor: QuranAppTheme.cyan300,
                    child: Icon(
                      Icons.notifications,
                      color: QuranAppTheme.gray400,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              const Today(),
              const Gap(40),

              //// Home Stats
              HomeStats(isDarkMode: context.read<ThemeProvider>().isDarkMode),

              const Gap(30),
              Text(
                "Today's Challenges",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Gap(10),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CustomContainer(
                      isDarkMood: context.read<ThemeProvider>().isDarkMode,
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
                                    color:
                                        context.read<ThemeProvider>().isDarkMode
                                        ? QuranAppTheme
                                              .homeIconsContainersColorsDark[index]
                                        : QuranAppTheme
                                              .homeIconsContainersColorsLight[index],
                                  ),
                                  child: Center(
                                    child: Text(
                                      todayChallenges[index].challengeIcon,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineMedium,
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todayChallenges[index].challengeName,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineMedium,
                                    ),
                                    Text(
                                      todayChallenges[index].challengeDesc ??
                                          "",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  "0/${todayChallenges[index].challengeCompletion}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
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
              ),
              const Gap(20),
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [Color(0xFFF5830C), Color(0xFFF56261)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Stssssssssssreak",
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          const Gap(3),
                          Text(
                            "Keep up the great work!",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          const Spacer(),
                          Text(
                            "Best: 0 days",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          const Text(
                            "🔥",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          const Spacer(),
                          Text(
                            "0\ndays",
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.5,
                ),
                physics:
                    const NeverScrollableScrollPhysics(), // يمنع سكول داخلي
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
                            mainChallenges[index].challengeDesc ??
                                "Start your journey",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Gap(90),
            ],
          ),
        ),
      ),
    );
  }
}

// 📚
// Continue Reading
// Start your journey

// 🤲
// Duas
// 0 recited today

// ✨
// Dhikr Counter
// 0 counted

// 🕌
// Prayer Times

// 📖
// Complete a Surah
// Read any complete Surah today

// 0/1
// 🤲
// Morning Duas
// Recite 3 morning duas

// 0/3
// ✨
// Dhikr Session
// Complete 100 Tasbih

// 0/100

// Today's Challenges
// 📖
// Complete a Surah
// Read any complete Surah today

// 0/1
// ❤️
// Act of Kindness
// Perform one act of charity or kindness

// 0/1
// 📖
// Read 5 Ayahs
// Read at least 5 Ayahs with reflection
