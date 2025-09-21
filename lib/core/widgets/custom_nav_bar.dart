import 'dart:ui';
import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), // شبه الزجاج
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.e_mobiledata,
                    color: currentIndex == 0 ? Colors.blue : Colors.white,
                  ),
                  onPressed: () => onTap(0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: currentIndex == 1 ? Colors.blue : Colors.white,
                  ),
                  onPressed: () => onTap(1),
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: currentIndex == 2 ? Colors.blue : Colors.white,
                  ),
                  onPressed: () => onTap(2),
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: currentIndex == 3 ? Colors.blue : Colors.white,
                  ),
                  onPressed: () => onTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
