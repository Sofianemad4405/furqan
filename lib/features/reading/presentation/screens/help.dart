// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:furqan/core/entities/audio_entity.dart';
// import 'package:furqan/core/entities/surah_entity.dart';
// import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
// import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
// import 'package:furqan/features/reading/presentation/cubit/reading_cubit.dart';
// import 'package:gap/gap.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:provider/provider.dart';

// class ListeningToSurah extends StatefulWidget {
//   const ListeningToSurah({super.key, required this.surah});

//   final SurahEntity surah;

//   @override
//   State<ListeningToSurah> createState() => _ListeningToSurahState();
// }

// class _ListeningToSurahState extends State<ListeningToSurah> {
//   List<SurahBaseEntity> surahs = [];
//   SurahEntity? currentPlayingSurah;
//   List<String> reciters = [];
//   String? currentReciter;
//   int reciterId = 1;
//   List<AudioEntity> audios = [];
//   int currentAyah = 1;
//   int ayahsRead = 1;
//   bool isPlaying = false;
//   final player = AudioPlayer();
//   Duration? surahDuration;
//   @override
//   void initState() {
//     super.initState();
//     currentPlayingSurah = widget.surah;
//     getCurrentPlayingSurahDetails(widget.surah.surahNo);
//     getSurahs();
//     getAvailableReciters();
//     _loadAyah(widget.surah.surahNo, 1);
//     getCurrentSurahDuration(currentPlayingSurah!.surahAudio["1"]!.url);
//   }

//   Future<void> getCurrentPlayingSurahDetails(int surahNum) async {
//     currentPlayingSurah = await context.read<ReadingCubit>().getSurah(surahNum);
//     setState(() {});
//   }

//   Future<void> setCurrentReciter(String reciter) async {
//     currentReciter = reciter;
//     setState(() {});
//   }

//   Future<void> getSurahs() async {
//     surahs = await context.read<ReadingCubit>().getAllSurahs();
//   }

//   Future<void> getAvailableReciters() async {
//     reciters = await context.read<ReadingCubit>().getAvailableReciters();
//   }

//   Future<void> _loadAyah(int surahNo, int ayahNo) async {
//     audios = await context.read<ReadingCubit>().getVerseAudios(surahNo, ayahNo);
//     log(audios[0].url.toString());
//   }

//   Future<void> getCurrentSurahDuration(String url) async {
//     final player = AudioPlayer();
//     await player.setUrl(url);
//     surahDuration = await player.durationStream.firstWhere((d) => d != null);
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ///Header
//           Text(
//             "Listening Mode",
//             style: Theme.of(
//               context,
//             ).textTheme.headlineLarge?.copyWith(color: const Color(0xff00947B)),
//           ),
//           const Gap(5),
//           Text(
//             "Immerse yourself in Quranic recitation Melodic",
//             style: Theme.of(context).textTheme.bodySmall,
//           ),
//           const Gap(30),

//           CustomContainer(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 children: [
//                   ////Current Surah Choosing
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Icon(Icons.star, color: Colors.yellow),
//                       GestureDetector(
//                         onTap: () {
//                           // showModalBottomSheet(
//                           //   context: context,
//                           //   backgroundColor: Colors.transparent,
//                           //   isScrollControlled: true,
//                           //   builder: (context) {
//                           //     // return _buildBlurredSheet(
//                           //     //   color: Theme.of(
//                           //     //     context,
//                           //     //   ).colorScheme.inverseSurface,
//                           //     //   list: surahs,
//                           //     //   child: ListView.builder(
//                           //     //     shrinkWrap: true,
//                           //     //     itemCount: surahs.length,
//                           //     //     itemBuilder: (context, index) {
//                           //     //       return ListTile(
//                           //     //         onTap: () {
//                           //     //           getCurrentPlayingSurahDetails(
//                           //     //             index + 1,
//                           //     //           );
//                           //     //           currentAyah = 1;
//                           //     //           Navigator.pop(context);
//                           //     //         },
//                           //     //         leading: const Icon(
//                           //     //           Icons.wb_sunny_outlined,
//                           //     //           color: Colors.orange,
//                           //     //         ),
//                           //     //         title: Text(surahs[index].surahName),
//                           //     //         subtitle: Row(
//                           //     //           children: [
//                           //     //             Text(
//                           //     //               "${surahs[index].totalAyah} Ayahs  •  ",
//                           //     //             ),
//                           //     //             Text(surahs[index].revelationPlace),
//                           //     //           ],
//                           //     //         ),
//                           //     //         trailing: Text(
//                           //     //           surahs[index].surahNameArabic,
//                           //     //           style: Theme.of(context)
//                           //     //               .textTheme
//                           //     //               .bodyLarge
//                           //     //               ?.copyWith(fontFamily: "Amiri"),
//                           //     //         ),
//                           //     //       );
//                           //     //     },
//                           //     //   ),
//                           //     // );

