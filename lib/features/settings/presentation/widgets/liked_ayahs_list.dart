import 'package:flutter/material.dart';
import 'package:furqan/features/settings/data/models/liked_ayah.dart';
import 'package:iconsax/iconsax.dart';

class LikedAyahsList extends StatefulWidget {
  const LikedAyahsList({Key? key}) : super(key: key);

  @override
  State<LikedAyahsList> createState() => _LikedAyahsListState();
}

class _LikedAyahsListState extends State<LikedAyahsList> {
  final List<LikedAyah> _likedAyahs = [
    LikedAyah(
      id: '1',
      surahName: 'Al-Baqarah',
      ayahNumber: 255,
      arabicText:
          'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ',
      translation:
          'Allah - there is no deity except Him, the Ever-Living, the Sustainer of existence. Neither drowsiness overtakes Him nor sleep.',
      likedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    LikedAyah(
      id: '2',
      surahName: 'Ar-Rahman',
      ayahNumber: 13,
      arabicText: 'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ',
      translation: 'So which of the favors of your Lord would you deny?',
      likedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  String? _expandedAyahId;
  bool _showClearDialog = false;

  void _removeLike(String id) {
    setState(() {
      _likedAyahs.removeWhere((ayah) => ayah.id == id);
    });
  }

  void _clearAll() {
    setState(() {
      _likedAyahs.clear();
      _showClearDialog = false;
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_likedAyahs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x4DEC4899), Color(0x4DF43F5E)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.favorite, size: 40, color: Colors.pink),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Liked Ayahs Yet',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the heart icon while reading\nto save your favorite verses here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? const Color(0xFF9CA3AF)
                    : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Iconsax.heart5, color: Colors.pink, size: 20),
                  const SizedBox(width: 8),
                  Text('Liked Ayahs (${_likedAyahs.length})'),
                ],
              ),
              if (_likedAyahs.isNotEmpty)
                TextButton.icon(
                  onPressed: () => setState(() => _showClearDialog = true),
                  icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                  label: const Text(
                    'Clear All',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 500,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _likedAyahs.length,
              itemBuilder: (context, index) {
                final ayah = _likedAyahs[index];
                final isExpanded = _expandedAyahId == ayah.id;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF1F2937), const Color(0x4DEC4899)]
                          : [const Color(0xFFFFFFFF), const Color(0xFFFCE7F3)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? const Color(0x33EC4899)
                          : const Color(0xFFFCE7F3),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCE7F3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.book,
                                    size: 12,
                                    color: Colors.pink,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    ayah.surahName,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.pink,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => _removeLike(ayah.id),
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.pink,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _expandedAyahId = isExpanded ? null : ayah.id;
                            });
                          },
                          child: Text(
                            ayah.arabicText,
                            textDirection: TextDirection.rtl,
                            maxLines: isExpanded ? null : 2,
                            style: const TextStyle(fontSize: 16, height: 1.8),
                          ),
                        ),
                        if (isExpanded) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              ayah.translation,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Liked ${_formatDate(ayah.likedAt)}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _expandedAyahId = isExpanded ? null : ayah.id;
                                });
                              },
                              child: Text(
                                isExpanded ? 'Show less' : 'Show more',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_showClearDialog)
            Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Clear All Liked Ayahs?'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                setState(() => _showClearDialog = false),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _clearAll,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Clear All'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
