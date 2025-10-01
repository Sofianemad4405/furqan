import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ListeningToSurah extends StatefulWidget {
  const ListeningToSurah({super.key, required this.surah});

  final SurahEntity surah;

  @override
  State<ListeningToSurah> createState() => _ListeningToSurahState();
}

class _ListeningToSurahState extends State<ListeningToSurah> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Listening Mode",
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(color: const Color(0xff00947B)),
        ),
        const Gap(5),
        Text(
          "Immerse yourself in Quranic recitation Melodic",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        // CustomContainer(
        //   isDarkMood: context.read<ThemeCubit>().isDarkMood(),
        //   child: child,
        // ),
      ],
    );
  }
}
