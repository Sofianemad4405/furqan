import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/models/stat_model.dart';
import 'package:furqan/features/home/presentation/widgets/custom_card.dart';
import 'package:gap/gap.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({super.key, required this.isDarkMode});
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomCard(
            label: isDarkMode
                ? QuranAppTheme.darkStatCardColors['hasanat']!['number']!
                : QuranAppTheme.lightStatCardColors['hasanat']!['number']!,
            gradient: [
              isDarkMode
                  ? QuranAppTheme.darkStatCardColors['hasanat']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['hasanat']!['background']!,
              isDarkMode
                  ? QuranAppTheme.darkStatCardColors['hasanat']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['hasanat']!['background']!,
              isDarkMode
                  ? QuranAppTheme.darkStatCardColors['hasanat']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['hasanat']!['background']!,
            ],
            border: isDarkMode
                ? QuranAppTheme.darkStatCardColors['hasanat']!['border']!
                : QuranAppTheme.lightStatCardColors['hasanat']!['border']!,
            statModel: StatModel(label: "Hasanat", icon: "🌙", number: 4),
          ),
        ),
        const Gap(20),
        Expanded(
          child: CustomCard(
            label: isDarkMode
                ? QuranAppTheme.darkStatCardColors['surahs']!['number']!
                : QuranAppTheme.lightStatCardColors['surahs']!['number']!,
            gradient: [
              isDarkMode
                  ? QuranAppTheme.darkStatCardColors['surahs']!['background']!
                  : QuranAppTheme.lightStatCardColors['surahs']!['background']!,
              isDarkMode
                  ? QuranAppTheme.darkStatCardColors['surahs']!['background']!
                  : QuranAppTheme.lightStatCardColors['surahs']!['background']!,
              isDarkMode
                  ? QuranAppTheme.darkStatCardColors['surahs']!['background']!
                  : QuranAppTheme.lightStatCardColors['surahs']!['background']!,
            ],
            border: isDarkMode
                ? QuranAppTheme.darkStatCardColors['surahs']!['border']!
                : QuranAppTheme.lightStatCardColors['surahs']!['border']!,
            statModel: StatModel(label: "Surahs", icon: "📖", number: 4),
          ),
        ),
        const Gap(20),
        Expanded(
          child: CustomCard(
            label: isDarkMode
                ? QuranAppTheme.darkStatCardColors['minutes']!['number']!
                : QuranAppTheme.lightStatCardColors['minutes']!['number']!,
            gradient: [
              isDarkMode
                  ? QuranAppTheme.darkStatCardColors['minutes']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['minutes']!['background']!,
              isDarkMode
                  ? QuranAppTheme.darkStatCardColors['minutes']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['minutes']!['background']!,
              isDarkMode
                  ? QuranAppTheme.darkStatCardColors['minutes']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['minutes']!['background']!,
            ],
            border: isDarkMode
                ? QuranAppTheme.darkStatCardColors['minutes']!['border']!
                : QuranAppTheme.lightStatCardColors['minutes']!['border']!,
            statModel: StatModel(label: "Minutes", icon: "⏱️", number: 4),
          ),
        ),
      ],
    );
  }
}
