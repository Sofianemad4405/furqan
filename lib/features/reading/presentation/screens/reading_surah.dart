import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/core/entities/audio_entity.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
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
  bool isPlaying = false;
  final player = AudioPlayer();

  List<AudioEntity> surahVerses = [];

  @override
  void initState() {
    getVersesAudios();
    super.initState();
  }

  Future<void> getVersesAudios() async {
    final audios = await context.read<ReadingCubit>().getVerseAudios(
      widget.surah.surahNo,
      ayahNumber,
    );
    surahVerses = audios;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return Column(
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
                        '1:08',
                        style: Theme.of(context).textTheme.labelMedium,
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
                        size: 15,
                      ),
                      title: 'Ayahs\nRead',
                      iconColor: const Color(0xff27A57A),
                      topColumn: Text(
                        '1:08',
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
                        '1:08',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(50),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, state) {
                return CustomContainer(
                  isDarkMood: state == ThemeMode.dark,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.save_outlined,
                              color: state == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            Icon(
                              Icons.favorite_border,
                              color: state == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  widget.surah.surahName,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        color: const Color(0xff1D6E58),
                                      ),
                                ),
                                Text(
                                  "Ayah $ayahNumber",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (isPlaying) {
                                  await player.pause();
                                } else {
                                  try {
                                    await player.setUrl(
                                      surahVerses[ayahNumber - 1].url,
                                    );
                                    await player.play();
                                  } catch (e) {
                                    log("${e.toString()} ${e.runtimeType}");
                                  }
                                }
                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              },
                              child: SvgPicture.asset(
                                "assets/svgs/volume2-icon.svg",
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/svgs/bookopen-icon.svg",
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.onSurface,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                        const Gap(50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.surah.arabic1[ayahNumber - 1],
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontFamily: "Amiri", fontSize: 24),
                              maxLines: 90,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const Gap(50),
                        const Divider(thickness: 1),
                        const Gap(20),
                        Text(
                          widget.surah.english[ayahNumber - 1],
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
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
          isDarkMood: state == ThemeMode.dark,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    topColumn,
                    Text(title, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
