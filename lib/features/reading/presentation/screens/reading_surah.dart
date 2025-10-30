import 'dart:async';
import 'dart:developer' as logger;
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/entities/audio_entity.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/cubit/user_progress_cubit.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:furqan/features/reading/presentation/widgets/all_session_stats.dart';
import 'package:furqan/features/reading/presentation/widgets/verse_card.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
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
  int surahsRead = 0;
  UserProgressCubit userProgressCubit = sl<UserProgressCubit>();

  List<AudioEntity> verseAudios = [];
  late Timer _timer;
  int _seconds = 0;

  late ConfettiController _confettiController;

  @override
  void initState() {
    getVersesAudios();
    _handleTimer();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    super.initState();
  }

  Future<void> _handleTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        _seconds++;
      });
      if (_seconds % 60 == 0) {
        final minutes = _seconds ~/ 60;

        await userProgressCubit.updateUserData({
          'minutes_of_reading_quraan': minutes,
        });

        logger.log("✅ Updated minutes in Supabase: $minutes");
      }
    });
  }

  // void addAyahToLikes(
  //   int surahNo,
  //   int ayahNumber,
  //   UserProgress? currentProgress,
  // ) {
  //   logger.log("toggling");
  //   final current = currentProgress;
  //   final surahNoStr = surahNo.toString();

  //   final mergedMap = <String, List<dynamic>>{};
  //   current?.likedAyahs.forEach((key, value) {
  //     mergedMap[key] = List<dynamic>.from(value);
  //   });

  //   mergedMap.putIfAbsent(surahNoStr, () => []);

  //   final isLiked = mergedMap[surahNoStr]!.contains(ayahNumber);
  //   logger.log("isLiked: $isLiked, surahNo: $surahNoStr");

  //   if (isLiked) {
  //     setState(() {
  //       mergedMap[surahNoStr]!.remove(ayahNumber);
  //     });
  //   } else {
  //     setState(() {
  //       mergedMap[surahNoStr]!.add(ayahNumber);
  //     });
  //   }

  //   logger.log(mergedMap.toString());

  //   userProgressCubit.updateUserData({'liked_ayahs': mergedMap});
  // }

  int verseHassanat(String verse) {
    return verse.length * 10;
  }

  Future<void> getVersesAudios() async {
    final audios = await context.read<ReadingCubit>().getVerseAudios(
      widget.surah.surahNo,
      ayahNumber,
    );
    verseAudios = audios;
  }

  void _onSurahCompleted() {
    setState(() {
      _confettiController.play();
    });
    //update user data
    context.read<UserProgressCubit>().updateUserData({
      'surahs_completed': surahsRead + 1,
    });
  }

  void _previousAyahHandler() {
    if (ayahNumber > 1) {
      setState(() {
        ayahNumber--;
      });
    } else if (ayahNumber == 1) {
      context.read<ReadingCubit>().toggleToSurahSelectionMode();
    }
  }

  void _nextAyahHandler(
    int userAyahsRead,
    UserProgress? currentProgress,
    ReadingCubit readingCubit,
  ) async {
    setState(() {
      if (ayahNumber < widget.surah.totalAyah) {
        ayahNumber++;
        ayahsRead++;
      }
    });
    userAyahsRead++;
    userProgressCubit.updateUserData({"ayahs_read": userAyahsRead});
    if (ayahNumber == widget.surah.totalAyah) {
      _onSurahCompleted();
      if (mounted) {
        readingCubit.getSurahWithAudioAndTranslation(widget.surah.surahNo + 1);
      }
      if (!currentProgress!.surahsReadIds.contains(widget.surah.surahNo)) {
        final surahsReadIds = currentProgress.surahsReadIds;
        int surahsRead = currentProgress.surahsRead;
        surahsReadIds.add(widget.surah.surahNo);
        surahsRead++;
        userProgressCubit.updateUserData({
          'surahs_read': surahsRead,
          'surahs_read_ids': surahsReadIds,
        });
      }
      if (widget.surah.surahNo == 114) {
        readingCubit.getSurahWithAudioAndTranslation(1);
      }
    }
    if (currentProgress != null) {
      final currentHasanat = currentProgress.totalHassanat;
      final newHasanat =
          currentHasanat +
          verseHassanat(widget.surah.arabic1?[ayahNumber - 1] ?? "");
      userProgressCubit.updateUserData({'total_hassanat': newHasanat});
    }
    verseAudios = await readingCubit.getVerseAudios(
      widget.surah.surahNo,
      ayahNumber,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    player.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readingCubit = context.read<ReadingCubit>();

    final currentProgress = (userProgressCubit.state is UserProgressLoaded)
        ? (userProgressCubit.state as UserProgressLoaded).userProgress
        : null;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const Gap(10),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                titleSpacing: 0,
                title: Row(
                  children: [
                    IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        context
                            .read<ReadingCubit>()
                            .toggleToSurahSelectionMode();
                      },
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reading Mode",
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(color: const Color(0xff00B590)),
                        ),
                        Text(
                          "Read the complete Surah",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Gap(20),

              ///El headar bta3 elPage
              AllSessionStats(seconds: _seconds, ayahsRead: ayahsRead),
              const Gap(30),

              ///ELcard ely feh elAyah
              BlocBuilder<UserProgressCubit, UserProgresState>(
                builder: (context, state) {
                  bool isLiked = false;
                  if (state is UserProgressLoaded) {
                    final likes = state.userProgress.likedAyahs;
                    final surahKey = widget.surah.surahNo.toString();
                    isLiked = likes[surahKey]?.contains(ayahNumber) ?? false;
                  }
                  return VerseCard(
                    openSheet: () {},
                    surah: widget.surah,
                    ayahNumber: ayahNumber,
                    player: player,
                    verseAudios: verseAudios,
                    isLiked: isLiked,
                    toggleAyahToLikes: () {
                      logger.log("toggling like for $ayahNumber");
                      context.read<UserProgressCubit>().toggleAyahLike(
                        widget.surah.surahNo,
                        ayahNumber,
                      );
                    },
                  );
                },
              ),
              const Gap(20),

              ///Previous w Next Ayah
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///Previous Ayah
                  _buildNextOrPrevious(
                    context: context,
                    onTap: _previousAyahHandler,
                    isPrevious: true,
                  ),
                  Text("$ayahNumber of ${widget.surah.totalAyah}"),

                  ///Next Ayah
                  _buildNextOrPrevious(
                    context: context,
                    onTap: () => _nextAyahHandler(
                      ayahsRead,
                      currentProgress,
                      readingCubit,
                    ),
                    isPrevious: false,
                  ),
                ],
              ),
              const Gap(20),

              ///Celebration When achieving target
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                blastDirection: -pi / 2,
                emissionFrequency: .2,
                numberOfParticles: 25,
                gravity: 0.2,
                colors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                  Colors.purple,
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

Widget _buildNextOrPrevious({
  required BuildContext context,
  required GestureTapCallback? onTap,
  required bool isPrevious,
}) {
  return GestureDetector(
    // onTap: () {
    //   if (ayahNumber > 1) {
    //     setState(() {
    //       ayahNumber--;
    //     });
    //   } else if (ayahNumber == 1) {
    //     context.read<ReadingCubit>().toggleToSurahSelectionMode();
    //   }
    // },
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: !isPrevious
            ? Colors.green
            : Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(
              isPrevious ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              size: 12,
              color: isPrevious
                  ? Theme.of(context).colorScheme.onSurface
                  : Colors.white,
            ),
            const Gap(10),
            Text(
              isPrevious ? "Previous" : "Next",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isPrevious
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
