import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/entities/audio_entity.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:furqan/features/reading/presentation/widgets/verse_card.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

class ReadingSurah extends StatefulWidget {
  const ReadingSurah({super.key, required this.surah});

  final SurahEntity surah;

  @override
  State<ReadingSurah> createState() => _ReadingSurahState();
}

class _ReadingSurahState extends State<ReadingSurah> {
  int ayahNumber = 1;
  final player = AudioPlayer();
  int ayahsRead = 0;

  List<AudioEntity> surahVerses = [];
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    getVersesAudios();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
    super.initState();
  }

  String formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }

  Future<void> getVersesAudios() async {
    final audios = await context.read<ReadingCubit>().getVerseAudios(
      widget.surah.surahNo,
      ayahNumber,
    );
    surahVerses = audios;
  }

  @override
  void dispose() {
    _timer.cancel();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SurahStats(
                        icon: const Icon(
                          Icons.alarm,
                          color: Color(0xff598BF3),
                          size: 15,
                        ),
                        title: 'Reading\nTime',
                        iconColor: const Color(0xff598BF3),
                        topColumn: Text(
                          formatTime(_seconds),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: SurahStats(
                        icon: const Icon(
                          Icons.menu_book_sharp,
                          color: Color(0xff27A57A),
                          size: 20,
                        ),
                        title: 'Ayahs\nRead',
                        iconColor: const Color(0xff27A57A),
                        topColumn: Text(
                          ayahsRead.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: SurahStats(
                        icon: Center(
                          child: Text(
                            "✨",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        title: 'Hasanat',
                        iconColor: const Color(0xffDDB557),
                        topColumn: Text(
                          "${ayahsRead * 10}",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(50),
              VerseCard(
                surah: widget.surah,
                ayahNumber: ayahNumber,
                player: player,
                surahVerses: surahVerses,
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///Previous Ayah
                  GestureDetector(
                    onTap: () {
                      if (ayahNumber > 1) {
                        setState(() {
                          ayahNumber--;
                        });
                      }
                      if (ayahNumber == 1) {
                        context
                            .read<ReadingCubit>()
                            .toggleToSurahSelectionMode();
                      }
                    },
                    child: CustomContainer(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios, size: 12),
                            const Gap(10),
                            Text(
                              "Previous",
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text("$ayahNumber of ${widget.surah.totalAyah}"),

                  ///Next Ayah
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (ayahNumber < widget.surah.totalAyah) {
                          ayahNumber++;
                          ayahsRead++;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: QuranAppTheme.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Next",
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            const Gap(10),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(200),
            ],
          ),
        );
      },
    );
  }
}

class SurahStats extends StatelessWidget {
  const SurahStats({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.topColumn,
  });
  final Widget icon;
  final String title;
  final Color iconColor;
  final Widget topColumn;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return CustomContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: topColumn,
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: state == ThemeMode.dark
                              ? iconColor.withValues(alpha: 0.4)
                              : iconColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: icon,
                      ),
                      const Gap(10),
                      Text(title, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
