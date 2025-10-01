import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
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
    return SingleChildScrollView(
      child: Column(
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
          const Gap(30),
          CustomContainer(
            isDarkMood: context.read<ThemeCubit>().isDarkMood(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor:
                                Colors.transparent, // مهم علشان نعمل البلور
                            isScrollControlled: true,
                            builder: (context) {
                              return _buildBlurredSheet();
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Al-Fatihah",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge,
                                ),
                                Text(
                                  "الفاتحة",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontFamily: "Amiri"),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                      ),
                      const Gap(50),
                      const Icon(Icons.favorite_rounded),
                      const Icon(Icons.more_vert),
                    ],
                  ),
                  const Gap(30),

                  ///mosque
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffDBEFEA),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text("🕌", style: TextStyle(fontSize: 24)),
                          const Gap(20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mishary Rashid Alafasy",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "مشاري راشد العفاسي",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontFamily: "Amiri"),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    const Gap(5),
                                    const Icon(Icons.keyboard_arrow_down),
                                  ],
                                ),
                                Text(
                                  "Kuwait • Melodic",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Gap(20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Ayah 1 of 7",
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(color: const Color(0xff007568)),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff007568),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1,
                                  ),
                                  child: Text(
                                    "14%",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          LinearProgressIndicator(
                            value: 0.14,
                            minHeight: 7,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff007568),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Text(
                                "0:00 / 5:00",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const Spacer(),
                              Text(
                                "Ayah Progress",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xff9EEAC7),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Ayah 1 of 7",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      const Gap(20),
                      Text(
                        "14% Complete",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      const Icon(Iconsax.clock, size: 12),
                      const Gap(5),
                      Text(
                        "0:12 / 35:00",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Gap(20),
                  LinearProgressIndicator(
                    value: 0.14,
                    color: const Color(0xff007568),
                    minHeight: 7,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Text(
                        "Current Ayah Progress",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Text("4%", style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  const Gap(10),
                  LinearProgressIndicator(
                    value: 0.04,
                    color: const Color(0xff0094E9),
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(12),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  const Gap(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          height: 25,
                          "assets/svgs/previous-svgrepo-com.svg",
                        ),
                        CircleAvatar(
                          backgroundColor: const Color(0xff00B590),
                          radius: 25,
                          child: SvgPicture.asset(
                            height: 20,
                            "assets/svgs/play-svgrepo-com.svg",
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          height: 20,
                          "assets/svgs/stop-svgrepo-com.svg",
                        ),
                        SvgPicture.asset(
                          height: 20,
                          "assets/svgs/skip-next-svgrepo-com.svg",
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //repeat
                      SvgPicture.asset(
                        "assets/svgs/repeat-svgrepo-com.svg",
                        height: 20,
                      ),
                      //shuffle
                      SvgPicture.asset(
                        "assets/svgs/shuffle-svgrepo-com.svg",
                        height: 20,
                      ),
                      //volume
                      SvgPicture.asset(
                        "assets/svgs/sound-volume-2-svgrepo-com.svg",
                        height: 20,
                      ),
                      //download
                      SvgPicture.asset(
                        "assets/svgs/download-svgrepo-com.svg",
                        height: 20,
                      ),
                      //share
                      SvgPicture.asset(
                        "assets/svgs/share-svgrepo-com.svg",
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Gap(100),
        ],
      ),
    );
  }
}

Widget _buildBlurredSheet() {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.wb_sunny_outlined, color: Colors.orange),
              title: Text("Al-Fatiha"),
              subtitle: Text("الفاتحة"),
              onTap: () {}, // هنا تعمل اللي عايزه لما يختار السورة
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.green),
              title: Text("Al-Baqarah"),
              subtitle: Text("البقرة"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.group, color: Colors.purple),
              title: Text("Aal-E-Imran"),
              subtitle: Text("آل عمران"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.group, color: Colors.purple),
              title: Text("Aal-E-Imran"),
              subtitle: Text("آل عمران"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.group, color: Colors.purple),
              title: Text("Aal-E-Imran"),
              subtitle: Text("آل عمران"),
              onTap: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
