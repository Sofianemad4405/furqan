// import 'package:flutter/material.dart';
// import 'package:furqan/features/home/presentation/screens/today_challenges/widgets/streak.dart';
// import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
// import 'package:gap/gap.dart';
// import 'package:iconsax/iconsax.dart';

// class PrayerTimesScreen extends StatefulWidget {
//   const PrayerTimesScreen({super.key});

//   @override
//   State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
// }

// class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).brightness == Brightness.light
//         ? _LightColors()
//         : _DarkColors();
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Header
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.arrow_back),
//                     ),
//                     const Gap(5),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Prayer Times",
//                           style: Theme.of(context).textTheme.titleMedium
//                               ?.copyWith(
//                                 color: colors.prayerTimes,
//                                 fontSize: 18,
//                               ),
//                         ),
//                         Text(
//                           "Today • Monday, October 13",
//                           style: Theme.of(context).textTheme.bodyLarge
//                               ?.copyWith(color: colors.prayerTimes),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const Gap(20),

//                 /// Current Location
//                 Container(
//                   decoration: BoxDecoration(
//                     color: colors.currentLocation,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.all(12.0),
//                   child: const Row(
//                     children: [
//                       Icon(Iconsax.location, color: Colors.white),
//                       Gap(10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Current Location",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             "Unknown • Africa/Cairo",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Gap(20),

//                 /// Next Prayer Box
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     gradient: LinearGradient(colors: colors.nextPrayerGradient),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 28),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("🕌", style: TextStyle(fontSize: 28)),
//                       const Gap(5),
//                       Text(
//                         "Next: Fajr",
//                         style: Theme.of(
//                           context,
//                         ).textTheme.titleMedium?.copyWith(color: Colors.white),
//                       ),
//                       const Gap(5),
//                       Text(
//                         "05:30 AM",
//                         style: Theme.of(
//                           context,
//                         ).textTheme.titleMedium?.copyWith(color: Colors.white),
//                       ),
//                       const Gap(5),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(4),
//                           color: Colors.white.withAlpha(20),
//                           border: Border.all(color: Colors.white),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 2,
//                           horizontal: 4,
//                         ),
//                         child: const Text(
//                           "in 3h 40m",
//                           style: TextStyle(color: Colors.white, fontSize: 8),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Gap(20),

//                 /// List of Prayers
//                 // ListView.builder(
//                 //   shrinkWrap: true,
//                 //   itemCount: 5,
//                 //   itemBuilder: (context, index) {
//                 //     return _buildPrayerTile(true, colors, context);
//                 //   },
//                 // ),
//                 _buildPrayerTile(true, colors, context),
//                 _buildPrayerTile(false, colors, context),
//                 _buildPrayerTile(false, colors, context),
//                 _buildPrayerTile(false, colors, context),
//                 _buildPrayerTile(false, colors, context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// abstract class ColorScheme {
//   Color get prayerTimes;
//   Color get currentLocation;
//   List<Color> get nextPrayerGradient;
//   Color get passedPrayerIcon;
//   Color get nextPrayerIcon;
//   Color get nextPrayerName;
//   Color get borderColor;
//   Color get passedPrayerNameColor;
//   Color get tile;
//   Color get next;
// }

// class _LightColors implements ColorScheme {
//   @override
//   Color get prayerTimes => const Color(0xFF005C5D);

//   @override
//   Color get currentLocation => const Color(0xFF00B491);

//   @override
//   List<Color> get nextPrayerGradient => [
//     const Color(0xFFF5830C),
//     const Color(0xFFF56261),
//   ];

//   @override
//   Color get borderColor => const Color(0xFF5DE6B3);

//   @override
//   Color get nextPrayerName => const Color(0xff00756A);

//   @override
//   Color get passedPrayerIcon => const Color(0xFFE9ECED);

//   @override
//   Color get nextPrayerIcon => const Color(0xFF9EEAC7);

//   @override
//   Color get passedPrayerNameColor => const Color(0xFF5E6972);

//   @override
//   Color get tile => const Color(0xFFC5F1E2);

//   @override
//   Color get next => const Color(0xFF9EEAC7);
// }

// class _DarkColors implements ColorScheme {
//   @override
//   Color get prayerTimes => const Color(0xFF5AE0AE);

//   @override
//   Color get currentLocation => const Color(0xFF00B491);

//   @override
//   List<Color> get nextPrayerGradient => [
//     const Color(0xFFF5830C),
//     const Color(0xFFF56261),
//   ];

//   @override
//   Color get borderColor => const Color(0xFF007552);

//   @override
//   Color get nextPrayerName => const Color(0xFF5AE0AE);

//   @override
//   Color get passedPrayerIcon => const Color(0xFF343E50);

