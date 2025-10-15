import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/entities/dhikr_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';

class ZikrContainer extends StatefulWidget {
  const ZikrContainer({
    super.key,
    required this.title,
    required this.dhikrEntity,
  });
  final String title;
  final DhikrEntity dhikrEntity;

  @override
  State<ZikrContainer> createState() => _ZikrContainerState();
}

class _ZikrContainerState extends State<ZikrContainer> {
  @override
  Widget build(BuildContext context) {
    ///دي الكارد اللي بيتعرض فيها الذكر
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: widget.title == "أذكار الصباح"
                          ? QuranAppTheme.morningAzkar
                          : widget.title == "أذكار المساء"
                          ? QuranAppTheme.nightAzkar
                          : widget.title == "أذكار بعد الصلاة"
                          ? QuranAppTheme.afterPrayerAzkar
                          : QuranAppTheme.theRest,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${widget.dhikrEntity.repeat}x",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Text(
              widget.dhikrEntity.zekr,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: "Amiri",
                // wordSpacing: 2,
                height: 2,
              ),
              textDirection: TextDirection.rtl,
            ),
            const Gap(20),
            if (widget.dhikrEntity.bless.isNotEmpty)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.read<ThemeCubit>().isDarkMood()
                      ? const Color(0xFF103036)
                      : QuranAppTheme.emerald50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          widget.dhikrEntity.bless,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: !context.read<ThemeCubit>().isDarkMood()
                                    ? const Color(0xFF007552)
                                    : const Color(0xFF5AE0AE),
                                fontFamily: "IBM Plex Sans Arabic",
                              ),
                          maxLines: 4,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const Gap(10),
                      const Icon(Icons.lightbulb, color: Colors.yellow),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
