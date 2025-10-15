import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'dart:ui';

import 'package:furqan/features/settings/presentation/screens/edit_profile_page.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

/// Enhanced Settings Screen with Full Dialog Functionality
///
/// Features:
/// - All quick action buttons with dialogs
/// - Privacy Policy dialog
/// - About dialog with app info
/// - Feedback dialog with form
/// - Rate app dialog with star rating
/// - Profile edit navigation
/// - Comprehensive liked ayahs management

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
  String _theme = 'light';
  String _fontSize = 'medium';
  String _arabicFont = 'amiri';
  String? _defaultReciter;
  String selectedReciterId = '1';
  String _language = 'english';
  bool _autoPlay = true;
  bool _showTranslation = true;
  bool _showTafsir = false;
  bool _notificationsPrayer = true;
  bool _notificationsReading = true;
  bool _notificationsChallenges = false;

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
      _defaultReciter = reciters.values.toList()[0];
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

  // Quick Actions Handlers
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
    showDialog(context: context, builder: (context) => const AboutDialog());
  }

  void _handleSignOut() {
    showDialog(
      context: context,
      builder: (context) => SignOutDialog(onConfirm: widget.onLogout),
    );
  }

  void _navigateToProfileEdit() {
    // Navigate to profile edit screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileEditScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDarkMood();
    final themeCubit = context.read<ThemeCubit>();

    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(children: [_buildHeader(isDark), _buildTabs(isDark)]),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: isDark
                  ? [const Color(0xFF34D399), const Color(0xFF2DD4BF)]
                  : [const Color(0xFF059669), const Color(0xFF0D9488)],
            ).createShader(bounds),
            child: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Gap(4),
          Text(
            'Customize your Quran experience',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0x33000000) : const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0x1AFFFFFF) : const Color(0x33FFFFFF),
          width: 1,
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF10B981), const Color(0xFF059669)]
                : [const Color(0xFF059669), const Color(0xFF0D9488)],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: isDark
            ? const Color(0xFF9CA3AF)
            : const Color(0xFF6B7280),
        tabs: const [
          Tab(text: 'General'),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Iconsax.heart, size: 16), Gap(4), Text('Liked')],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildProfileCard(isDark),
        const Gap(16),
        _buildAppearanceSection(isDark),
        const Gap(16),
        _buildAudioLanguageSection(isDark),
        const Gap(16),
        _buildNotificationsSection(isDark),
        const Gap(16),
        _buildQuickActions(isDark),
        const Gap(16),
        _buildAppVersion(isDark),
        const Gap(16),
      ],
    );
  }

  Widget _buildAppearanceSection(bool isDark) {
    return _buildGlassCard(
      isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            isDark,
            icon: isDark ? Icons.dark_mode : Icons.light_mode,
            title: 'Appearance',
          ),
          const Gap(16),
          _buildSelectSetting(
            isDark,
            label: 'Theme',
            value: _theme,
            options: const {
              'light': 'Light Mode',
              'dark': 'Dark Mode',
              'auto': 'Auto (System)',
            },
            onChanged: (value) {
              context.read<ThemeCubit>().changeTheme(value);
              setState(() => _theme = value);
            },
          ),
          const Divider(height: 24),
          _buildSelectSetting(
            isDark,
            label: 'Font Size',
            value: _fontSize,
            options: const {
              'small': 'Small',
              'medium': 'Medium',
              'large': 'Large',
            },
            onChanged: (value) => setState(() => _fontSize = value),
          ),
          const Divider(height: 24),
          _buildSelectSetting(
            isDark,
            label: 'Arabic Font',
            value: _arabicFont,
            options: const {
              'amiri': 'Amiri',
              'scheherazade': 'Scheherazade New',
            },
            onChanged: (value) => setState(() => _arabicFont = value),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioLanguageSection(bool isDark) {
    return _buildGlassCard(
      isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            isDark,
            icon: Icons.volume_up,
            title: 'Audio & Language',
          ),
          const SizedBox(height: 16),
          _buildSelectSetting(
            isDark,
            label: 'Default Reciter',
            value: selectedReciterId,
            options: reciters,
            onChanged: (value) {
              setState(() {
                selectedReciterId = value;
              });
            },
          ),
          const Divider(height: 24),
          _buildSelectSetting(
            isDark,
            label: 'Interface Language',
            value: _language,
            options: const {
              'english': 'English',
              'urdu': 'اردو (Urdu)',
              'bengali': 'বাংলা (Bengali)',
              'uzbek': "O'zbek (Uzbek)",
              'turkish': 'Türkçe (Turkish)',
              'french': 'Français (French)',
            },
            onChanged: (value) => setState(() => _language = value),
          ),
          const Divider(height: 24),
          _buildToggleSetting(
            isDark,
            label: 'Auto Play Next Ayah',
            value: _autoPlay,
            onChanged: (value) => setState(() => _autoPlay = value),
          ),
          const Divider(height: 24),
          _buildToggleSetting(
            isDark,
            label: 'Show Translation',
            value: _showTranslation,
            onChanged: (value) => setState(() => _showTranslation = value),
          ),
          const Divider(height: 24),
          _buildToggleSetting(
            isDark,
            label: 'Show Tafsir',
            value: _showTafsir,
            onChanged: (value) => setState(() => _showTafsir = value),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSection(bool isDark) {
    return _buildGlassCard(
      isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            isDark,
            icon: Icons.notifications,
            title: 'Notifications',
          ),
          const SizedBox(height: 16),
          _buildToggleSetting(
            isDark,
            label: 'Prayer Reminders',
            value: _notificationsPrayer,
            onChanged: (value) => setState(() => _notificationsPrayer = value),
          ),
          const Divider(height: 24),
          _buildToggleSetting(
            isDark,
            label: 'Reading Reminders',
            value: _notificationsReading,
            onChanged: (value) => setState(() => _notificationsReading = value),
          ),
          const Divider(height: 24),
          _buildToggleSetting(
            isDark,
            label: 'Challenge Updates',
            value: _notificationsChallenges,
            onChanged: (value) =>
                setState(() => _notificationsChallenges = value),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(bool isDark) {
    final actions = [
      _QuickAction(
        icon: Icons.favorite,
        label: 'Liked Ayahs',
        color: Colors.pink,
        onTap: _handleLikedAyahs,
      ),
      _QuickAction(
        icon: Icons.message,
        label: 'Feedback',
        color: Colors.blue,
        onTap: _handleFeedback,
      ),
      _QuickAction(
        icon: Icons.star,
        label: 'Rate App',
        color: Colors.amber,
        onTap: _handleRateApp,
      ),
      _QuickAction(
        icon: Icons.shield,
        label: 'Privacy',
        color: Colors.green,
        onTap: _handlePrivacy,
      ),
      _QuickAction(
        icon: Icons.info,
        label: 'About',
        color: Colors.purple,
        onTap: _handleAbout,
      ),
      _QuickAction(
        icon: Icons.logout,
        label: 'Sign Out',
        color: Colors.grey,
        onTap: _handleSignOut,
      ),
    ];

    return _buildGlassCard(
      isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: actions.map((action) {
              return _buildQuickActionButton(isDark, action);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(bool isDark, _QuickAction action) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0x1A000000) : const Color(0x0AFFFFFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? const Color(0x1AFFFFFF) : const Color(0x1A000000),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(action.icon, size: 20, color: action.color),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  action.label,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? const Color(0xFFE5E7EB)
                        : const Color(0xFF4B5563),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppVersion(bool isDark) {
    return Column(
      children: [
        Text(
          'FurQan v1.0.0',
          style: TextStyle(
            fontSize: 12,
            color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Made with ❤️ for the Muslim community',
          style: TextStyle(
            fontSize: 10,
            color: isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB),
          ),
        ),
      ],
    );
  }

  Widget _buildLikedTab(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _buildGlassCard(isDark, child: const LikedAyahsList()),
    );
  }

  // Helper Widgets
  Widget _buildGlassCard(bool isDark, {required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: CustomContainer(
          decoration: BoxDecoration(
            color: isDark ? const Color(0x33000000) : const Color(0xB3FFFFFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0x1AFFFFFF) : const Color(0x33FFFFFF),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    bool isDark, {
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDark ? const Color(0xFF34D399) : const Color(0xFF059669),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSetting(
    bool isDark, {
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF4B5563),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF10B981),
          activeTrackColor: const Color(0xFF34D399),
        ),
      ],
    );
  }

  Widget _buildSelectSetting(
    bool isDark, {
    required String label,
    required String value,
    required Map<String, String> options,
    required ValueChanged<String> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF4B5563),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          child: DropdownButton<String>(
            icon: const Icon(Iconsax.arrow_down5),
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            dropdownColor: isDark
                ? const Color(0xFF1F2937)
                : const Color(0xFFFFFFFF),
            style: TextStyle(
              fontSize: 13,
              color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
            ),
            items: options.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
        ),
      ],
    );
  }
}

// Quick Action Model
class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

// ============================================
// DIALOG WIDGETS
// ============================================

// Feedback Dialog
class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  String _selectedCategory = 'bug';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thank you for your feedback!'),
            backgroundColor: Color(0xFF10B981),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xE61F2937) : const Color(0xE6FFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.message,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Send Feedback',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? const Color(0xFFE5E7EB)
                          : const Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildCategoryChip('bug', '🐛 Bug Report', isDark),
                      _buildCategoryChip(
                        'feature',
                        '✨ Feature Request',
                        isDark,
                      ),
                      _buildCategoryChip('other', '💭 Other', isDark),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your Feedback',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? const Color(0xFFE5E7EB)
                          : const Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _feedbackController,
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your feedback';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Tell us what you think...',
                      filled: true,
                      fillColor: isDark
                          ? const Color(0x1A000000)
                          : const Color(0x0AFFFFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDark
                              ? const Color(0x1AFFFFFF)
                              : const Color(0x1A000000),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF3B82F6),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitFeedback,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Submit Feedback',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String value, String label, bool isDark) {
    final isSelected = _selectedCategory == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _selectedCategory = value);
      },
      backgroundColor: isDark
          ? const Color(0x1A000000)
          : const Color(0x0AFFFFFF),
      selectedColor: const Color(0xFF3B82F6),
      labelStyle: TextStyle(
        color: isSelected
            ? Colors.white
            : (isDark ? const Color(0xFFE5E7EB) : const Color(0xFF1F2937)),
        fontSize: 12,
      ),
    );
  }
}

// Rate App Dialog
class RateAppDialog extends StatefulWidget {
  const RateAppDialog({Key? key}) : super(key: key);

  @override
  State<RateAppDialog> createState() => _RateAppDialogState();
}

class _RateAppDialogState extends State<RateAppDialog> {
  int _rating = 0;
  bool _hasRated = false;

  void _submitRating() {
    if (_rating > 0) {
      setState(() => _hasRated = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 350),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xE61F2937) : const Color(0xE6FFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: _hasRated
                ? _buildThankYouContent()
                : _buildRatingContent(isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingContent(bool isDark) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.star, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 20),
        const Text(
          'Rate FurQan',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'How would you rate your experience?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => _rating = index + 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: const Color(0xFFFBBF24),
                  size: 40,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(
                    color: isDark
                        ? const Color(0xFF4B5563)
                        : const Color(0xFFD1D5DB),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Maybe Later'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: _rating > 0 ? _submitRating : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThankYouContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 48),
        ),
        const SizedBox(height: 20),
        const Text(
          'Thank You!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'We appreciate your rating!\nYour feedback helps us improve.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

// Privacy Dialog
class PrivacyDialog extends StatelessWidget {
  const PrivacyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 450, maxHeight: 600),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xE61F2937) : const Color(0xE6FFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF059669)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.shield,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPrivacySection(
                          '🔒 Data Collection',
                          'We collect minimal data necessary to provide you with the best Quran reading experience. This includes your reading progress, preferences, and usage statistics.',
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildPrivacySection(
                          '📱 Data Usage',
                          'Your data is used solely to personalize your experience, track your progress, and improve our services. We never sell your data to third parties.',
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildPrivacySection(
                          '🌐 Data Storage',
                          'All data is securely stored and encrypted. Your personal information is protected using industry-standard security measures.',
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildPrivacySection(
                          '👤 Your Rights',
                          'You have the right to access, modify, or delete your data at any time. Contact us for any privacy-related concerns.',
                          isDark,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'I Understand',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacySection(String title, String content, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 13,
            height: 1.6,
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

// About Dialog
class AboutDialog extends StatelessWidget {
  const AboutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xE61F2937) : const Color(0xE6FFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF0D9488)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('☪️', style: TextStyle(fontSize: 40)),
                  ),
                ),
                const SizedBox(height: 20),

                // App Name
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF0D9488)],
                  ).createShader(bounds),
                  child: const Text(
                    'FurQan',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0x1A10B981)
                        : const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'A comprehensive Quran application designed to help you read, listen, and understand the Holy Quran with modern features and beautiful design.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: isDark
                          ? const Color(0xFFE5E7EB)
                          : const Color(0xFF1F2937),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Features
                _buildFeatureRow(
                  Icons.menu_book,
                  'Read & Track Progress',
                  isDark,
                ),
                const SizedBox(height: 12),
                _buildFeatureRow(
                  Icons.headphones,
                  'Listen to Recitations',
                  isDark,
                ),
                const SizedBox(height: 12),
                _buildFeatureRow(
                  Icons.translate,
                  'Multiple Translations',
                  isDark,
                ),
                const SizedBox(height: 12),
                _buildFeatureRow(Icons.favorite, 'Save Favorite Ayahs', isDark),

                const SizedBox(height: 24),
                Text(
                  'Made with ❤️ for the Muslim community',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: isDark
                        ? const Color(0xFF6B7280)
                        : const Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF10B981)),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }
}

// Sign Out Dialog
class SignOutDialog extends StatelessWidget {
  final VoidCallback? onConfirm;

  const SignOutDialog({Key? key, this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 350),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xE61F2937) : const Color(0xE6FFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEE2E2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Color(0xFFEF4444),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign Out?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'Are you sure you want to sign out? Your progress will be saved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(
                            color: isDark
                                ? const Color(0xFF4B5563)
                                : const Color(0xFFD1D5DB),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (onConfirm != null) onConfirm!();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================
// LIKED AYAHS LIST (Same as before)
// ============================================

class LikedAyahsList extends StatefulWidget {
  const LikedAyahsList({Key? key}) : super(key: key);

  @override
  State<LikedAyahsList> createState() => _LikedAyahsListState();
}

class _LikedAyahsListState extends State<LikedAyahsList> {
  final List<LikedAyah> _likedAyahs = [
    LikedAyah(
      id: '1',
      surahName: 'Al-Baqarah',
      ayahNumber: 255,
      arabicText:
          'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ',
      translation:
          'Allah - there is no deity except Him, the Ever-Living, the Sustainer of existence. Neither drowsiness overtakes Him nor sleep.',
      likedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    LikedAyah(
      id: '2',
      surahName: 'Ar-Rahman',
      ayahNumber: 13,
      arabicText: 'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ',
      translation: 'So which of the favors of your Lord would you deny?',
      likedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  String? _expandedAyahId;
  bool _showClearDialog = false;

  void _removeLike(String id) {
    setState(() {
      _likedAyahs.removeWhere((ayah) => ayah.id == id);
    });
  }

  void _clearAll() {
    setState(() {
      _likedAyahs.clear();
      _showClearDialog = false;
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_likedAyahs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x4DEC4899), Color(0x4DF43F5E)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.favorite, size: 40, color: Colors.pink),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Liked Ayahs Yet',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the heart icon while reading\nto save your favorite verses here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? const Color(0xFF9CA3AF)
                    : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.pink, size: 20),
                  const SizedBox(width: 8),
                  Text('Liked Ayahs (${_likedAyahs.length})'),
                ],
              ),
              if (_likedAyahs.isNotEmpty)
                TextButton.icon(
                  onPressed: () => setState(() => _showClearDialog = true),
                  icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                  label: const Text(
                    'Clear All',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: _likedAyahs.length,
              itemBuilder: (context, index) {
                final ayah = _likedAyahs[index];
                final isExpanded = _expandedAyahId == ayah.id;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF1F2937), const Color(0x4DEC4899)]
                          : [const Color(0xFFFFFFFF), const Color(0xFFFCE7F3)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? const Color(0x33EC4899)
                          : const Color(0xFFFCE7F3),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCE7F3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.book,
                                    size: 12,
                                    color: Colors.pink,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    ayah.surahName,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.pink,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => _removeLike(ayah.id),
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.pink,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _expandedAyahId = isExpanded ? null : ayah.id;
                            });
                          },
                          child: Text(
                            ayah.arabicText,
                            textDirection: TextDirection.rtl,
                            maxLines: isExpanded ? null : 2,
                            style: const TextStyle(fontSize: 16, height: 1.8),
                          ),
                        ),
                        if (isExpanded) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              ayah.translation,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Liked ${_formatDate(ayah.likedAt)}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _expandedAyahId = isExpanded ? null : ayah.id;
                                });
                              },
                              child: Text(
                                isExpanded ? 'Show less' : 'Show more',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_showClearDialog)
            Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Clear All Liked Ayahs?'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                setState(() => _showClearDialog = false),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _clearAll,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Clear All'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class LikedAyah {
  final String id;
  final String surahName;
  final int ayahNumber;
  final String arabicText;
  final String translation;
  final DateTime likedAt;

  LikedAyah({
    required this.id,
    required this.surahName,
    required this.ayahNumber,
    required this.arabicText,
    required this.translation,
    required this.likedAt,
  });
}
