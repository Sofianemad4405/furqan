import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/services/location_service.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/models/location_data.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/models/next_prayer_info.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/models/prayer_list_item.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/models/prayer_times.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/models/prayer_times_data.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isLoading = false;
  String? _error;
  PrayerTimesData? _prayerTimes;
  NextPrayerInfo? _nextPrayer;
  final locationService = sl<LocationService>();
  Position? userPosition;
  Placemark? userPlaceMark;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.forward();
    _loadUserLocaionData();
    _loadPrayerTimes();
    _startNextPrayerTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadUserLocaionData() {
    locationService.getCurrentLocation();
  }

  void _loadPrayerTimes() {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _prayerTimes = PrayerTimesData(
            date: DateTime.now(),
            times: PrayerTimes(
              fajr: '05:15',
              sunrise: '06:45',
              dhuhr: '12:15',
              asr: '15:45',
              maghrib: '18:30',
              isha: '19:45',
            ),
            location: LocationData(
              city: userPlaceMark?.locality ?? 'Unknown',
              country: userPlaceMark?.country ?? 'Unknown',
              timezone: userPosition?.floor?.toString() ?? "",
            ),
          );
          _updateNextPrayer();
          _isLoading = false;
        });
      }
    });
  }

  void _startNextPrayerTimer() {
    Future.delayed(const Duration(minutes: 1), () {
      if (mounted) {
        _updateNextPrayer();
        _startNextPrayerTimer();
      }
    });
  }

  void _updateNextPrayer() {
    if (_prayerTimes == null) return;

    final now = DateTime.now();
    final currentMinutes = now.hour * 60 + now.minute;

    final prayers = [
      PrayerListItem(
        'Fajr',
        _prayerTimes!.times.fajr,
        'Fajr prayer',
        Icons.wb_twilight,
      ),
      PrayerListItem(
        'Sunrise',
        _prayerTimes!.times.sunrise,
        'Sunrise (no prayer)',
        Icons.wb_sunny,
      ),
      PrayerListItem(
        'Dhuhr',
        _prayerTimes!.times.dhuhr,
        'Dhuhr prayer',
        Icons.wb_sunny,
      ),
      PrayerListItem(
        'Asr',
        _prayerTimes!.times.asr,
        'Asr prayer',
        Icons.wb_sunny,
      ),
      PrayerListItem(
        'Maghrib',
        _prayerTimes!.times.maghrib,
        'Maghrib prayer',
        Icons.wb_twilight,
      ),
      PrayerListItem(
        'Isha',
        _prayerTimes!.times.isha,
        'Isha prayer',
        Icons.nightlight,
      ),
    ];

    for (final prayer in prayers) {
      final timeParts = prayer.time.split(':');
      final prayerMinutes =
          int.parse(timeParts[0]) * 60 + int.parse(timeParts[1]);

      if (prayerMinutes > currentMinutes) {
        final remainingMinutes = prayerMinutes - currentMinutes;
        final hours = remainingMinutes ~/ 60;
        final minutes = remainingMinutes % 60;

        String remaining = '';
        if (hours > 0) remaining += '${hours}h ';
        remaining += '${minutes}m';

        setState(() {
          _nextPrayer = NextPrayerInfo(
            name: prayer.name,
            time: prayer.time,
            remaining: remaining,
          );
        });
        return;
      }
    }

    // If no prayer left today, show tomorrow's Fajr
    final tomorrowMinutes = (24 * 60) - currentMinutes + (5 * 60);
    final hours = tomorrowMinutes ~/ 60;
    final minutes = tomorrowMinutes % 60;

    setState(() {
      _nextPrayer = NextPrayerInfo(
        name: 'Fajr',
        time: _prayerTimes!.times.fajr,
        remaining: '${hours}h ${minutes}m',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDarkMood();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? QuranAppTheme.darkScaffoldGradient
              : QuranAppTheme.lightScaffoldGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _buildHeader(isDark),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      if (_prayerTimes != null) ...[
                        _buildLocationCard(isDark),
                        const SizedBox(height: 16),
                      ],
                      if (_nextPrayer != null) ...[
                        _buildNextPrayerCard(isDark),
                        const SizedBox(height: 16),
                      ],
                      if (_error != null) ...[
                        _buildErrorCard(isDark),
                        const SizedBox(height: 16),
                      ],
                      if (_isLoading && _prayerTimes == null) ...[
                        _buildLoadingCard(isDark),
                        const SizedBox(height: 16),
                      ],
                      if (_prayerTimes != null) ...[
                        _buildPrayerTimesList(isDark),
                        const SizedBox(height: 24),
                        _buildQuoteCard(isDark),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return FadeTransition(
      opacity: _animationController,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? const Color(0xFF6EE7B7) : const Color(0xFF047857),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prayer Times',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? const Color(0xFF6EE7B7)
                        : const Color(0xFF065F46),
                  ),
                ),
                Text(
                  'Today • ${DateFormat('EEEE, MMMM d').format(DateTime.now())}',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? const Color(0xFF34D399)
                        : const Color(0xFF059669),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _isLoading ? null : _loadPrayerTimes,
            icon: AnimatedRotation(
              turns: _isLoading ? 1 : 0,
              duration: const Duration(seconds: 1),
              child: Icon(
                Icons.refresh,
                color: isDark
                    ? const Color(0xFF6EE7B7)
                    : const Color(0xFF047857),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(bool isDark) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0, 1.0, curve: Curves.easeOut),
            ),
          ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF14B8A6)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _prayerTimes!.location.city,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${_prayerTimes!.location.country} • ${_prayerTimes!.location.timezone}',
                    style: TextStyle(
                      color: Colors.white.withAlpha(204),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextPrayerCard(bool isDark) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0, 1.0, curve: Curves.easeOut),
            ),
          ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFB923C), Color(0xFFF87171)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const Text('🕌', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 8),
            Text(
              'Next: ${_nextPrayer!.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime12Hour(_nextPrayer!.time),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(51),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withAlpha(77)),
              ),
              child: Text(
                'in ${_nextPrayer!.remaining}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF7F1D1D).withAlpha(51)
            : const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF991B1B) : const Color(0xFFFECACA),
        ),
      ),
      child: Column(
        children: [
          Text(
            _error!,
            style: TextStyle(
              color: isDark ? const Color(0xFFFCA5A5) : const Color(0xFFB91C1C),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _loadPrayerTimes,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark
                  ? const Color(0xFF991B1B)
                  : Colors.red.shade100,
              foregroundColor: isDark
                  ? const Color(0xFFFCA5A5)
                  : const Color(0xFFB91C1C),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withAlpha(13)
            : Colors.white.withAlpha(179),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading prayer times...',
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesList(bool isDark) {
    final prayers = [
      PrayerListItem(
        'Fajr',
        _prayerTimes!.times.fajr,
        'Dawn prayer',
        Icons.wb_twilight,
      ),
      PrayerListItem(
        'Sunrise',
        _prayerTimes!.times.sunrise,
        'Sunrise (no prayer)',
        Icons.wb_sunny,
      ),
      PrayerListItem(
        'Dhuhr',
        _prayerTimes!.times.dhuhr,
        'Midday prayer',
        Icons.wb_sunny,
      ),
      PrayerListItem(
        'Asr',
        _prayerTimes!.times.asr,
        'Afternoon prayer',
        Icons.wb_sunny,
      ),
      PrayerListItem(
        'Maghrib',
        _prayerTimes!.times.maghrib,
        'Sunset prayer',
        Icons.wb_twilight,
      ),
      PrayerListItem(
        'Isha',
        _prayerTimes!.times.isha,
        'Night prayer',
        Icons.nightlight,
      ),
    ];

    return Column(
      children: prayers.asMap().entries.map((entry) {
        final index = entry.key;
        final prayer = entry.value;
        final status = _getPrayerStatus(prayer.name, prayer.time);

        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(-0.2, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(
                    0.3 + (index * 0.1),
                    1.0,
                    curve: Curves.easeOut,
                  ),
                ),
              ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildPrayerCard(prayer, status, isDark),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPrayerCard(
    PrayerListItem prayer,
    PrayerStatus status,
    bool isDark,
  ) {
    final isNext = status == PrayerStatus.next;
    final isPassed = status == PrayerStatus.passed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isNext
            ? LinearGradient(
                colors: isDark
                    ? [
                        const Color(0xFF064E3B).withAlpha(77),
                        const Color(0xFF115E59).withAlpha(77),
                      ]
                    : [const Color(0xFFD1FAE5), const Color(0xFFCCFBF1)],
              )
            : null,
        color: isNext
            ? null
            : isPassed
            ? (isDark ? Colors.white.withAlpha(13) : Colors.grey.shade50)
            : (isDark
                  ? Colors.white.withAlpha(18)
                  : Colors.white.withAlpha(179)),
        borderRadius: BorderRadius.circular(16),
        border: isNext
            ? Border.all(
                color: isDark
                    ? const Color(0xFF047857)
                    : const Color(0xFF6EE7B7),
                width: 2,
              )
            : null,
        boxShadow: isNext
            ? [
                BoxShadow(
                  color:
                      (isDark
                              ? const Color(0xFF047857)
                              : const Color(0xFF10B981))
                          .withAlpha(77),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isNext
                  ? (isDark ? const Color(0xFF047857) : const Color(0xFFA7F3D0))
                  : (isDark
                        ? Colors.white.withAlpha(26)
                        : Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              prayer.icon,
              color: isNext
                  ? (isDark ? const Color(0xFF6EE7B7) : const Color(0xFF065F46))
                  : (isDark ? Colors.white54 : Colors.black54),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prayer.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: isNext
                        ? (isDark
                              ? const Color(0xFF6EE7B7)
                              : const Color(0xFF065F46))
                        : (isDark ? Colors.white : Colors.black87),
                  ),
                ),
                Text(
                  prayer.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime12Hour(prayer.time),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
                  fontFamily: 'monospace',
                  color: isNext
                      ? (isDark
                            ? const Color(0xFF6EE7B7)
                            : const Color(0xFF047857))
                      : (isDark ? Colors.white70 : Colors.black87),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isNext
                      ? (isDark
                            ? const Color(0xFF047857)
                            : const Color(0xFFA7F3D0))
                      : isPassed
                      ? (isDark
                            ? Colors.white.withAlpha(26)
                            : Colors.grey.shade300)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isNext
                      ? 'Next'
                      : isPassed
                      ? 'Passed'
                      : '',
                  style: TextStyle(
                    fontSize: 10,
                    color: isNext
                        ? (isDark
                              ? const Color(0xFFD1FAE5)
                              : const Color(0xFF065F46))
                        : (isDark ? Colors.white54 : Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(bool isDark) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0, 1.0, curve: Curves.easeOut),
            ),
          ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF581C87).withAlpha(51),
                    const Color(0xFF1E40AF).withAlpha(51),
                  ]
                : [const Color(0xFFF3E8FF), const Color(0xFFDBEAFE)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const Text('🤲', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 12),
            Text(
              '"And establish prayer at the two ends of the day and at the approach of the night. '
              'Indeed, good deeds do away with misdeeds."',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.white70 : Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '- Quran 11:114',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PrayerStatus _getPrayerStatus(String prayerName, String prayerTime) {
    if (_nextPrayer?.name == prayerName) {
      return PrayerStatus.next;
    }

    final now = DateTime.now();
    final currentMinutes = now.hour * 60 + now.minute;
    final timeParts = prayerTime.split(':');
    final prayerMinutes =
        int.parse(timeParts[0]) * 60 + int.parse(timeParts[1]);

    if (prayerMinutes < currentMinutes) {
      return PrayerStatus.passed;
    }

    return PrayerStatus.upcoming;
  }

  String _formatTime12Hour(String time24) {
    final parts = time24.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$hour12:$minute $period';
  }
}

// Data Models

enum PrayerStatus { next, passed, upcoming }
