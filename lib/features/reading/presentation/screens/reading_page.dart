import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/reading/presentation/widgets/surah_list_tile.dart';
import 'package:gap/gap.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Icon(Icons.close, size: 16)],
                            ),
                            Text(
                              "Select a Surah",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const Gap(5),
                            Text(
                              "Choose a Surah to begin your reading session",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const Gap(10),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 30,
                                itemBuilder: (context, index) =>
                                    const SurahListTile(),
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
      ),
    );
  }
}
