import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/entities/azkar_section_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:furqan/features/home/presentation/widgets/dhikr_list_tile.dart';
import 'package:furqan/features/home/presentation/widgets/zikr_container.dart';
import 'package:gap/gap.dart';

class DhikrScreen extends StatefulWidget {
  const DhikrScreen({super.key});

  @override
  State<DhikrScreen> createState() => _DhikrScreenState();
}

class _DhikrScreenState extends State<DhikrScreen> {
  AzkarSectionEntity? morningAzkar;
  AzkarSectionEntity? nightAzkar;
  AzkarSectionEntity? postPratAzkar;
  @override
  void initState() {
    super.initState();
    log("Iam dhikr");
    context.read<AdhkarCubit>().init();
    getAzkar(morningAzkar, "azkar_sabah");
    getAzkar(nightAzkar, "azkar_massa");
    getAzkar(postPratAzkar, "PostPrayer_azkar");
  }

  Future<void> getAzkar(
    AzkarSectionEntity? azkarSectionEntity,
    String category,
  ) async {
    azkarSectionEntity = await context.read<AdhkarCubit>().getSectionAdhkar(
      category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.watch<ThemeCubit>().isDarkMood()
              ? QuranAppTheme.darkScaffoldGradient.colors
              : QuranAppTheme.lightScaffoldGradient.colors,
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<AdhkarCubit, AdhkarState>(
            builder: (context, state) {
              if (state is AdhkarCategoriesLoaded) {
                return Column(
                  children: [
                    DhikrListTile(
                      onTap: () {
                        context.read<AdhkarCubit>().getAdhkar("azkar_sabah");
                      },
                      isDark: context.read<ThemeCubit>().isDarkMood(),
                      title: azkarCategories[0],
                      englishTitle: azkarCategoriesEnglish[0],
                      count: morningAzkar?.content.length ?? 0,
                    ),
                    const Gap(20),
                    DhikrListTile(
                      onTap: () {
                        context.read<AdhkarCubit>().getAdhkar("azkar_massa");
                      },
                      englishTitle: azkarCategoriesEnglish[1],
                      isDark: context.read<ThemeCubit>().isDarkMood(),
                      title: azkarCategories[1],
                      count: nightAzkar?.content.length ?? 0,
                    ),
                    const Gap(20),
                    DhikrListTile(
                      onTap: () {
                        context.read<AdhkarCubit>().getAdhkar(
                          "PostPrayer_azkar",
                        );
                      },
                      englishTitle: azkarCategoriesEnglish[2],
                      isDark: context.read<ThemeCubit>().isDarkMood(),
                      title: azkarCategories[2],
                      count: postPratAzkar?.content.length ?? 0,
                    ),
                  ],
                );
              }
              if (state is AdhkarLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is AdhkarError) {
                return Center(child: Text(state.message));
              }
              if (state is AdhkarLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.adhkar.content.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ZikrContainer(
                          zikr: state.adhkar.content[index].zekr,
                          count: state.adhkar.content[index].repeat,
                          title: state.adhkar.title,
                          bless: state.adhkar.content[index].bless,
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
