import 'package:flutter/material.dart';
import 'package:furqan/core/entities/azkar_section_entity.dart';
import 'package:furqan/core/entities/dhikr_entity.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/widgets/custom_zikr_category_container.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/widgets/zikr_container.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/widgets/zikr_counter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AzkarListView extends StatefulWidget {
  const AzkarListView({
    super.key,
    required this.titleTranslation,
    required this.azkarSectionEntity,
    required this.icon,
  });
  final AzkarSectionEntity? azkarSectionEntity;
  final String titleTranslation;
  final String icon;
  @override
  State<AzkarListView> createState() => _AzkarListViewState();
}

class _AzkarListViewState extends State<AzkarListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Gap(20),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back),
              ),
              const Gap(20),
              SizedBox(
                height: 55,
                width: 55,
                child: CustomZikrCategoryContainer(
                  gradient: widget.azkarSectionEntity?.title == "أذكار الصباح"
                      ? QuranAppTheme.morningAzkar
                      : widget.azkarSectionEntity?.title == "أذكار المساء"
                      ? QuranAppTheme.nightAzkar
                      : widget.azkarSectionEntity?.title == "أذكار بعد الصلاة"
                      ? QuranAppTheme.afterPrayerAzkar
                      : QuranAppTheme.theRest,
                  iconPath: widget.icon,
                ),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.azkarSectionEntity?.title ?? "",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontFamily: "IBM Plex Sans Arabic",
                    ),
                  ),
                  const Gap(10),
                  Text(
                    widget.titleTranslation,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          const Gap(10),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.azkarSectionEntity?.content.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      GetPageRoute(
                        page: () => ZikrCounter(
                          dhikr: widget.azkarSectionEntity?.content[index],
                          title: widget.azkarSectionEntity?.title ?? "",
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ZikrContainer(
                      title: widget.azkarSectionEntity?.title ?? "",
                      dhikrEntity:
                          widget.azkarSectionEntity?.content[index] ??
                          DhikrEntity(zekr: "zekr", repeat: 0, bless: "bless"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
