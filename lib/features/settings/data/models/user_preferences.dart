import 'package:furqan/features/settings/data/enums/user_prefs_enums.dart';

class UserPreferences {
  final DefaultTheme defaultTheme;
  final FontSize fontSize;
  final Language language;
  final String defaultReciterId;
  final bool autoPlayNextAyah;
  final bool showTranslation;
  final bool prayerRemaindersActivated;
  final bool readingRemaindersActivated;
  final bool challengeUpdatedActivated;

  UserPreferences({
    this.defaultTheme = DefaultTheme.light,
    this.fontSize = FontSize.medium,
    this.language = Language.english,
    this.defaultReciterId = "1",
    this.autoPlayNextAyah = false,
    this.showTranslation = true,
    this.prayerRemaindersActivated = true,
    this.readingRemaindersActivated = false,
    this.challengeUpdatedActivated = true,
  });
}
