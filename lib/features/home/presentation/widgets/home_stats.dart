import 'package:flutter/material.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/models/stat_model.dart';
import 'package:furqan/features/home/presentation/widgets/custom_card.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().isDarkMood();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomCard(
            label: isDark
                ? QuranAppTheme.darkStatCardColors['hasanat']!['number']!
                : QuranAppTheme.lightStatCardColors['hasanat']!['number']!,
            gradient: [
              isDark
                  ? QuranAppTheme.darkStatCardColors['hasanat']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['hasanat']!['background']!,
              isDark
                  ? QuranAppTheme.darkStatCardColors['hasanat']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['hasanat']!['background']!,
              isDark
                  ? QuranAppTheme.darkStatCardColors['hasanat']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['hasanat']!['background']!,
            ],
            border: isDark
                ? QuranAppTheme.darkStatCardColors['hasanat']!['border']!
                : QuranAppTheme.lightStatCardColors['hasanat']!['border']!,
            statModel: StatModel(label: "Hasanat", icon: "🌙", number: 4),
          ),
        ),
        const Gap(20),
        Expanded(
          child: CustomCard(
            label: isDark
                ? QuranAppTheme.darkStatCardColors['surahs']!['number']!
                : QuranAppTheme.lightStatCardColors['surahs']!['number']!,
            gradient: [
              isDark
                  ? QuranAppTheme.darkStatCardColors['surahs']!['background']!
                  : QuranAppTheme.lightStatCardColors['surahs']!['background']!,
              isDark
                  ? QuranAppTheme.darkStatCardColors['surahs']!['background']!
                  : QuranAppTheme.lightStatCardColors['surahs']!['background']!,
              isDark
                  ? QuranAppTheme.darkStatCardColors['surahs']!['background']!
                  : QuranAppTheme.lightStatCardColors['surahs']!['background']!,
            ],
            border: isDark
                ? QuranAppTheme.darkStatCardColors['surahs']!['border']!
                : QuranAppTheme.lightStatCardColors['surahs']!['border']!,
            statModel: StatModel(label: "Surahs", icon: "📖", number: 4),
          ),
        ),
        const Gap(20),
        Expanded(
          child: CustomCard(
            label: isDark
                ? QuranAppTheme.darkStatCardColors['minutes']!['number']!
                : QuranAppTheme.lightStatCardColors['minutes']!['number']!,
            gradient: [
              isDark
                  ? QuranAppTheme.darkStatCardColors['minutes']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['minutes']!['background']!,
              isDark
                  ? QuranAppTheme.darkStatCardColors['minutes']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['minutes']!['background']!,
              isDark
                  ? QuranAppTheme.darkStatCardColors['minutes']!['background']!
                  : QuranAppTheme
                        .lightStatCardColors['minutes']!['background']!,
            ],
            border: isDark
                ? QuranAppTheme.darkStatCardColors['minutes']!['border']!
                : QuranAppTheme.lightStatCardColors['minutes']!['border']!,
            statModel: StatModel(label: "Minutes", icon: "⏱️", number: 4),
          ),
        ),
      ],
    );
  }
}
