// class TodayChallenge {
//   int id;
//   String title;
//   String description;
//   String icon;
//   int finished;
//   int target;

//   TodayChallenge({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.icon,
//     required this.target,
//     required this.finished,
//   });
//   double get progress {
//     if (target == 0) return 0;
//     return finished / target;
//   }

//   factory TodayChallenge.fromJson(Map<String, dynamic> json) {
//     return TodayChallenge(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       icon: json['icon'],
//       target: json['target'],
//       finished: json['finished'],
//     );
//   }
// }
