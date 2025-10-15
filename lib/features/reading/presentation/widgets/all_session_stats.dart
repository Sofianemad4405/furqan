import 'package:flutter/material.dart';
import 'package:furqan/features/reading/presentation/widgets/session_stats.dart';
import 'package:furqan/features/stats/data/utils/helpers.dart';
import 'package:gap/gap.dart';

class AllSessionStats extends StatefulWidget {
  const AllSessionStats({
    super.key,
    required this.seconds,
    required this.ayahsRead,
  });
  final int seconds;
  final int ayahsRead;

  @override
  State<AllSessionStats> createState() => _AllSessionStatsState();
}

class _AllSessionStatsState extends State<AllSessionStats> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SessionStats(
              icon: const Icon(Icons.alarm, color: Color(0xff598BF3), size: 15),
              title: 'Reading\nTime',
              iconColor: const Color(0xff598BF3),
              topColumn: Text(
                formatTime(widget.seconds),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: SessionStats(
              icon: const Icon(
                Icons.menu_book_sharp,
                color: Color(0xff27A57A),
                size: 20,
              ),
              title: 'Ayahs\nRead',
              iconColor: const Color(0xff27A57A),
              topColumn: Text(
                widget.ayahsRead.toString(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: SessionStats(
              icon: Center(
                child: Text("✨", style: Theme.of(context).textTheme.bodyMedium),
              ),
              title: 'Hasanat',
              iconColor: const Color(0xffDDB557),
              topColumn: Text(
                "${widget.ayahsRead * 10}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
