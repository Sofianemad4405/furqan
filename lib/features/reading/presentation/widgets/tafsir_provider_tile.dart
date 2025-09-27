import 'package:flutter/material.dart';
import 'package:furqan/features/reading/domain/entities/tafsir_provider_entity.dart';
import 'package:gap/gap.dart';

class TafsirProviderTile extends StatefulWidget {
  const TafsirProviderTile({
    super.key,
    required this.tafsirProvider,
    required this.children,
  });
  final TafsirProviderEntity tafsirProvider;
  final List<Widget> children;

  @override
  State<TafsirProviderTile> createState() => _TafsirProviderTileState();
}

class _TafsirProviderTileState extends State<TafsirProviderTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _isExpanded
                  ? const Color(0xff9EEAC7).withValues(alpha: 0.4)
                  : const Color(0xff9EEAC7).withValues(alpha: 0.3),
              border: Border.all(color: const Color(0xff9EEAC7), width: 0.8),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                Container(
                  height: 5,
                  width: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff00B578),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.tafsirProvider.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: "Amiri",
                    color: const Color(0xff00B578),
                  ),
                ),
                const Spacer(),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: const Color(0xff00B578),
                ),
              ],
            ),
          ),
        ),
        const Gap(10),
        if (_isExpanded) Column(children: widget.children),
      ],
    );
  }
}
