import 'package:flutter/material.dart';
import 'package:furqan/features/settings/presentation/widgets/glass_card.dart';
import 'package:furqan/features/settings/presentation/widgets/section_header.dart';
import 'package:furqan/features/settings/presentation/widgets/toggle_settings.dart';
import 'package:iconsax/iconsax.dart';

class NotificationsSection extends StatefulWidget {
  const NotificationsSection({
    super.key,
    required this.isDark,
    required this.notificationsPrayer,
    required this.notificationsReading,
    required this.notificationsChallenges,
    required this.onNotificationsPrayerChanged,
    required this.onNotificationsReadingChanged,
    required this.onNotificationsChallengesChanged,
  });
  final bool isDark;
  final bool notificationsPrayer;
  final bool notificationsReading;
  final bool notificationsChallenges;
  final ValueChanged<bool> onNotificationsPrayerChanged;
  final ValueChanged<bool> onNotificationsReadingChanged;
  final ValueChanged<bool> onNotificationsChallengesChanged;

  @override
  State<NotificationsSection> createState() => _NotificationsSectionState();
}

class _NotificationsSectionState extends State<NotificationsSection> {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      isDark: widget.isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            isDark: widget.isDark,
            icon: Iconsax.notification5,
            title: 'Notifications',
          ),
          const SizedBox(height: 16),
          ToggleSettings(
            isDark: widget.isDark,
            label: 'Prayer Reminders',
            value: widget.notificationsPrayer,
            onChanged: widget.onNotificationsPrayerChanged,
          ),
          const Divider(height: 24),
          ToggleSettings(
            isDark: widget.isDark,
            label: 'Reading Reminders',
            value: widget.notificationsReading,
            onChanged: widget.onNotificationsReadingChanged,
          ),
          const Divider(height: 24),
          ToggleSettings(
            isDark: widget.isDark,
            label: 'Challenge Updates',
            value: widget.notificationsChallenges,
            onChanged: widget.onNotificationsChallengesChanged,
          ),
        ],
      ),
    );
  }
}