//                           //   },
//                           // );
//                         },
//                         child: Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   currentPlayingSurah!.surahName,
//                                   style: Theme.of(
//                                     context,
//                                   ).textTheme.headlineLarge,
//                                 ),
//                                 Text(
//                                   currentPlayingSurah!.surahNameArabicLong,
//                                   style: Theme.of(context).textTheme.bodyLarge
//                                       ?.copyWith(fontFamily: "Amiri"),
//                                 ),
//                               ],
//                             ),
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.keyboard_arrow_down),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Gap(50),
//                       const Icon(Icons.favorite_rounded),
//                       const Icon(Icons.more_vert),
//                     ],
//                   ),

//                   const Gap(30),

//                   ///mosque
//                   GestureDetector(
//                     onTap: () {
//                       // showModalBottomSheet(
//                       //   context: context,
//                       //   backgroundColor:
//                       //       Colors.transparent, // مهم علشان نعمل البلور
//                       //   isScrollControlled: true,
//                       // //   builder: (context) {
//                       // //     // return _buildBlurredSheet(
//                       // //     //   color: Theme.of(context).colorScheme.inverseSurface,
//                       // //     //   list: reciters,
//                       // //     //   child: ListView.builder(
//                       // //     //     shrinkWrap: true,
//                       // //     //     itemCount: reciters.length,
//                       // //     //     itemBuilder: (context, index) {
//                       // //     //       return ListTile(
//                       // //     //         onTap: () {
//                       // //     //           setCurrentReciter(reciters[index]);
//                       // //     //           Navigator.pop(context);
//                       // //     //         },
//                       // //     //         leading: const Icon(
//                       // //     //           Icons.wb_sunny_outlined,
//                       // //     //           color: Colors.orange,
//                       // //     //         ),
//                       // //     //         title: Text(reciters[index]),
//                       // //     //         // subtitle: Row(
//                       // //     //         //   children: [
//                       // //     //         //     Text(
//                       // //     //         //       "${reciters[index].totalAyah} Ayahs  •  ",
//                       // //     //         //     ),
//                       // //     //         //     Text(reciters[index].revelationPlace),
//                       // //     //         //   ],
//                       // //     //         // ),
//                       // //     //         trailing: Text(
//                       // //     //           reciters[index],
//                       // //     //           style: Theme.of(context).textTheme.bodyLarge
//                       // //     //               ?.copyWith(fontFamily: "Amiri"),
//                       // //     //         ),
//                       // //     //       );
//                       // //     //     },
//                       // //     //   ),
//                       // //     // );

