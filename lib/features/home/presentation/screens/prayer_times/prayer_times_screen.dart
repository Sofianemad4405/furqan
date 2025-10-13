import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/screens/today_challenges/widgets/streak.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _LightColors()
        : _DarkColors();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ///Header
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Gap(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prayer Times",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: colors.prayerTimes,
                                fontSize: 18,
                              ),
                        ),
                        Text(
                          "Today • Monday, October 13",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: colors.prayerTimes),
                        ),
                      ],
                    ),
                  ],
                ),

                const Gap(20),

                ///Current Location
                Container(
                  // height: 40,
                  decoration: BoxDecoration(
                    color: colors.currentLocation,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(Iconsax.location, color: Colors.white),
                        Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Location",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Unknown • Africa/Cairo",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(20),

                ///Prayer Times
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: colors.nextPrayerGradient),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("🕌", style: TextStyle(fontSize: 28)),
                        const Gap(5),
                        Text(
                          "Next: Fajr",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const Gap(5),
                        Text(
                          "05:30 AM",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const Gap(5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white.withAlpha(20),
                            border: Border.all(color: Colors.white),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 4,
                            ),
                            child: Text(
                              "in 3h 40m",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(20),

                ///List Of Prayers
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return _buildPrayerTile(true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

abstract class ColorScheme {
  Color get prayerTimes;
  Color get currentLocation;
  List<Color> get nextPrayerGradient;
  Color get passedPrayerIcon;
  Color get nextPrayerIcon;
  Color get nextPrayerName;
  Color get borderColor;
}

class _LightColors implements ColorScheme {
  @override
  Color get prayerTimes => const Color(0xFF005C5D);

  @override
  Color get currentLocation => const Color(0xFF00B491);

  @override
  List<Color> get nextPrayerGradient => [
    const Color(0xFFF5830C),
    const Color(0xFFF56261),
  ];

  @override
  Color get borderColor => const Color(0xFF007552);

  @override
  Color get nextPrayerName => const Color(0xFF46BDDF);

  @override
  // TODO: implement passedPrayerIcon
  Color get passedPrayerIcon => throw UnimplementedError();

  @override
  // TODO: implement nextPrayerIcon
  Color get nextPrayerIcon => const Color(0xFF9EEAC7);
}

class _DarkColors implements ColorScheme {
  @override
  Color get prayerTimes => const Color(0xFF5AE0AE);

  @override
  Color get currentLocation => const Color(0xFF00B491);

  @override
  List<Color> get nextPrayerGradient => [
    const Color(0xFFF5830C),
    const Color(0xFFF56261),
  ];

  @override
  // TODO: implement borderColor
  Colors get borderColor => throw UnimplementedError();

  @override
  // TODO: implement nextPrayerName
  Color get nextPrayerName => throw UnimplementedError();

  @override
  // TODO: implement passedPrayerIcon
  Color get passedPrayerIcon => throw UnimplementedError();
}

Widget _buildPrayerTile(bool isNext) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: isNext ? const Color(0xFF007552) : Colors.transparent,
      ),
    ),
    child: Row(children: [

      ],
    ),
  );
}
