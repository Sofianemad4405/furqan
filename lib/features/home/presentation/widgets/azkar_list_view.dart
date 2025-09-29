import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';

class AzkarListView extends StatefulWidget {
  const AzkarListView({
    super.key,
    required this.zikr,
    required this.count,
    required this.container,
    required this.titleTranslation,
    required this.title,
    required this.length,
    this.bless,
  });
  final String zikr;
  final int count;
  final Widget container;
  final String title;
  final String titleTranslation;
  final int length;
  final String? bless;
  @override
  State<AzkarListView> createState() => _AzkarListViewState();
}

class _AzkarListViewState extends State<AzkarListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          isDarkMood: context.watch<ThemeCubit>().isDarkMood(),
          child: Row(
            children: [
              const Icon(Icons.arrow_back),
              Column(
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(fontFamily: "Amiri"),
                  ),
                  Text(
                    widget.titleTranslation,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
