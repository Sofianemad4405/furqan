import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/entities/azkar_section_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:furqan/features/home/presentation/widgets/azkar_list_view.dart';
import 'package:furqan/features/home/presentation/widgets/dhikr_list_tile.dart';
import 'package:gap/gap.dart';

class DhikrScreen extends StatefulWidget {
  const DhikrScreen({super.key});

  @override
  State<DhikrScreen> createState() => _DhikrScreenState();
}

class _DhikrScreenState extends State<DhikrScreen> {
  AzkarSectionEntity? morningAzkar;
  AzkarSectionEntity? eveningAzkar;
  AzkarSectionEntity? postPratAzkar;
  @override
  void initState() {
    super.initState();
    context.read<AdhkarCubit>().init();
    getAzkar("azkar_massa");
    getAzkar("azkar_sabah");
    getAzkar("PostPrayer_azkar");
  }

  Future<void> getAzkar(String category) async {
    final result = await context.read<AdhkarCubit>().getSectionAdhkar(category);
    setState(() {
      if (category == "azkar_sabah") {
        morningAzkar = result;
      } else if (category == "azkar_massa") {
        eveningAzkar = result;
      } else if (category == "PostPrayer_azkar") {
        postPratAzkar = result;
      }
    });
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
                        // context.read<AdhkarCubit>().getAdhkar("azkar_sabah");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AzkarListView(
                              titleTranslation: "Morning Azkar",
                              azkarSectionEntity: morningAzkar,
                            ),
                          ),
                        );
                      },
                      title: azkarCategories[0],
                      englishTitle: azkarCategoriesEnglish[0],
                      count: morningAzkar?.content.length ?? 0,
                    ),
                    const Gap(20),
                    DhikrListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AzkarListView(
                              titleTranslation: "Evening Azkar",
                              azkarSectionEntity: eveningAzkar,
                            ),
                          ),
                        );
                      },
                      englishTitle: azkarCategoriesEnglish[1],
                      title: azkarCategories[1],
                      count: eveningAzkar?.content.length ?? 0,
                    ),
                    const Gap(20),
                    DhikrListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AzkarListView(
                              titleTranslation: "Post Prayer Azkar",
                              azkarSectionEntity: postPratAzkar,
                            ),
                          ),
                        );
                      },
                      englishTitle: azkarCategoriesEnglish[2],
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
              // if (state is AdhkarLoaded) {

              // }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
