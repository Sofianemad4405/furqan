class Achievement {
  final int id;
  final String title;
  final String description;
  final String icon;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description, 'icon': icon};
  }
}
