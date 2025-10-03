import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/home/presentation/widgets/custom_zikr_category_container.dart';
import 'package:gap/gap.dart';

class DhikrListTile extends StatelessWidget {
  const DhikrListTile({
    super.key,
    required this.title,
    required this.englishTitle,
    required this.count,
    this.onTap,
  });
  final String title;
  final String englishTitle;
  final int count;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomContainer(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CustomZikrCategoryContainer(
                    gradient: title == "أذكار الصباح"
                        ? QuranAppTheme.morningAzkar
                        : title == "أذكار المساء"
                        ? QuranAppTheme.nightAzkar
                        : title == "أذكار بعد الصلاة"
                        ? QuranAppTheme.afterPrayerAzkar
                        : QuranAppTheme.theRest,
                    iconPath: "assets/svgs/bell-icon.svg",
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall?.copyWith(fontFamily: "Amiri"),
                    ),
                    const Gap(10),
                    Text(
                      englishTitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3FB48B).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "$count items",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: const Color(0xFF3FB48B)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
