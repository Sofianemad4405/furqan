// import 'package:flutter/material.dart';
// import 'package:furqan/core/themes/theme_system.dart';
// import 'package:furqan/features/home/presentation/models/challenge_model.dart';
// import 'package:gap/gap.dart';

// class TodayChallenge extends StatelessWidget {
//   const TodayChallenge({
//     super.key,
//     required this.isDarkMood,
//     required this.challengeModel,
//   });
//   final bool isDarkMood;
//   final ChallengeModel challengeModel;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120,
//       decoration: QuranAppTheme.adaptiveGlassDecoration(
//         context,
//         backgroundColor: isDarkMood
//             ? QuranAppTheme.gray900
//             : QuranAppTheme.gray50,
//         borderColor: QuranAppTheme.gray400,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: challengeModel.challengeIconColor,
//                   ),
//                   child: Center(child: Text(challengeModel.challengeIcon)),
//                 ),
//                 const Gap(10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       challengeModel.challengeName,
//                       style: Theme.of(context).textTheme.labelLarge,
//                     ),
//                     Text(
//                       challengeModel.challengeDesc,
//                       style: Theme.of(context).textTheme.labelSmall,
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 Text(
//                   "${challengeModel.challengeDone}/${challengeModel.challengeCompletion}",
//                   style: Theme.of(context).textTheme.labelSmall,
//                 ),
//               ],
//             ),
//             const Spacer(),
//             LinearProgressIndicator(
//               minHeight: 6,
//               borderRadius: BorderRadius.circular(12),
//               value:
//                   challengeModel.challengeDone /
//                   challengeModel.challengeCompletion,
//               backgroundColor: QuranAppTheme.gray450,
//               color: challengeModel.challengeIconColor,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
