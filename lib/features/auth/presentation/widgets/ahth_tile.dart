import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AhthTile extends StatelessWidget {
  const AhthTile({
    super.key,
    required this.tileColor,
    required this.isFacebook,
    required this.iconPath,
    required this.text,
  });
  final Color tileColor;
  final bool isFacebook;
  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath),
          const Gap(10),
          Text(
            text,
            style: TextStyle(color: isFacebook ? Colors.blue : Colors.black),
          ),
        ],
      ),
    );
  }
}
