import 'package:flutter/material.dart';
import 'package:furqan/core/widgets/shimmers/shimmer_container.dart';

class TodayChallengesShimmer extends StatelessWidget {
  const TodayChallengesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3 * (100 + 16), // 3 items, 100 height + 16 padding
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(top: 16),
            child: ShimmerContainer(height: 100),
          );
        },
      ),
    );
  }
}

// class TodayChallengesListView extends StatelessWidget {
//   const TodayChallengesListView({super.key, required this.userProgress});
//   final UserProgress userProgress;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 3,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const TodayChallenges()),
//           ),
//           child: BlocBuilder<ThemeCubit, ThemeMode>(
//             builder: (context, state) {
//               bool isDark = state == ThemeMode.dark;
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: CustomContainer(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 16,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             ///challenge icon
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 40,
//                                   width: 40,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     color: isDark
//                                         ? QuranAppTheme
//                                               .homeIconsContainersColorsDark[index]
//                                         : QuranAppTheme
//                                               .homeIconsContainersColorsLight[index],
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       userProgress.todayChallenges[index].icon,
//                                       style: Theme.of(
//                                         context,
//                                       ).textTheme.bodyMedium,
//                                     ),
//                                   ),
//                                 ),
//                                 const Gap(10),
//                                 Text(
//                                   userProgress.todayChallenges[index].title,
//                                   style: Theme.of(
//                                     context,
//                                   ).textTheme.titleMedium,
//                                 ),
//                               ],
//                             ),
//                             const Spacer(),
//                             Text(
//                               "${userProgress.todayChallenges[index].finished}/${userProgress.todayChallenges[index].target}",
//                               style: Theme.of(context).textTheme.bodySmall,
//                             ),
//                           ],
//                         ),
//                         const Gap(20),
//                         Text(
//                           userProgress.todayChallenges[index].description,
//                           style: Theme.of(context).textTheme.bodySmall,
//                         ),
//                         const Gap(20),
//                         LinearProgressIndicator(
//                           minHeight: 5,
//                           borderRadius: BorderRadius.circular(12),
//                           value: userProgress.todayChallenges[index].progress,
//                           backgroundColor: QuranAppTheme.gray450,
//                           color: QuranAppTheme.green,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
