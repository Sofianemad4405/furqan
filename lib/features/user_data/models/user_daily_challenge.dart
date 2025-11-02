import 'package:furqan/features/user_data/models/daily_challenge_model.dart';

class UserDailyChallenge {
  final int id;
  final int challengeId;
  final int completed;
  final DateTime date;
  final DailyChallengeModel challenge;
  UserDailyChallenge({
    required this.id,
    required this.challengeId,
    required this.completed,
    required this.date,
    required this.challenge,
  });
  factory UserDailyChallenge.fromJson(Map<String, dynamic> json) {
    return UserDailyChallenge(
      id: json['id'] as int,
      challengeId: json['challenge_id'] as int,
      completed: json['completed'] as int,
      date: DateTime.parse(json['date'] as String),
      challenge: DailyChallengeModel.fromJson(json['daily_challenges']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'challenge_id': challengeId,
      'completed': completed,
      'date': date.toIso8601String(),
      'daily_challenges': challenge.toJson(),
    };
  }
}
