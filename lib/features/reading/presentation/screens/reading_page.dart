import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/widgets/shimmers/shimmer_container.dart';
import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
import 'package:furqan/features/reading/presentation/screens/choosing_mode_page.dart';
import 'package:furqan/features/reading/presentation/screens/listening_to_surah.dart';
import 'package:furqan/features/reading/presentation/screens/reading_surah.dart';
import 'package:furqan/core/widgets/shimmers/reading_surah_shimmer.dart';
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
          switch (state) {
            case ReadingInitial() || SurahsLoading() || ChoosingSurah():

              ///Abl ma y5tar
              return _beforeChoosingSurah(context);

            ///E5tar ElMood(Read,Listen)
            case ChoosingMode(:var surahNo, :var surahName):
              return ChoosingModePage(surahNo: surahNo, surahName: surahName);

            ///Surah Reading Shimmer(loading)
            case SurahLoadingInReadingMode():
              return const Center(child: ReadingSurahShimmer());

            ///Surah fe Mood el reading(loaded)
            case SurahLoadedInReadingMode(:var surah):
              return ReadingSurah(surah: surah);

            ///Error in reading surah
            case ErrorSurahInReadingMode(:var message):
              return Text(message);

            ///Surah Loading in listening mode
            case SurahLoadingInListeningMode():
              return const Center(child: ListeningToSurahShimmer());

            ///Surah Loaded in listening mode
            case SurahLoadedInListeningMode(:var surah):
              return ListeningToSurah(surah: surah);

            ///Error in listening surah
            case ErrorSurahInListeningMode(:var message):
              return Text(message);

            default:
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
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(width: width * 0.7, height: 40),
                const Gap(8),
                ShimmerContainer(width: width * 0.5, height: 20),
              ],
            ),
            const Gap(16),
            ShimmerContainer(
              width: width,
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShimmerContainer(width: width * 0.25, height: 60),
                ShimmerContainer(width: width * 0.25, height: 60),
                ShimmerContainer(width: width * 0.25, height: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildChoosingSurahDialog(BuildContext context) {
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
          color: Theme.of(context).cardColor.withOpacity(0.5),
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
                  child: const Icon(Icons.close, size: 16),
                ),
              ],
            ),
            Text(
              "Select a Surah",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(5),
            Text(
              "Choose a Surah to begin your reading session",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Gap(20),

            ///Choosing Surah Cubit
            BlocBuilder<ReadingCubit, ReadingState>(
              builder: (context, state) {
                if (state is SurahsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ChoosingSurah) {
                  return Expanded(
                    child: _buildSurahListFromChoosing(state.surahs),
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
}

Widget _buildSurahListFromChoosing(List<SurahBaseEntity> surahs) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: surahs.length,
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () {
          context.read<ReadingCubit>().toggleToChoosingMode(
            index + 1,
            surahs[index].surahName,
          );
          Navigator.of(context).pop();
        },
        child: SurahListTile(
          surahNumber: index + 1,
          surah: SurahBaseEntity(
            surahName: surahs[index].surahName,
            surahNameArabic: surahs[index].surahNameArabic,
            totalAyah: surahs[index].totalAyah,
            surahNameArabicLong: surahs[index].surahNameArabicLong,
            surahNameTranslation: surahs[index].surahNameTranslation,
            revelationPlace: surahs[index].revelationPlace,
          ),
        ),
      ),
    ),
  );
}

Widget _buildAboveChooseSurah(BuildContext context) {
  return Column(
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
    ],
  );
}

Widget _buildChooseSurahButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.read<ReadingCubit>().getSurahs();
      showDialog(
        context: context,
        builder: (context) {
          return _buildChoosingSurahDialog(context);
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
  );
}

Widget _beforeChoosingSurah(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ///Above ChooseSurah
      _buildAboveChooseSurah(context),
      const Gap(10),
      _buildChooseSurahButton(context),
    ],
  );
}
