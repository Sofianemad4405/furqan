import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/models/stat_model.dart';

class CustomCard extends StatelessWidget {
  final StatModel statModel;
  final List<Color> gradient;
  final Color border;
  final Color label;

  const CustomCard({
    super.key,
    required this.gradient,
    required this.border,
    required this.statModel,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: border, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(statModel.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            statModel.number.toString(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: label,
            ),
          ),
          const SizedBox(height: 4),
          Text(statModel.label, style: TextStyle(fontSize: 12, color: label)),
        ],
      ),
    );
  }
}
