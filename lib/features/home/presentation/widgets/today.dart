import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/utils/constants.dart';

class Today extends StatelessWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: QuranAppTheme.gray400, width: 0.6),
      ),
      child: weekDays(context),
    );
  }
}

Widget weekDays(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days
          .map(
            (day) => Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: isToday(day) ? QuranAppTheme.green : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  day,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isToday(day)
                        ? QuranAppTheme.gray100
                        : QuranAppTheme.gray400,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}

bool isToday(String day) {
  // DateTime.now().weekday returns 1 for Monday and 7 for Sunday.
  // The `days` list is 0-indexed and starts with Sunday.
  // We use the modulo operator to map Sunday (7) to index 0.
  return day == days[DateTime.now().weekday % 7];
}
