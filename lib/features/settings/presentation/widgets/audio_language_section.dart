import 'package:flutter/material.dart';
import 'package:furqan/features/settings/presentation/widgets/glass_card.dart';
import 'package:furqan/features/settings/presentation/widgets/section_header.dart';
import 'package:furqan/features/settings/presentation/widgets/select_setting.dart';
import 'package:furqan/features/settings/presentation/widgets/toggle_settings.dart';
import 'package:iconsax/iconsax.dart';

class AudioLanguageSection extends StatelessWidget {
  const AudioLanguageSection({
    super.key,
    required this.isDark,
    required this.selectedReciterId,
    required this.reciters,
    required this.availableLanguages,
    required this.onReciterChanged,
    required this.onLanguageChanged,
    required this.onAutoPlayChanged,
    required this.onShowTranslationChanged,
    required this.language,
    required this.autoPlay,
    required this.showTranslation,
  });
  final bool isDark;
  final bool autoPlay;
  final bool showTranslation;
  final String selectedReciterId;
  final String language;
  final Map<String, String> reciters;
  final Map<String, String> availableLanguages;
  final ValueChanged<String> onReciterChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<bool> onAutoPlayChanged;
  final ValueChanged<bool> onShowTranslationChanged;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            isDark: isDark,
            icon: Iconsax.volume_high5,
            title: 'Audio & Language',
          ),
          const SizedBox(height: 16),
          SelectSetting(
            isDark: isDark,
            label: 'Default Reciter',
            value: selectedReciterId,
            options: reciters,
            onChanged: onReciterChanged,
          ),
          const Divider(height: 24),
          SelectSetting(
            isDark: isDark,
            label: 'Interface Language',
            value: language,
            options: availableLanguages,
            onChanged: onLanguageChanged,
          ),
          const Divider(height: 24),
          ToggleSettings(
            isDark: isDark,
            label: 'Auto Play Next Ayah',
            value: autoPlay,
            onChanged: onAutoPlayChanged,
          ),
          const Divider(height: 24),
          ToggleSettings(
            isDark: isDark,
            label: 'Show Translation',
            value: showTranslation,
            onChanged: onShowTranslationChanged,
          ),
        ],
      ),
    );
  }
}
