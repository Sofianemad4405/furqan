import 'dart:math' hide log;
import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_audio/just_audio.dart';

class ListeningToSurah extends StatefulWidget {
  const ListeningToSurah({super.key, required this.surah});
  final SurahEntity surah;

  @override
  State<ListeningToSurah> createState() => _ListeningToSurahState();
}

class _ListeningToSurahState extends State<ListeningToSurah> {
  //audio player
  final player = AudioPlayer();

  ///Current Playing Surah
  SurahEntity? currentPlayingSurah;

  ///current reciter
  String currentReciter = "";
  bool hasChangedReciter = false;

  ///current surah duration
  Duration? currentSurahDuration;

  ///All Surahs
  List<SurahBaseEntity> surahs = [];

  ///All reciters
  Map<String, String> reciters = {};

  int reciterId = 1;
  @override
  void initState() {
    super.initState();
    _loadRecitersAndSurahs();
    _initializeAudio();
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        nextSurah();
      }
    });

    player.playbackEventStream.listen(
      null,
      onError: (Object e, StackTrace st) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
        }
      },
    );
  }

  Future<void> _initializeAudio() async {
    try {
      final url = widget.surah.surahAudio["1"]?.url;
      if (url != null && url.isNotEmpty) {
        await player.setUrl(url);
        await getCurrentSurahDuration(widget.surah.surahNo);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load audio: $e')));
      }
    }
  }

  Future<void> _loadRecitersAndSurahs() async {
    currentPlayingSurah = widget.surah;
    reciters = await context.read<ReadingCubit>().getAvailableReciters();
    surahs = await context.read<ReadingCubit>().getAllSurahs();

    // Make sure we have reciters before accessing
    if (reciters.isNotEmpty) {
      String firstReciterId = reciters.keys.first;
      currentReciter = reciters[firstReciterId] ?? "";
      reciterId = int.tryParse(firstReciterId) ?? 0;
      hasChangedReciter = true; // Force audio reload with new reciter

      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> setCurrentReciter(String reciter, String reciterId) async {
    currentReciter = reciter;
    this.reciterId = int.tryParse(reciterId) ?? 0;
    hasChangedReciter = true;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> setCurrentSurah(SurahEntity surah) async {
    currentPlayingSurah = surah;
    setState(() {});
  }

  Future<void> controlSurah() async {
    try {
      if (player.playing) {
        await player.pause();
      } else {
        if (player.audioSource == null || hasChangedReciter) {
          // Use reciterId directly since it's now properly initialized
          final url =
              currentPlayingSurah?.surahAudio[reciterId.toString()]?.url;
          print('Debug - Audio URL: $url'); // Add debug print
          if (url != null && url.isNotEmpty) {
            await player.setUrl(url);
            hasChangedReciter = false;
          } else {
            throw Exception('Invalid audio URL');
          }
        }
        await player.play();
      }
    } catch (e) {
      print('Debug - Audio error: $e'); // Add debug print
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to play audio: $e')));
      }
    }
  }

  Future<void> getCurrentSurahDuration(int surahNo) async {
    currentPlayingSurah = await context.read<ReadingCubit>().getSurah(surahNo);
    final surahAudio =
        currentPlayingSurah?.surahAudio[(reciterId + 1).toString()]!.url;
    await player.setUrl(surahAudio!);
    await player.play();
    final duration = await player.durationStream.firstWhere((d) => d != null);
    setState(() {
      currentSurahDuration = duration;
    });
  }

  Future<void> previousSurah() async {
    player.stop();
    currentPlayingSurah = await context.read<ReadingCubit>().getSurah(
      currentPlayingSurah!.surahNo - 1,
    );
    getCurrentSurahDuration(currentPlayingSurah!.surahNo);
    player.setUrl(
      currentPlayingSurah!.surahAudio[(reciterId + 1).toString()]!.url,
    );
    player.play();
    setState(() {});
  }

  Future<void> nextSurah() async {
    player.stop();
    currentPlayingSurah = await context.read<ReadingCubit>().getSurah(
      currentPlayingSurah!.surahNo + 1,
    );
    getCurrentSurahDuration(currentPlayingSurah!.surahNo);
    player.setUrl(
      currentPlayingSurah!.surahAudio[(reciterId + 1).toString()]!.url,
    );
    player.play();
    setState(() {});
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Heading
          Text(
            "Listening Mode",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(color: const Color(0xff00B590)),
          ),
          const Gap(5),
          Text(
            "Immerse yourself in Quranic recitation Melodic",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Gap(30),

          ///Main Card
          CustomContainer(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ///Surah ,Like & options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   surahIcons[(currentPlayingSurah?.surahNo ?? 1) - 1],
                      //   style: const TextStyle(fontSize: 18),
                      // ),
                      const Gap(10),
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
                                list: surahs,
                                child: Column(
                                  children: [
                                    const Gap(10),
                                    Text(
                                      "Select Surah",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge,
                                    ),
                                    const Gap(10),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: surahs.length,
                                        itemBuilder: (context, index) {
                                          bool isThisSurahPlaying =
                                              currentPlayingSurah?.surahNo ==
                                              index + 1;
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: isThisSurahPlaying
                                                  ? Border.all(
                                                      color: const Color(
                                                        0xff005C42,
                                                      ),
                                                    )
                                                  : null,
                                              borderRadius: isThisSurahPlaying
                                                  ? BorderRadius.circular(12)
                                                  : null,
                                              color: isThisSurahPlaying
                                                  ? const Color(
                                                      0xff005C42,
                                                    ).withValues(alpha: 0.1)
                                                  : null,
                                            ),
                                            child: ListTile(
                                              onTap: () async {
                                                final newSurah = await context
                                                    .read<ReadingCubit>()
                                                    .getSurah(index + 1);
                                                setCurrentSurah(newSurah);
                                                getCurrentSurahDuration(
                                                  newSurah.surahNo,
                                                );
                                                Navigator.pop(context);
                                                await controlSurah();
                                              },
                                              leading: Text(
                                                surahIcons[index],
                                                style: const TextStyle(
                                                  fontSize: 24,
                                                ),
                                              ),
                                              title: Text(
                                                surahs[index].surahName,
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                    "${surahs[index].totalAyah} Ayahs  •  ",
                                                  ),
                                                  Text(
                                                    surahs[index]
                                                        .revelationPlace,
                                                  ),
                                                ],
                                              ),
                                              trailing: Text(
                                                surahs[index].surahNameArabic,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
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
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  currentPlayingSurah!.surahName,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  currentPlayingSurah!.surahNameArabicLong,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontFamily: "Amiri"),
                                ),
                              ],
                            ),
                            const Gap(10),
                            const Icon(Iconsax.arrow_down_14),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Iconsax.heart),
                        onPressed: () {},
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.more),
                      ),
                    ],
                  ),
                  const Gap(10),

                  ///Reciter
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor:
                            Colors.transparent, // مهم علشان نعمل البلور
                        isScrollControlled: true,
                        builder: (context) {
                          return buildBlurredSheet(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            list: reciters.values.toList(),
                            child: Column(
                              children: [
                                const Gap(20),
                                Text(
                                  "Select Reciter",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const Gap(20),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: reciters.length,
                                    itemBuilder: (context, index) {
                                      bool isThisSheikhPlaying =
                                          currentReciter == reciters[index];
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
                                              reciters.keys.toList()[index],
                                            );
                                            getCurrentSurahDuration(
                                              currentPlayingSurah!.surahNo,
                                            );
                                            player.stop();
                                            Navigator.pop(context);
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
                                                ?.copyWith(fontFamily: "Amiri"),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.watch<ThemeCubit>().isDarkMood()
                            ? const Color(0xff022525)
                            : const Color(0xffDBEFEB),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white, // الخلفية البيضا
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).dividerColor, // لون البوردر
                                  width: 1,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  recitersImgs[reciterId],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentReciter,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelLarge,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        reciterMapper(currentReciter),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontFamily: "Amiri"),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      const Gap(5),
                                      const Icon(Iconsax.arrow_down_14),
                                    ],
                                  ),
                                  Text(
                                    "Kuwait • Melodic",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),

                  ///timeline
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.clock, size: 16),
                          const Gap(5),
                          StreamBuilder(
                            stream: player.positionStream,
                            builder: (context, asyncSnapshot) {
                              final position =
                                  asyncSnapshot.data ?? Duration.zero;
                              return Text(formatDuration(position));
                            },
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: context.watch<ThemeCubit>().isDarkMood()
                              ? const Color(0xff022525)
                              : const Color(0xffDBEFEB),
                          border: Border.all(color: const Color(0xff5AE0AE)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          child: StreamBuilder(
                            stream: player.positionStream,
                            builder: (context, asyncSnapshot) {
                              final position =
                                  asyncSnapshot.data ?? Duration.zero;
                              return Text(
                                "${max(0, ((position.inSeconds / (currentSurahDuration?.inSeconds ?? 1)) * 100)).toStringAsFixed(2)}%",
                              );
                            },
                          ),
                        ),
                      ),
                      Text(
                        formatDuration(currentSurahDuration ?? Duration.zero),
                      ),
                    ],
                  ),
                  const Gap(10),

                  ///Linear progress indicator
                  StreamBuilder<Duration?>(
                    stream: player.durationStream,
                    builder: (context, snapshot) {
                      final duration = snapshot.data ?? Duration.zero;
                      return StreamBuilder<Duration>(
                        stream: player.positionStream,
                        builder: (context, asyncSnapshot) {
                          final position = asyncSnapshot.data ?? Duration.zero;
                          return ProgressBar(
                            progress: position,
                            total: duration,
                            progressBarColor: const Color(0xff007568),
                            baseBarColor: Colors.grey.shade400,
                            thumbColor: const Color(0xff007568),
                            thumbRadius: 6,
                            thumbGlowRadius: 2,
                            timeLabelTextStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            onSeek: (duration) {
                              player.seek(duration);
                            },
                          );
                        },
                      );
                    },
                  ),

                  const Gap(10),

                  ///Audio Operations
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        tooltip: "Previous Surah",
                        onPressed: () {
                          previousSurah();
                        },
                        icon: SvgPicture.asset(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                          "assets/svgs/previous-svgrepo-com.svg",
                        ),
                      ),
                      IconButton(
                        tooltip: "Back 15s",
                        onPressed: () {
                          player.seek(
                            player.position - const Duration(seconds: 15),
                          );
                        },
                        icon: SvgPicture.asset(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                          height: 16,
                          width: 16,
                          "assets/svgs/previous-svgrepo-com.svg",
                        ),
                      ),

                      ///Stop and play
                      IconButton(
                        onPressed: () async {
                          controlSurah();
                        },
                        icon: CircleAvatar(
                          backgroundColor: const Color(0xff00B590),
                          radius: 25,
                          child: StreamBuilder<PlayerState>(
                            stream: player.playerStateStream,
                            builder: (context, snapshot) {
                              final state = snapshot.data;
                              final playing = state?.playing ?? false;
                              final completed =
                                  state?.processingState ==
                                  ProcessingState.completed;
                              return state?.processingState ==
                                      ProcessingState.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      (playing && !completed)
                                          ? "assets/svgs/pause-svgrepo-com.svg"
                                          : "assets/svgs/play-svgrepo-com.svg",
                                      height: 24,
                                      width: 24,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),

                      //next
                      IconButton(
                        tooltip: "Forward 15s",
                        onPressed: () {
                          player.seek(
                            player.position + const Duration(seconds: 15),
                          );
                        },
                        icon: SvgPicture.asset(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                          height: 16,
                          width: 16,
                          "assets/svgs/skip-next-svgrepo-com.svg",
                        ),
                      ),
                      IconButton(
                        tooltip: "Next Surah",
                        onPressed: () {
                          nextSurah();
                        },
                        icon: SvgPicture.asset(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                          "assets/svgs/skip-next-svgrepo-com.svg",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Gap(20),
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: CustomContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${currentPlayingSurah!.totalAyah}",
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: const Color(0xff00B590)),
                          ),
                          const Spacer(),
                          Text(
                            "Ayahs",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: CustomContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formatDuration(
                              currentSurahDuration ?? const Duration(),
                            ),
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: const Color(0xff00B590)),
                          ),
                          const Spacer(),
                          Text(
                            "Duration",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: CustomContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentPlayingSurah!.revelationPlace,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: const Color(0xff00B590)),
                          ),
                          const Spacer(),
                          Text(
                            "Type",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildBlurredSheet({
  required List<dynamic> list,
  required Widget? child,
  required Color color,
}) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [SizedBox(height: 400, child: child)],
      ),
    ),
  );
}

String formatDuration(Duration d) {
  d = d.isNegative ? const Duration(seconds: 0) : d;
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(d.inHours);
  final minutes = twoDigits(d.inMinutes.remainder(60));
  final seconds = twoDigits(d.inSeconds.remainder(60));
  return "$hours:$minutes:$seconds";
}

String reciterMapper(String reciterInEng) {
  switch (reciterInEng) {
    case "Mishary Rashid Al Afasy":
      return "مشاري راشد العفاسي";
    case "Abu Bakr Al Shatri":
      return "أبو بكر الشاطري";
    case "Nasser Al Qatami":
      return "ناصر القطامي";
    case "Yasser Al Dosari":
      return "ياسر الدوسري";
    case "Hani Ar Rifai":
      return "هاني الرفاعي";
    default:
      return "سفيان";
  }
}
