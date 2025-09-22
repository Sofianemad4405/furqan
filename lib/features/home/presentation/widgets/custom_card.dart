import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final int totalHasanat;

  const CustomCard({super.key, required this.totalHasanat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF9C4), // from yellow-50 تقريبًا
            Color(0xFFFFE0B2), // to orange-50
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Color(0xFF844800), width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("🌙", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            totalHasanat.toString(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Hasanat",
            style: TextStyle(fontSize: 12, color: Colors.orange.shade600),
          ),
        ],
      ),
    );
  }
}
