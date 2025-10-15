import 'package:flutter/material.dart';
import 'package:furqan/core/widgets/shimmers/shimmer_container.dart';

class CurrentStreakShimmer extends StatelessWidget {
  const CurrentStreakShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerContainer(height: 150);
  }
}

// class CurrentStreak extends StatelessWidget {
//   const CurrentStreak({super.key, required this.userProgress});
//   final UserProgress userProgress;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         gradient: LinearGradient(
//           colors: [Color(0xFFF5830C), Color(0xFFF56261)],
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Current Streak",
//                   style: Theme.of(
//                     context,
//                   ).textTheme.headlineMedium?.copyWith(color: Colors.white),
//                 ),
//                 const Gap(3),
//                 Text(
//                   "Keep up the great work!",
//                   style: Theme.of(
//                     context,
//                   ).textTheme.bodyMedium?.copyWith(color: Colors.white),
//                 ),
//                 const Spacer(),
//                 Text(
//                   "Best: 0 days",
//                   style: Theme.of(
//                     context,
//                   ).textTheme.bodySmall?.copyWith(color: Colors.white),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Column(
//               children: [
//                 const Text(
//                   "🔥",
//                   style: TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//                 const Spacer(),
//                 Text(
//                   "${userProgress.currentStreak}\ndays",
//                   style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     color: Colors.white,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
