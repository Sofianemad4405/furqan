import 'package:flutter/material.dart';

class ChallengeModel {
  final String challengeIcon;
  final String challengeName;
  final String challengeDesc;
  final int challengeCompletion;
  final int challengeDone;
  final Color challengeIconColor;

  ChallengeModel({
    required this.challengeIcon,
    required this.challengeName,
    required this.challengeDesc,
    required this.challengeCompletion,
    required this.challengeDone,
    required this.challengeIconColor,
  });
}
