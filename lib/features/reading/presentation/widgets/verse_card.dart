import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/core/entities/audio_entity.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

class VerseCard extends StatefulWidget {
  const VerseCard({
    super.key,
    required this.surah,
    required this.ayahNumber,
    required this.player,
    required this.surahVerses,
  });

  final SurahEntity surah;
  final int ayahNumber;
  final AudioPlayer player;
  final List<AudioEntity> surahVerses;

  @override
  State<VerseCard> createState() => _VerseCardState();
}

class _VerseCardState extends State<VerseCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
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
                              ?.copyWith(color: const Color(0xff1D6E58)),
                        ),
                        Text(
                          "Ayah ${widget.ayahNumber}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        log(widget.player.duration.toString());
                        if (widget.player.playing) {
                          await widget.player.pause();
                        } else {
                          try {
                            await widget.player.setUrl(
                              widget.surahVerses[widget.ayahNumber - 1].url,
                            );
                            await widget.player.play();
                          } catch (e) {
                            log("${e.toString()} ${e.runtimeType}");
                          }
                        }
                      },
                      child: StreamBuilder<PlayerState>(
                        stream: widget.player.playerStateStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          final playing = state?.playing ?? false;
                          final completed =
                              state?.processingState ==
                              ProcessingState.completed;
                          return SvgPicture.asset(
                            (playing && !completed)
                                ? "assets/svgs/pause-icon.svg"
                                : "assets/svgs/volume2-icon.svg",
                            height: 24,
                            width: 24,
                          );
                        },
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
                StreamBuilder<PlayerState>(
                  stream: widget.player.playerStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    final playing = state?.playing ?? false;
                    final buffering =
                        state?.processingState == ProcessingState.buffering;
                    final completed =
                        state?.processingState == ProcessingState.completed;

                    return Container(
                      decoration: BoxDecoration(
                        color: (playing && !buffering && !completed)
                            ? QuranAppTheme.green
                            : Colors.transparent,
                      ),
                      child: Text(
                        widget.surah.arabic1[widget.ayahNumber - 1],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontFamily: "Amiri",
                          fontSize: 24,
                        ),
                        maxLines: 90,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  },
                ),
                const Gap(50),
                const Divider(thickness: 1),
                const Gap(20),
                Text(
                  widget.surah.english[widget.ayahNumber - 1],
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
