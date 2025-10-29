import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/entities/audio_entity.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/entities/tafsir_entity.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/reading/domain/entities/tafsir_provider_entity.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:furqan/features/reading/presentation/screens/listening_to_surah.dart';
import 'package:furqan/features/reading/presentation/widgets/tafsir_provider_tile.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_audio/just_audio.dart';

class VerseCard extends StatefulWidget {
  const VerseCard({
    super.key,
    required this.surah,
    required this.ayahNumber,
    required this.player,
    required this.verseAudios,
    this.openSheet,
    this.toggleAyahToLikes,
    required this.isLiked,
  });

  final SurahEntity surah;
  final int ayahNumber;
  final AudioPlayer player;
  final List<AudioEntity> verseAudios;
  final Function()? openSheet;
  final Function()? toggleAyahToLikes;
  final bool isLiked;

  @override
  State<VerseCard> createState() => _VerseCardState();
}

class _VerseCardState extends State<VerseCard> {
  List<TafsirProviderEntity> tafsirProviders = [];
  VerseTafsirEntity? verseTafsir;
  Map<String, String> reciters = {};
  String currentReciter = "";
  int reciterId = 1;
  bool hasChangedReciter = false;

  Future<void> setCurrentReciter(String reciter) async {
    currentReciter = reciter;
    setState(() {});
  }

  @override
  void initState() {
    getTafsirProviders();
    _loadReciters();
    super.initState();
  }

  ///load reciters
  Future<void> _loadReciters() async {
    reciters = await context.read<ReadingCubit>().getAvailableReciters();
    currentReciter = reciters.keys.first;
    reciterId = sl<Prefs>().readingModeDefaultReciter;
  }

  ///get tafsir providers
  Future<void> getTafsirProviders() async {
    try {
      log("getting");
      final providers = await context.read<ReadingCubit>().getTafsirProviders();
      setState(() {
        tafsirProviders = providers;
      });
      // log("provo");
      // if (providers.isNotEmpty) {
      //   log("getting verse tafsir");
      // } else {
      //   log("no tafsir providers");
      // }
      log("ana ${providers[0].bookName}");
      getVerseTafsir(providers[0].id);
    } on Exception catch (e) {
      log("kiiaan ${e.toString()}");
    }
  }

  ///get verse tafsir
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
    final isDark = context.watch<ThemeCubit>().isDarkMood();
    final ayahColor = isDark
        ? const Color(0xff005C47)
        : const Color(0xff9DEACA);
    final surahNameColor = isDark
        ? const Color(0xff56D4A6)
        : const Color(0xff1D6E58);
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return CustomContainer(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.ios_share_outlined,
                        color: state == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),

                    ///like/unlike
                    IconButton(
                      onPressed: widget.toggleAyahToLikes,
                      icon: Icon(
                        widget.isLiked ? Iconsax.heart5 : Iconsax.heart,
                        color: widget.isLiked
                            ? Colors.red
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),

                    ///surah name and ayah number
                    GestureDetector(
                      onTap: widget.openSheet,
                      child: Column(
                        children: [
                          Text(
                            widget.surah.surahName,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: surahNameColor),
                          ),
                          Text(
                            "Ayah ${widget.ayahNumber}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),

                    ///select reciter
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) {
                            return buildBlurredSheet(
                              color: Theme.of(
                                context,
                              ).colorScheme.inverseSurface,
                              list: reciters.values.toList(),
                              child: Column(
                                children: [
                                  const Gap(20),
                                  Text(
                                    "Select Reciter",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const Gap(20),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: reciters.length,
                                      itemBuilder: (context, index) {
                                        bool isThisSheikhPlaying =
                                            currentReciter ==
                                            reciters.values.toList()[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: isThisSheikhPlaying
                                                ? Border.all(
                                                    color: const Color(
                                                      0xff005C42,
                                                    ),
                                                  )
                                                : null,
                                            borderRadius: isThisSheikhPlaying
                                                ? BorderRadius.circular(12)
                                                : null,
                                            color: isThisSheikhPlaying
                                                ? const Color(
                                                    0xff005C42,
                                                  ).withValues(alpha: 0.1)
                                                : null,
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              setCurrentReciter(
                                                reciters.values.toList()[index],
                                              );
                                              sl<Prefs>()
                                                  .saveReadingModeDefaultReciter(
                                                    index,
                                                  );
                                              log(reciterId.toString());
                                              log(index.toString());
                                              log(hasChangedReciter.toString());
                                              bool isDifferent =
                                                  reciterId != index;
                                              reciterId = index;
                                              hasChangedReciter = isDifferent;
                                            },
                                            leading: Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 2,
                                                ),
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  recitersImgs[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              reciters.values.toList()[index],
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                            ),
                                            trailing: Text(
                                              reciterMapper(
                                                reciters.values.toList()[index],
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontFamily: "Amiri",
                                                  ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/svgs/microphone-svgrepo-com.svg",
                        height: 30,
                        width: 30,
                      ),
                    ),

                    ///play/pause
                    GestureDetector(
                      onTap: () async {
                        log(widget.player.duration.toString());
                        if (widget.player.playing) {
                          await widget.player.pause();
                        } else {
                          try {
                            await widget.player.setUrl(
                              widget.verseAudios[reciterId].url,
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

                    ///tafsir
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
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              size: 16,
                                            ),
                                          ),
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
                                            return Padding(
                                              padding: const EdgeInsets.all(
                                                4.0,
                                              ),
                                              child: BlocBuilder<ThemeCubit, ThemeMode>(
                                                builder: (context, state) {
                                                  log(
                                                    "sofiiaaan: ${tafsirProvider.id}",
                                                  );
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
                                                          log(
                                                            "verse tafsir: ${verseTafsir.text}",
                                                          );
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
                        borderRadius: BorderRadius.circular(12),
                        color: (playing && !buffering && !completed)
                            ? ayahColor
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.surah.arabic1?[widget.ayahNumber - 1] ??
                              "Ayah Not found",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontFamily: "Amiri", fontSize: 24),
                          maxLines: 90,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
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
