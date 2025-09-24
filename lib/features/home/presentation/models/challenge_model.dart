import 'package:flutter/material.dart';

class ChallengeModel {
  final String challengeIcon;
  final String challengeName;
  final String? challengeDesc;
  final int? challengeCompletion;
  final int? challengeDone;
  final Color? challengeIconColor;

  ChallengeModel({
    required this.challengeIcon,
    required this.challengeName,
    this.challengeDesc,
    this.challengeCompletion,
    this.challengeDone,
    this.challengeIconColor,
  });
}
