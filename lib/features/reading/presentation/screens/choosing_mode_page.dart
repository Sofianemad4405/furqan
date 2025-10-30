import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:gap/gap.dart';

class ChoosingModePage extends StatefulWidget {
  const ChoosingModePage({
    super.key,
    required this.surahNo,
    required this.surahName,
  });
  final int surahNo;
  final String surahName;

  @override
  State<ChoosingModePage> createState() => _ChoosingModePageState();
}

class _ChoosingModePageState extends State<ChoosingModePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("🎧", style: TextStyle(fontSize: 100)),
          const Gap(10),
          Text(
            "Choose Your Mode",
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const Gap(10),
          Text(
            "How would you like to experience Surah ${widget.surahName}?",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<ReadingCubit>().getSurahWithAudioAndTranslation(
                    widget.surahNo,
                  );
                },
                child: CustomContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: state == ThemeMode.dark
                                  ? QuranAppTheme.readingModeContainerLight
                                        .withValues(alpha: 0.2)
                                  : QuranAppTheme.readingModeContainerLight
                                        .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/svgs/bookopen-icon.svg",
                                colorFilter: ColorFilter.mode(
                                  state == ThemeMode.dark
                                      ? QuranAppTheme.readingModeContainerLight
                                      : QuranAppTheme.readingModeContainerLight,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reading Mode",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              "Read at your own pace with\ntranslations",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const Gap(20),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context
                      .read<ReadingCubit>()
                      .getSurahWithAudioAndTranslationInListeningMode(
                        widget.surahNo,
                      );
                },
                child: CustomContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: state == ThemeMode.dark
                                  ? QuranAppTheme.listeningModeContainerLight
                                        .withValues(alpha: 0.2)
                                  : QuranAppTheme.listeningModeContainerLight
                                        .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/svgs/volume2-icon.svg",
                                colorFilter: ColorFilter.mode(
                                  state == ThemeMode.dark
                                      ? QuranAppTheme
                                            .listeningModeContainerLight
                                      : QuranAppTheme
                                            .listeningModeContainerLight,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Listening Mode",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              "Listen to the complete Surah\nrecitation",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const Gap(20),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<ReadingCubit>().toggleToSurahSelectionMode();
                },
                child: CustomContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Text(
                      "Back to Surah Selection",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              );
            },
          ),
          const Gap(100),
        ],
      ),
    );
  }
}
