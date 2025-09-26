import 'package:flutter/material.dart';
import 'package:furqan/core/entities/surah_entity.dart';

class ListeningToSurah extends StatefulWidget {
  const ListeningToSurah({super.key, required this.surah});

  final SurahEntity surah;

  @override
  State<ListeningToSurah> createState() => _ListeningToSurahState();
}

class _ListeningToSurahState extends State<ListeningToSurah> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("Reading")]);
  }
}
