import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/cubit/user_progress_cubit.dart';
import 'package:furqan/features/home/presentation/models/stat_model.dart';
import 'package:furqan/features/home/presentation/widgets/custom_card.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:gap/gap.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({super.key, required this.userProgress});
  final UserProgress userProgress;

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeCubit>().isDarkMood();
    final colors = isDark ? _DarkColors() : _LightColors();
    return BlocBuilder<UserProgressCubit, UserProgresState>(
      builder: (context, state) {
        ///stats
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Hassanat Stats
            Expanded(
              child: _buildStatCard(
                context: context,
                statModel: StatModel(
                  label: "Hasanat",
                  icon: "🌙",
                  number: userProgress.totalHassanat,
                ),
                gradientColors: [
                  colors.hassanat['background']!,
                  colors.hassanat['background']!,
                  colors.hassanat['background']!,
                ],
                label: colors.hassanat['number']!,
                border: colors.hassanat['border']!,
              ),
            ),
            const Gap(20),

            ///Surahs Stats
            Expanded(
              child: _buildStatCard(
                context: context,
                statModel: StatModel(
                  label: "Surahs",
                  icon: "📖",
                  number: userProgress.surahsRead,
                ),
                gradientColors: [
                  colors.surahs['background']!,
                  colors.surahs['background']!,
                  colors.surahs['background']!,
                ],
                label: colors.surahs['number']!,
                border: colors.surahs['border']!,
              ),
            ),
            const Gap(20),

            ///Minutes Stats
            Expanded(
              child: _buildStatCard(
                context: context,
                statModel: StatModel(
                  label: "Minutes",
                  icon: "⏱️",
                  number: userProgress.readingMinutes,
                ),
                gradientColors: [
                  colors.minutes['background']!,
                  colors.minutes['background']!,
                  colors.minutes['background']!,
                ],
                label: colors.minutes['number']!,
                border: colors.minutes['border']!,
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildStatCard({
  required BuildContext context,
  required StatModel statModel,
  required List<Color> gradientColors,
  required Color label,
  required Color border,
}) {
  return CustomCard(
    label: label,
    gradient: gradientColors,
    border: border,
    statModel: statModel,
  );
}

abstract class ColorScheme {
  Map<String, Color> get hassanat;
  Map<String, Color> get surahs;
  Map<String, Color> get minutes;
}

class _LightColors implements ColorScheme {
  @override
  Map<String, Color> get hassanat => {
    'background': const Color(0xFFF5F0E3), // green-50
    'border': const Color(0xFFF5E780), // green-200
    'icon': const Color(0xFFC88200), // green-600
    'text': const Color(0xFFC88200), // green-700
    'number': const Color(0xFF9F5B00), // green-800
  };

  @override
  Map<String, Color> get minutes => {
    'background': const Color(0xFFF2E9F1),
    'border': const Color(0xFFE2CDF7),
    'icon': const Color(0xFF7D00D2),
    'text': const Color(0xFF7D00D2),
    'number': const Color(0xFF7D00D2),
  };

  @override
  Map<String, Color> get surahs => {
    'background': const Color(0xFFEAFAF3),
    'border': const Color(0xFFA2F1CD),
    'icon': const Color(0xFFC88200),
    'text': const Color(0xFF007552),
    'number': const Color(0xFF007552),
  };
}

class _DarkColors implements ColorScheme {
  @override
  Map<String, Color> get hassanat => {
    'background': const Color(0xFF282226), // green-900
    'border': const Color(0xFF844800), // green-800
    'icon': const Color(0xFF22C55E), // green-500
    'text': const Color(0xFFF5D61F), // green-400
    'number': const Color(0xFFF5D61F), // green-300
  };

  @override
  Map<String, Color> get minutes => {
    'background': const Color(0xFF2D2239),
    'border': const Color(0xFF6A10A9),
    'icon': const Color(0xFF6A10A9),
    'text': const Color(0xFF2D233B),
    'number': const Color(0xFFD1ABF5),
  };

  @override
  Map<String, Color> get surahs => {
    'background': const Color(0xFF122731),
    'border': const Color(0xFF005C42),
    'icon': const Color(0xFF00CC8C),
    'text': const Color(0xFF00CC8C),
    'number': const Color(0xFF00CC8C),
  };
}