//   @override
//   Color get nextPrayerIcon => const Color(0xFF005C42);

//   @override
//   Color get passedPrayerNameColor => const Color(0xFF8C929C);

//   @override
//   Color get tile => const Color(0xFF132F36);

//   @override
//   Color get next => const Color(0xFF005C42);
// }

// Widget _buildPrayerTile(bool isNext, ColorScheme colors, BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 8),
//     child: CustomContainer(
//       decoration: BoxDecoration(
//         color: isNext ? colors.tile : null,
//         border: Border.all(
//           color: isNext ? const Color(0xFF007552) : Colors.transparent,
//         ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListTile(
//           contentPadding: EdgeInsets.zero,
//           leading: Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isNext ? colors.nextPrayerIcon : colors.passedPrayerIcon,
//             ),
//             child: const Center(child: Icon(Icons.sunny)),
//           ),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Fagr",
//                 style: Theme.of(
//                   context,
//                 ).textTheme.titleLarge?.copyWith(color: colors.nextPrayerName),
//               ),
//               Text(
//                 "Dawn prayer",
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: colors.passedPrayerNameColor,
//                 ),
//               ),
//             ],
//           ),
//           trailing: Column(
//             children: [
//               Text(
//                 "5:10 AM",
//                 style: Theme.of(
//                   context,
//                 ).textTheme.titleLarge?.copyWith(color: colors.nextPrayerName),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: colors.next,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Next",
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: colors.nextPrayerName,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Prayer Times Screen - Complete Flutter Implementation
/// Matches the design of your React FurQan Quran app
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.forward();
    _loadPrayerTimes();
    _startNextPrayerTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadPrayerTimes() {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Simulate API call - Replace with actual prayer times API
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
              city: 'Current Location',
              country: 'Unknown',
              timezone: 'UTC+3',
            ),
          );
          _updateNextPrayer();
          _isLoading = false;
        });
      }
    });
  }

  void _startNextPrayerTimer() {
    // Update next prayer every minute
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
      PrayerInfo('Fajr', _prayerTimes!.times.fajr),
      PrayerInfo('Sunrise', _prayerTimes!.times.sunrise),
      PrayerInfo('Dhuhr', _prayerTimes!.times.dhuhr),
      PrayerInfo('Asr', _prayerTimes!.times.asr),
      PrayerInfo('Maghrib', _prayerTimes!.times.maghrib),
      PrayerInfo('Isha', _prayerTimes!.times.isha),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF064E3B), // emerald-950
                    const Color(0xFF115E59), // teal-950
                    const Color(0xFF164E63), // cyan-950
                  ]
                : [
                    const Color(0xFFECFDF5), // emerald-50
                    const Color(0xFFCCFBF1), // teal-50
                    const Color(0xFFCFFAFE), // cyan-50
                  ],
          ),
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
              curve: const Interval(0.1, 1.0, curve: Curves.easeOut),
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
                      color: Colors.white.withOpacity(0.8),
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
              curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
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
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
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
            ? const Color(0xFF7F1D1D).withOpacity(0.2)
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
            ? Colors.white.withOpacity(0.05)
            : Colors.white.withOpacity(0.7),
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
                        const Color(0xFF064E3B).withOpacity(0.3),
                        const Color(0xFF115E59).withOpacity(0.3),
                      ]
                    : [const Color(0xFFD1FAE5), const Color(0xFFCCFBF1)],
              )
            : null,
        color: isNext
            ? null
            : isPassed
            ? (isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade50)
            : (isDark
                  ? Colors.white.withOpacity(0.07)
                  : Colors.white.withOpacity(0.7)),
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
                          .withOpacity(0.3),
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
                        ? Colors.white.withOpacity(0.1)
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
                            ? Colors.white.withOpacity(0.1)
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
              curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
            ),
          ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF581C87).withOpacity(0.2),
                    const Color(0xFF1E40AF).withOpacity(0.2),
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
class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });
}

class LocationData {
  final String city;
  final String country;
  final String timezone;

  LocationData({
    required this.city,
    required this.country,
    required this.timezone,
  });
}

class PrayerTimesData {
  final DateTime date;
  final PrayerTimes times;
  final LocationData location;

  PrayerTimesData({
    required this.date,
    required this.times,
    required this.location,
  });
}

class NextPrayerInfo {
  final String name;
  final String time;
  final String remaining;

  NextPrayerInfo({
    required this.name,
    required this.time,
    required this.remaining,
  });
}

class PrayerInfo {
  final String name;
  final String time;

  PrayerInfo(this.name, this.time);
}

class PrayerListItem {
  final String name;
  final String time;
  final String description;
  final IconData icon;

  PrayerListItem(this.name, this.time, this.description, this.icon);
}

enum PrayerStatus { next, passed, upcoming }