//                       // //  },
//                       // );
//                     },
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         color: Color(0xffDBEFEA),
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             const Text("🕌", style: TextStyle(fontSize: 24)),
//                             const Gap(20),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     currentReciter ?? "",
//                                     style: Theme.of(
//                                       context,
//                                     ).textTheme.labelLarge,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         "مشاري راشد العفاسي",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyMedium
//                                             ?.copyWith(fontFamily: "Amiri"),
//                                         textDirection: TextDirection.rtl,
//                                       ),
//                                       const Gap(5),
//                                       const Icon(Icons.keyboard_arrow_down),
//                                     ],
//                                   ),
//                                   Text(
//                                     "Kuwait • Melodic",
//                                     style: Theme.of(
//                                       context,
//                                     ).textTheme.bodySmall,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                   const Gap(20),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Theme.of(context).colorScheme.surface,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 "Ayah $currentAyah of ${currentPlayingSurah!.totalAyah}",
//                                 style: Theme.of(context).textTheme.labelMedium
//                                     ?.copyWith(color: const Color(0xff007568)),
//                               ),
//                               const Spacer(),
//                               StreamBuilder(
//                                 stream: player.positionStream,
//                                 builder: (context, asyncSnapshot) {
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: const Color(0xff007568),
//                                       ),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 6,
//                                         vertical: 1,
//                                       ),
//                                       child: Text(
//                                         "${player.position.inSeconds / (player.duration?.inSeconds ?? 10) * 100}%",
//                                         style: Theme.of(
//                                           context,
//                                         ).textTheme.labelMedium,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                           const Gap(20),
//                           StreamBuilder<Duration?>(
//                             stream: player.durationStream,
//                             builder: (context, snapshot) {
//                               final duration = snapshot.data ?? Duration.zero;
//                               return StreamBuilder<Duration>(
//                                 stream: player.positionStream,
//                                 builder: (context, asyncSnapshot) {
//                                   final position =
//                                       asyncSnapshot.data ?? Duration.zero;
//                                   return LinearProgressIndicator(
//                                     value: duration.inMilliseconds > 0
//                                         ? position.inMilliseconds /
//                                               duration.inMilliseconds
//                                         : 0,
//                                     minHeight: 7,
//                                     borderRadius: BorderRadius.circular(12),
//                                     color: const Color(0xff007568),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                           const Gap(10),
//                           Row(
//                             children: [
//                               // Text(
//                               //   "${player.position.inSeconds} / ${player.duration!.inSeconds}",
//                               //   style: Theme.of(context).textTheme.bodySmall,
//                               // ),
//                               const Spacer(),
//                               Text(
//                                 "Ayah Progress",
//                                 style: Theme.of(context).textTheme.bodySmall,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const Gap(20),
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).colorScheme.surface,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                             color: const Color(0xff9EEAC7),
//                             width: 1,
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           child: Text(
//                             "Ayah $ayahsRead of ${currentPlayingSurah!.totalAyah}",
//                             style: Theme.of(context).textTheme.titleSmall,
//                           ),
//                         ),
//                       ),
//                       const Gap(20),
//                       Text(
//                         "14% Complete",
//                         style: Theme.of(context).textTheme.bodySmall,
//                       ),
//                       const Spacer(),
//                       const Icon(Iconsax.clock, size: 12),
//                       const Gap(5),
//                       Text(
//                         "0:12 / 35:00",
//                         style: Theme.of(context).textTheme.bodySmall,
//                       ),
//                     ],
//                   ),
//                   const Gap(20),
//                   LinearProgressIndicator(
//                     value: 0.14,
//                     color: const Color(0xff007568),
//                     minHeight: 7,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   const Gap(10),
//                   Row(
//                     children: [
//                       Text(
//                         "Current Ayah Progress",
//                         style: Theme.of(context).textTheme.bodySmall,
//                       ),
//                       const Spacer(),
//                       Text("4%", style: Theme.of(context).textTheme.bodySmall),
//                     ],
//                   ),
//                   const Gap(10),
//                   StreamBuilder<Duration?>(
//                     stream: player.durationStream,
//                     builder: (context, snapshot) {
//                       final duration = snapshot.data ?? Duration.zero;
//                       return StreamBuilder<Duration>(
//                         stream: player.positionStream,
//                         builder: (context, asyncSnapshot) {
//                           final position = asyncSnapshot.data ?? Duration.zero;
//                           return LinearProgressIndicator(
//                             backgroundColor: Theme.of(
//                               context,
//                             ).colorScheme.surface,
//                             value: duration.inMilliseconds > 0
//                                 ? position.inMilliseconds /
//                                       duration.inMilliseconds
//                                 : 0,
//                             minHeight: 4,
//                             borderRadius: BorderRadius.circular(12),
//                             color: const Color(0xff0094E9),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   const Gap(30),
//                   ////pause & next & play & previous
//                   StreamBuilder<PlayerState>(
//                     stream: player.playerStateStream,
//                     builder: (context, asyncSnapshot) {
//                       final state = asyncSnapshot.data;
//                       // final playing = state?.playing ?? false;
//                       // final completed =
//                       //     state?.processingState == ProcessingState.completed;
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             ///Previous
//                             GestureDetector(
//                               onTap: () async {
//                                 currentAyah--;
//                                 if (currentAyah > 1) {
//                                   setState(() {
//                                     currentAyah--;
//                                   });
//                                   _loadAyah(
//                                     currentPlayingSurah?.surahNo ?? 1,
//                                     currentAyah,
//                                   );
//                                   await player.setUrl(audios[0].url);
//                                   await player.play();
//                                   setState(() {
//                                     isPlaying = true;
//                                   });
//                                 }
//                               },
//                               child: SvgPicture.asset(
//                                 height: 25,
//                                 "assets/svgs/previous-svgrepo-com.svg",
//                               ),
//                             ),

//                             ///Play and pause
//                             GestureDetector(
//                               onTap: () async {
//                                 if (player.playing) {
//                                   await player.pause();
//                                 } else {
//                                   if (currentAyah ==
//                                       currentPlayingSurah?.totalAyah) {
//                                     setState(() {
//                                       currentAyah += 1;
//                                     });
//                                   }
//                                   try {
//                                     _loadAyah(
//                                       currentPlayingSurah?.surahNo ?? 1,
//                                       currentAyah,
//                                     );
//                                     await player.setUrl(audios[0].url);
//                                     log("sheikhhh ${audios[0].url}");
//                                     await player.play();
//                                   } catch (e) {
//                                     log(
//                                       "${e.toString()} ${e.runtimeType} errorrrrr",
//                                     );
//                                   }
//                                 }
//                                 setState(() {
//                                   isPlaying = !isPlaying;
//                                 });
//                               },
//                               child: CircleAvatar(
//                                 backgroundColor: const Color(0xff00B590),
//                                 radius: 25,
//                                 child: StreamBuilder<PlayerState>(
//                                   stream: player.playerStateStream,
//                                   builder: (context, snapshot) {
//                                     final state = snapshot.data;
//                                     final playing = state?.playing ?? false;
//                                     final completed =
//                                         state?.processingState ==
//                                         ProcessingState.completed;
//                                     return state?.processingState ==
//                                             ProcessingState.loading
//                                         ? const Center(
//                                             child: CircularProgressIndicator(
//                                               color: Colors.white,
//                                             ),
//                                           )
//                                         : SvgPicture.asset(
//                                             (playing && !completed)
//                                                 ? "assets/svgs/pause-svgrepo-com.svg"
//                                                 : "assets/svgs/play-svgrepo-com.svg",
//                                             height: 24,
//                                             width: 24,
//                                             colorFilter: const ColorFilter.mode(
//                                               Colors.white,
//                                               BlendMode.srcIn,
//                                             ),
//                                           );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             ////Stop
//                             SvgPicture.asset(
//                               height: 20,
//                               "assets/svgs/stop-svgrepo-com.svg",
//                             ),
//                             ////Next
//                             GestureDetector(
//                               onTap: () async {
//                                 if (currentAyah <
//                                     (currentPlayingSurah?.totalAyah ?? 8)) {
//                                   if (currentPlayingSurah == null ||
//                                       audios.isEmpty)
//                                     return;
//                                   setState(() {
//                                     currentAyah++;
//                                   });
//                                   await player.stop();
//                                   log("current Ayah $currentAyah");
//                                   log(
//                                     "total Ayah ${currentPlayingSurah?.totalAyah}",
//                                   );
//                                   await _loadAyah(
//                                     currentPlayingSurah?.surahNo ?? 1,
//                                     currentAyah,
//                                   );
//                                   log("sheikhhh ${audios[0].url}");
//                                   await player.setUrl(audios[0].url);
//                                   await player.play();
//                                   setState(() {
//                                     isPlaying = true;
//                                   });
//                                 }
//                               },
//                               child: SvgPicture.asset(
//                                 height: 20,
//                                 "assets/svgs/skip-next-svgrepo-com.svg",
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   const Gap(20),

//                   ///operaitons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       //repeat
//                       SvgPicture.asset(
//                         "assets/svgs/repeat-svgrepo-com.svg",
//                         height: 20,
//                       ),
//                       //shuffle
//                       SvgPicture.asset(
//                         "assets/svgs/shuffle-svgrepo-com.svg",
//                         height: 20,
//                       ),
//                       //volume
//                       SvgPicture.asset(
//                         "assets/svgs/sound-volume-2-svgrepo-com.svg",
//                         height: 20,
//                       ),
//                       //download
//                       SvgPicture.asset(
//                         "assets/svgs/download-svgrepo-com.svg",
//                         height: 20,
//                       ),
//                       //share
//                       SvgPicture.asset(
//                         "assets/svgs/share-svgrepo-com.svg",
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const Gap(100),
//         ],
//       ),
//     );
//   }
// }
