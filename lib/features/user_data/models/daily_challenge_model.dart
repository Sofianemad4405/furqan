class DailyChallengeModel {
  final int id;
  final String userId;
  final String title;
  final String icon;
  final String description;
  final int target;
  int completed;
  final String createdAt;

  DailyChallengeModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.icon,
    required this.description,
    required this.target,
    required this.completed,
    required this.createdAt,
  });

  double get progress {
    if (target == 0) return 0;
    return completed / target;
  }

  // factory DailyChallengeModel.fromJson(Map<String, dynamic> json) {
  //   return DailyChallengeModel(
  //     userId: json['user_id'] as String,
  //     title: json['title'] as String,
  //     icon: json['icon'] as String,
  //     description: json['description'] as String,
  //     target: json['target'] as int,
  //     completed: json['completed'] as int,
  //     createdAt: json['created_at'] as String,
  //     id: null,
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'user_id': userId,
  //     'title': title,
  //     'icon': icon,
  //     'description': description,
  //     'target': target,
  //     'completed': completed,
  //     'created_at': createdAt,
  //   };
  // }

}
