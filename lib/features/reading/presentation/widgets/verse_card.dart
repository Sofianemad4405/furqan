import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/core/entities/audio_entity.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/entities/tafsir_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/reading/domain/entities/tafsir_provider_entity.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:furqan/features/reading/presentation/widgets/tafsir_provider_tile.dart';
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
  List<TafsirProviderEntity> tafsirProviders = [];
  VerseTafsirEntity? verseTafsir;
  @override
  void initState() {
    log("Toffy");
    getTafsirProviders();
    super.initState();
  }

  Future<void> getTafsirProviders() async {
    try {
      log("getting");
      final providers = await context.read<ReadingCubit>().getTafsirProviders();
      setState(() {
        tafsirProviders = providers;
      });
      log("provo");
      if (providers.isNotEmpty) {
        log("getting verse tafsir");
        getVerseTafsir(providers[0].id);
      }
    } on Exception catch (e) {
      log("lol ${e.toString()}");
    }
  }

  Future<VerseTafsirEntity> getVerseTafsir(int tafseerId) async {
    final verseTafsir = await context.read<ReadingCubit>().getVerseTafsir(
      tafseerId,
      widget.surah.surahNo,
      widget.ayahNumber,
    );
    return verseTafsir;
  }

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
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onSurface,
                              BlendMode.srcIn,
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        log("DIalog");
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.surface,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Container(
                                height: 500,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svgs/bookopen-icon.svg",
                                            height: 24,
                                            width: 24,
                                            colorFilter: const ColorFilter.mode(
                                              Color(0xff72C1A6),
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const Gap(5),
                                          Text(
                                            "Tafsir - Ayah ${widget.ayahNumber}",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineSmall,
                                          ),
                                          const Spacer(),
                                          const Icon(Icons.close, size: 16),
                                        ],
                                      ),
                                      const Gap(5),
                                      Text(
                                        "Explore various scholarly interpretations and explanations for this verse. Tap on any tafsir to expand its content.",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                        textAlign: TextAlign.center,
                                      ),
                                      const Gap(5),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surfaceContainerHighest,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${tafsirProviders.length} Tafsirs Available",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleSmall,
                                          ),
                                        ),
                                      ),
                                      const Gap(5),
                                      Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: tafsirProviders.length,
                                          itemBuilder: (context, index) {
                                            final tafsirProvider =
                                                tafsirProviders[index];
                                            log(tafsirProvider.author);
                                            return Padding(
                                              padding: const EdgeInsets.all(
                                                4.0,
                                              ),
                                              child: BlocBuilder<ThemeCubit, ThemeMode>(
                                                builder: (context, state) {
                                                  return TafsirProviderTile(
                                                    tafsirProvider:
                                                        tafsirProvider,
                                                    isDark:
                                                        state == ThemeMode.dark,
                                                    children: [
                                                      FutureBuilder(
                                                        future: getVerseTafsir(
                                                          tafsirProvider.id,
                                                        ),
                                                        builder: (context, snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                              "Error: ${snapshot.error}",
                                                            );
                                                          } else if (!snapshot
                                                              .hasData) {
                                                            return const Text(
                                                              "No Tafsir",
                                                            );
                                                          }

                                                          final verseTafsir =
                                                              snapshot.data!;
                                                          return Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  state ==
                                                                      ThemeMode
                                                                          .dark
                                                                  ? QuranAppTheme
                                                                        .tafsirSecondContainerBorderDark
                                                                  : Colors
                                                                        .transparent,
                                                              border: Border.all(
                                                                width: 0.2,
                                                                color:
                                                                    const Color(
                                                                      0xff9EEAC7,
                                                                    ),
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius.all(
                                                                    Radius.circular(
                                                                      8,
                                                                    ),
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                    16,
                                                                  ),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: const BorderRadius.all(
                                                                            Radius.circular(
                                                                              8,
                                                                            ),
                                                                          ),
                                                                          color:
                                                                              const Color(
                                                                                0xff00B578,
                                                                              ).withValues(
                                                                                alpha: 0.05,
                                                                              ),
                                                                          border: Border.all(
                                                                            width:
                                                                                0.2,
                                                                            color: const Color(
                                                                              0xff9EEAC7,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                12,
                                                                            vertical:
                                                                                4,
                                                                          ),
                                                                          child: Text(
                                                                            "Ayah ${widget.ayahNumber}",
                                                                            style:
                                                                                Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodySmall?.copyWith(
                                                                                  color: const Color(
                                                                                    0xff00B578,
                                                                                  ),
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const Spacer(),
                                                                      Text(
                                                                        "Tafseer ID: ${tafsirProvider.id}",
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.bodySmall?.copyWith(
                                                                              color: const Color(
                                                                                0xff00B578,
                                                                              ),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const Gap(10),
                                                                  Text(
                                                                    verseTafsir
                                                                        .text,
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyLarge
                                                                        ?.copyWith(
                                                                          fontFamily:
                                                                              "Amiri",
                                                                        ),
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
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
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/svgs/bookopen-icon.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
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
                        widget.surah.arabic1?[widget.ayahNumber - 1] ??
                            "Ayah Not found",
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
                  widget.surah.english?[widget.ayahNumber - 1] ??
                      "Translate Not found",
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
