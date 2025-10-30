import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/reading/domain/entities/tafsir_provider_entity.dart';
import 'package:gap/gap.dart';

class TafsirProviderTile extends StatefulWidget {
  const TafsirProviderTile({
    super.key,
    required this.tafsirProvider,
    required this.children,
    required this.isDark,
  });
  final TafsirProviderEntity tafsirProvider;
  final List<Widget> children;
  final bool isDark;

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
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: widget.isDark
                  ? QuranAppTheme.tafsirContainerBorderDark.withValues(
                      alpha: 0.4,
                    )
                  : QuranAppTheme.tafsirContainerBorderLight.withValues(
                      alpha: 0.3,
                    ),
              border: Border.all(
                color: widget.isDark
                    ? QuranAppTheme.tafsirContainerBorderDark
                    : QuranAppTheme.tafsirContainerBorderLight,
                width: 0.8,
              ),
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
                  widget.tafsirProvider.name ?? "Unknown",
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
