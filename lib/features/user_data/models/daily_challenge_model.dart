class DailyChallengeModel {
  final int id;
  final String title;
  final String icon;
  final String description;
  final int target;
  DailyChallengeModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.target,
  });

  factory DailyChallengeModel.fromJson(Map<String, dynamic> json) {
    return DailyChallengeModel(
      title: json['title'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      target: json['target'] as int,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'description': description,
      'target': target,
      'id': id,
    };
  }
}
