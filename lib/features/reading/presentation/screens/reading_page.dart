import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/widgets/shimmer_container.dart';
import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:furqan/features/reading/presentation/screens/choosing_mode_page.dart';
import 'package:furqan/features/reading/presentation/screens/listening_to_surah.dart';
import 'package:furqan/features/reading/presentation/screens/reading_surah.dart';
import 'package:furqan/features/reading/presentation/widgets/reading_surah_shimmer.dart';
import 'package:furqan/features/reading/presentation/widgets/surah_list_tile.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:gap/gap.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key, required this.userProgress});
  final UserProgress userProgress;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ReadingCubit, ReadingState>(
        builder: (context, state) {
          if (state is ReadingInitial ||
              state is SurahsLoading ||
              state is ChoosingSurah) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("📖", style: TextStyle(fontSize: 100)),
                const Gap(5),
                Text(
                  "Start Your Quran Reading Journey",
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                Text(
                  "Select a Surah and begin your spiritual journey. Each ayah you read brings you closer to Allah and earns you hasanat.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () {
                    context.read<ReadingCubit>().getSurahs();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Container(
                            height: 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).cardColor.withOpacity(0.5),
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
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
                                  Text(
                                    "Select a Surah",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  const Gap(5),
                                  Text(
                                    "Choose a Surah to begin your reading session",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  const Gap(20),
                                  BlocBuilder<ReadingCubit, ReadingState>(
                                    builder: (context, state) {
                                      if (state is SurahsLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (state is ChoosingSurah) {
                                        log("Choosing");
                                        return Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.surahs.length,
                                            itemBuilder: (context, index) => Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<ReadingCubit>()
                                                      .toggleToChoosingMode(
                                                        index + 1,
                                                        state
                                                            .surahs[index]
                                                            .surahName,
                                                      );
                                                  Navigator.of(context).pop();
                                                },
                                                child: SurahListTile(
                                                  surahNumber: index + 1,
                                                  surah: SurahBaseEntity(
                                                    surahName: state
                                                        .surahs[index]
                                                        .surahName,
                                                    surahNameArabic: state
                                                        .surahs[index]
                                                        .surahNameArabic,
                                                    totalAyah: state
                                                        .surahs[index]
                                                        .totalAyah,
                                                    surahNameArabicLong: state
                                                        .surahs[index]
                                                        .surahNameArabicLong,
                                                    surahNameTranslation: state
                                                        .surahs[index]
                                                        .surahNameTranslation,
                                                    revelationPlace: state
                                                        .surahs[index]
                                                        .revelationPlace,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (state is ErrorChoosingSurah) {
                                        return Text(state.message);
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      color: QuranAppTheme.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "Choose Surah",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ChoosingMode) {
            return ChoosingModePage(
              surahNo: state.surahNo,
              surahName: state.surahName,
            );
          } else if (state is SurahLoadingInReadingMode) {
            return const Center(child: ReadingSurahShimmer());
          } else if (state is SurahLoadedInReadingMode) {
            return ReadingSurah(surah: state.surah);
          } else if (state is ErrorSurahInReadingMode) {
            return Text(state.message);
          } else if (state is SurahLoadingInListeningMode) {
            return const Center(child: ListeningToSurahShimmer());
          } else if (state is SurahLoadedInListeningMode) {
            return ListeningToSurah(surah: state.surah);
          } else if (state is ErrorSurahInListeningMode) {
            return Text(state.message);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ListeningToSurahShimmer extends StatelessWidget {
  const ListeningToSurahShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerContainer(height: 40),
              ShimmerContainer(height: 20),
            ],
          ),
          Gap(10),
          ShimmerContainer(height: 500),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShimmerContainer(height: 100),
              Gap(10),
              ShimmerContainer(height: 100),
              Gap(10),
              ShimmerContainer(height: 100),
            ],
          ),
        ],
      ),
    );
  }
}
