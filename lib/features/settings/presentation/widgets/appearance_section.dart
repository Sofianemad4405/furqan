import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/settings/presentation/widgets/glass_card.dart';
import 'package:furqan/features/settings/presentation/widgets/section_header.dart';
import 'package:furqan/features/settings/presentation/widgets/select_setting.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({
    super.key,
    required this.isDark,
    required this.theme,
    required this.fontSize,
    required this.arabicFont,
  });
  final bool isDark;
  final String theme;
  final String fontSize;
  final String arabicFont;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            isDark: isDark,
            icon: isDark ? Iconsax.moon5 : Iconsax.sun_15,
            title: 'Appearance',
          ),
          const Gap(16),
          SelectSetting(
            isDark: isDark,
            label: 'Theme',
            value: theme,
            options: const {
              'light': 'Light Mode',
              'dark': 'Dark Mode',
              'auto': 'Auto (System)',
            },
            onChanged: (value) {
              context.read<ThemeCubit>().changeTheme(value);
            },
          ),
          const Divider(height: 24),
          SelectSetting(
            isDark: isDark,
            label: 'Font Size',
            value: fontSize,
            options: const {
              'small': 'Small',
              'medium': 'Medium',
              'large': 'Large',
            },
            onChanged: (value) {},
          ),
          const Divider(height: 24),
          SelectSetting(
            isDark: isDark,
            label: 'Arabic Font',
            value: arabicFont,
            options: const {
              'amiri': 'Amiri',
              'scheherazade': 'Scheherazade New',
            },
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
