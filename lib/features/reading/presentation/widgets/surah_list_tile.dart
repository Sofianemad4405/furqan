import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
import 'package:gap/gap.dart';

class SurahListTile extends StatelessWidget {
  const SurahListTile({super.key, required this.surah});
  final SurahBaseEntity surah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: QuranAppTheme.gray600, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: QuranAppTheme.gray600,
                            width: .5,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            surah.surahNumber.toString(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      const Gap(5),
                      Text(
                        surah.surahName,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "${surah.surahNameTranslation} . ${surah.totalAyah} Ayahs",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                surah.surahNameArabic,
                style: const TextStyle(
                  fontFamily: 'Amiri',
                  color: QuranAppTheme.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
