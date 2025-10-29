import 'dart:developer';

import 'package:flutter/material.dart' hide AboutDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:furqan/features/settings/data/models/quick_action.dart';
import 'package:furqan/features/settings/presentation/screens/edit_profile_page.dart';
import 'package:furqan/features/settings/presentation/widgets/app_version.dart';
import 'package:furqan/features/settings/presentation/widgets/appearance_section.dart';
import 'package:furqan/features/settings/presentation/widgets/audio_language_section.dart';
import 'package:furqan/features/settings/presentation/widgets/dialogs/about.dart';
import 'package:furqan/features/settings/presentation/widgets/dialogs/feedback.dart';
import 'package:furqan/features/settings/presentation/widgets/dialogs/privacy.dart';
import 'package:furqan/features/settings/presentation/widgets/dialogs/rate_app.dart';
import 'package:furqan/features/settings/presentation/widgets/glass_card.dart';
import 'package:furqan/features/settings/presentation/widgets/liked_ayahs_list.dart';
import 'package:furqan/features/settings/presentation/widgets/notifications_section.dart';
import 'package:furqan/features/settings/presentation/widgets/profile_card.dart';
import 'package:furqan/features/settings/presentation/widgets/quick_actions.dart';
import 'package:furqan/features/settings/presentation/widgets/settings_header.dart';
import 'package:furqan/features/settings/presentation/widgets/taps.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const SettingsScreen({super.key, this.onLogout});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Settings state
  String theme = 'light';
  String fontSize = 'medium';
  String arabicFont = 'amiri';
  String selectedReciterId = '1';
  String language = 'english';
  bool autoPlay = true;
  Map<String, String> availableLanguages = const {
    'english': 'English',
    'arabic': 'العربية (Arabic)',
  };
  bool _notificationsPrayer = true;
  bool _notificationsReading = true;
  bool _notificationsChallenges = false;
  bool showTranslation = true;

  String? userName;
  String? userPhoto;
  String? userEmail;
  Map<String, String> reciters = {};

  Future<void> _getUserData() async {
    final prefs = sl<Prefs>();
    final name = prefs.name;
    final photo = prefs.photo;
    final email = prefs.email;

    setState(() {
      userName = name;
      userPhoto = photo;
      userEmail = email;
    });
  }

  Future<void> getAvailableReciters() async {
    try {
      final reciters = await context
          .read<ReadingCubit>()
          .getAvailableReciters();
      setState(() {
        this.reciters = reciters;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  final int _currentStreak = 15;
  final int _totalHasanat = 2450;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _tabController = TabController(length: 2, vsync: this);
    getAvailableReciters();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToProfileEdit() {
    Navigator.of(
      context,
    ).push(GetPageRoute(page: () => const ProfileEditScreen()));
  }

  /// Quick Actions Handlers
  void _handleLikedAyahs() {
    _tabController.animateTo(1);
  }

  void _handleFeedback() {
    showDialog(context: context, builder: (context) => const FeedbackDialog());
  }

  void _handleRateApp() {
    showDialog(context: context, builder: (context) => const RateAppDialog());
  }

  void _handlePrivacy() {
    showDialog(context: context, builder: (context) => const PrivacyDialog());
  }

  void _handleAbout() {
    showDialog(context: context, builder: (context) => const AboutAppDialog());
  }

  void _handleSignOut() {
    showDialog(
      context: context,
      builder: (context) => SignOutDialog(onConfirm: widget.onLogout),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDarkMood();

    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeader(isDark),
                _buildTabs(isDark, _tabController),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [_buildGeneralTab(isDark), _buildLikedTab(isDark)],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return SettingsHeader(isDark: isDark);
  }

  Widget _buildTabs(bool isDark, TabController tabController) {
    return Taps(isDark: isDark, tabController: tabController);
  }

  Widget _buildGeneralTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ProfileCard(
          userPhoto: userPhoto,
          navigateToProfileEdit: _navigateToProfileEdit,
          userName: userName,
          currentStreak: _currentStreak,
          totalHasanat: _totalHasanat,
        ),
        const Gap(16),
        AppearanceSection(
          isDark: isDark,
          theme: context.read<ThemeCubit>().state == ThemeMode.dark
              ? 'dark'
              : 'light',
          fontSize: fontSize,
          arabicFont: arabicFont,
        ),
        const Gap(16),
        AudioLanguageSection(
          isDark: isDark,
          selectedReciterId: selectedReciterId,
          reciters: reciters,
          availableLanguages: availableLanguages,
          onReciterChanged: (value) {
            setState(() {
              selectedReciterId = value;
            });
          },
          onLanguageChanged: (value) {
            setState(() {
              language = value;
            });
          },
          onAutoPlayChanged: (value) {
            setState(() {
              autoPlay = value;
            });
          },
          onShowTranslationChanged: (value) {
            setState(() {
              showTranslation = value;
            });
          },
          language: language,
          autoPlay: autoPlay,
          showTranslation: showTranslation,
        ),
        const Gap(16),
        NotificationsSection(
          isDark: isDark,
          notificationsPrayer: _notificationsPrayer,
          notificationsReading: _notificationsReading,
          notificationsChallenges: _notificationsChallenges,
          onNotificationsPrayerChanged: (value) {
            setState(() {
              _notificationsPrayer = value;
            });
          },
          onNotificationsReadingChanged: (value) {
            setState(() {
              _notificationsReading = value;
            });
          },
          onNotificationsChallengesChanged: (value) {
            setState(() {
              _notificationsChallenges = value;
            });
          },
        ),
        const Gap(16),
        _buildQuickActions(isDark),
        const Gap(16),
        _buildAppVersion(isDark),
        const Gap(16),
      ],
    );
  }

  Widget _buildQuickActions(bool isDark) {
    final actions = [
      QuickAction(
        icon: Iconsax.heart5,
        label: 'Liked Ayahs',
        color: Colors.pink,
        onTap: _handleLikedAyahs,
      ),
      QuickAction(
        icon: Iconsax.message,
        label: 'Feedback',
        color: Colors.blue,
        onTap: _handleFeedback,
      ),
      QuickAction(
        icon: Iconsax.star5,
        label: 'Rate App',
        color: Colors.amber,
        onTap: _handleRateApp,
      ),
      QuickAction(
        icon: Iconsax.shield_security,
        label: 'Privacy',
        color: Colors.green,
        onTap: _handlePrivacy,
      ),
      QuickAction(
        icon: Icons.info,
        label: 'About',
        color: Colors.purple,
        onTap: _handleAbout,
      ),
      QuickAction(
        icon: Iconsax.logout4,
        label: 'Sign Out',
        color: Colors.grey,
        onTap: _handleSignOut,
      ),
    ];

    return QuickActions(isDark: isDark, actions: actions);
  }

  Widget _buildAppVersion(bool isDark) {
    return AppVersion(isDark: isDark);
  }

  Widget _buildLikedTab(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GlassCard(isDark: isDark, child: const LikedAyahsList()),
    );
  }
}
