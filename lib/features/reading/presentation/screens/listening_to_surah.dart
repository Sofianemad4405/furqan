import 'dart:developer';
import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/core/entities/surah_entity.dart';
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

  List<String> allSurahsAudios = [];

  ///All reciters
  List<String> reciters = [];

  int reciterId = 1;
  @override
  void initState() {
    super.initState();
    _loadRecitersAndSurahs();
    getCurrentSurahDuration(widget.surah.surahNo);
    controlSurah();
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        nextSurah();
      }
    });
  }

  Future<void> _loadRecitersAndSurahs() async {
    currentPlayingSurah = widget.surah;
    reciters = await context.read<ReadingCubit>().getAvailableReciters();
    surahs = await context.read<ReadingCubit>().getAllSurahs();
    currentReciter = reciters[0];
    reciterId = reciters.indexOf(currentReciter);
    log(reciters.toString());
    log(surahs.toString());
    log(currentSurahDuration.toString());
  }

  Future<void> setCurrentReciter(String reciter) async {
    currentReciter = reciter;
    setState(() {});
  }

  Future<void> setCurrentSurah(SurahEntity surah) async {
    currentPlayingSurah = surah;
    setState(() {});
  }

  Future<void> controlSurah() async {
    if (player.playing) {
      await player.pause();
    } else {
      if (player.audioSource == null || hasChangedReciter) {
        await player.setUrl(
          currentPlayingSurah?.surahAudio[(reciterId + 1).toString()]!.url ??
              "",
        );
      }
      await player.play(); // هيكمل من مكانه لو متوقف
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

  // Future<void> setPlaylist() async {
  //   allSurahsAudios = List<String>.filled(surahs.length, "");
  //   for (int i = 0; i < surahs.length; i++) {
  //     allSurahsAudios[i] = await context
  //         .read<ReadingCubit>()
  //         .getSurah(i + 1)
  //         .then((value) => value.surahAudio[(reciterId + 1).toString()]!.url);
  //   }
  //   final playlist = ConcatenatingAudioSource(
  //     children: allSurahsAudios
  //         .map((url) => AudioSource.uri(Uri.parse(url)))
  //         .toList(),
  //   );
  //   player.setAudioSource(playlist);
  //   await player.setShuffleModeEnabled(true);
  // }

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
            ).textTheme.headlineLarge?.copyWith(color: const Color(0xff00947B)),
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
                      Text(
                        surahIcons[(currentPlayingSurah?.surahNo ?? 1) - 1],
                        style: const TextStyle(fontSize: 24),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) {
                              return _buildBlurredSheet(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inverseSurface,
                                list: surahs,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: surahs.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
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
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      title: Text(surahs[index].surahName),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            "${surahs[index].totalAyah} Ayahs  •  ",
                                          ),
                                          Text(surahs[index].revelationPlace),
                                        ],
                                      ),
                                      trailing: Text(
                                        surahs[index].surahNameArabic,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontFamily: "Amiri"),
                                      ),
                                    );
                                  },
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
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  currentPlayingSurah!.surahNameArabicLong,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontFamily: "Amiri"),
                                ),
                              ],
                            ),
                            const Gap(10),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                      const Gap(50),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
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
                          return _buildBlurredSheet(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            list: reciters,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: reciters.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    setCurrentReciter(reciters[index]);
                                    log(reciterId.toString());
                                    log(index.toString());
                                    log(hasChangedReciter.toString());
                                    bool isDifferent = reciterId != index;
                                    reciterId = index;
                                    hasChangedReciter = isDifferent;
                                    getCurrentSurahDuration(
                                      currentPlayingSurah!.surahNo,
                                    );
                                    player.stop();
                                    Navigator.pop(context);
                                  },
                                  leading: Text(
                                    recitersIcons[index],
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  title: Text(reciters[index]),
                                  trailing: Text(
                                    reciters[index],
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontFamily: "Amiri"),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffDBEFEA),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              recitersIcons[reciterId],
                              style: const TextStyle(fontSize: 24),
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
                                      const Icon(Icons.keyboard_arrow_down),
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
                                "${((position.inSeconds / (currentSurahDuration?.inSeconds ?? 1)) * 100).toStringAsFixed(2)}%",
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
                            timeLabelTextStyle: const TextStyle(
                              color: Colors.white,
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
                          height: 16,
                          width: 16,
                          "assets/svgs/previous-svgrepo-com.svg",
                        ),
                      ),
                      //Stop and play
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
                                ?.copyWith(color: const Color(0xff007568)),
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
                            formatDuration(currentSurahDuration!),
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: const Color(0xff007568)),
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
                                ?.copyWith(color: const Color(0xff007568)),
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

Widget _buildBlurredSheet({
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
      return "";
  }
}
