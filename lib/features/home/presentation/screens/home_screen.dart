import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_provider.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/models/challenge_model.dart';
import 'package:furqan/features/home/presentation/models/stat_model.dart';
import 'package:furqan/features/home/presentation/widgets/custom_card.dart';
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

              ///Complete a Surah
              TodayChallenge(
                isDarkMood: context.read<ThemeProvider>().isDarkMode,
                challengeModel: ChallengeModel(
                  challengeIcon: "📖",
                  challengeName: "Complete a Surah",
                  challengeDesc: "Read any complete Surah today",
                  challengeCompletion: 1,
                  challengeDone: 0,
                  challengeIconColor: context.read<ThemeProvider>().isDarkMode
                      ? QuranAppTheme
                            .darkStatCardColors['hasanat']!['background']!
                      : QuranAppTheme
                            .lightStatCardColors['hasanat']!['background']!,
                ),
              ),
              const Gap(20),
              TodayChallenge(
                isDarkMood: context.read<ThemeProvider>().isDarkMode,
                challengeModel: ChallengeModel(
                  challengeIcon: "📖",
                  challengeName: "Complete a Surah",
                  challengeDesc: "Read any complete Surah today",
                  challengeCompletion: 1,
                  challengeDone: 0,
                  challengeIconColor: context.read<ThemeProvider>().isDarkMode
                      ? QuranAppTheme
                            .darkStatCardColors['hasanat']!['background']!
                      : QuranAppTheme
                            .lightStatCardColors['hasanat']!['background']!,
                ),
              ),
              const Gap(20),
              TodayChallenge(
                isDarkMood: context.read<ThemeProvider>().isDarkMode,
                challengeModel: ChallengeModel(
                  challengeIcon: "📖",
                  challengeName: "Complete a Surah",
                  challengeDesc: "Read any complete Surah today",
                  challengeCompletion: 1,
                  challengeDone: 0,
                  challengeIconColor: context.read<ThemeProvider>().isDarkMode
                      ? QuranAppTheme
                            .darkStatCardColors['hasanat']!['background']!
                      : QuranAppTheme
                            .lightStatCardColors['hasanat']!['background']!,
                ),
              ),
              TodayChallenge(
                isDarkMood: context.read<ThemeProvider>().isDarkMode,
                challengeModel: ChallengeModel(
                  challengeIcon: "📖",
                  challengeName: "Complete a Surah",
                  challengeDesc: "Read any complete Surah today",
                  challengeCompletion: 1,
                  challengeDone: 0,
                  challengeIconColor: context.read<ThemeProvider>().isDarkMode
                      ? QuranAppTheme
                            .darkStatCardColors['hasanat']!['background']!
                      : QuranAppTheme
                            .lightStatCardColors['hasanat']!['background']!,
                ),
              ),
              TodayChallenge(
                isDarkMood: context.read<ThemeProvider>().isDarkMode,
                challengeModel: ChallengeModel(
                  challengeIcon: "📖",
                  challengeName: "Complete a Surah",
                  challengeDesc: "Read any complete Surah today",
                  challengeCompletion: 1,
                  challengeDone: 0,
                  challengeIconColor: context.read<ThemeProvider>().isDarkMode
                      ? QuranAppTheme
                            .darkStatCardColors['hasanat']!['background']!
                      : QuranAppTheme
                            .lightStatCardColors['hasanat']!['background']!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
