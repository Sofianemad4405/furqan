import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
import 'package:gap/gap.dart';

class SurahListTile extends StatelessWidget {
  const SurahListTile({
    super.key,
    required this.surah,
    required this.surahNumber,
  });
  final SurahBaseEntity surah;
  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: QuranAppTheme.gray600, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    // width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: QuranAppTheme.gray600,
                        width: .5,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                        child: Text(
                          surahNumber.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  const Gap(5),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          surah.surahName,
                          style: Theme.of(context).textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          surah.surahNameArabic,
                          style: const TextStyle(
                            fontFamily: 'Amiri',
                            color: QuranAppTheme.green,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "${surah.surahNameTranslation} . ${surah.totalAyah} Ayahs",
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
