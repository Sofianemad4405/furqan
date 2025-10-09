import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:gap/gap.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? userName;
  String? userPhoto;
  String? userEmail;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final prefs = sl<Prefs>();
    final name = prefs.name;
    final photo = prefs.photo;
    final email = prefs.email;

    setState(() {
      userName = name;
      userPhoto = photo;
      userEmail = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///Welcome
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back ,$userName",
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 5,
            ),
            const Gap(10),
            Text(
              "Continue your spiritual journey today",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: QuranAppTheme.gray400),
            ),
          ],
        ),
        const Spacer(),

        ///Avatar Image
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(userPhoto ?? ""),
        ),
      ],
    );
  }
}
