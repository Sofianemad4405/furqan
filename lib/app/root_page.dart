import 'package:flutter/material.dart';
import 'package:furqan/core/widgets/custom_nav_bar.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        child: FloatingNavBar(currentIndex: 0, onTap: (int p1) {}),
      ),
    );
  }
}
