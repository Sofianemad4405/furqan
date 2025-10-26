import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/entities/azkar_section_entity.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/widgets/azkar_list_view.dart';
import 'package:furqan/features/home/presentation/screens/adhkar/widgets/dhikr_list_tile.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

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
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AdhkarCubit, AdhkarState>(
          builder: (context, state) {
            if (state is AdhkarLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AdhkarCategoriesLoaded) {
              return Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const Gap(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "الأذكار والأدعية",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                              const Gap(5),
                              Text(
                                "Dhikr & Supplications",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),

                  ///Azkar Elsaba7
                  DhikrListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        GetPageRoute(
                          page: () => AzkarListView(
                            titleTranslation: "Morning Azkar",
                            azkarSectionEntity: morningAzkar,
                            icon: 'assets/svgs/sunrise-up-svgrepo-com.svg',
                          ),
                        ),
                      );
                    },
                    title: azkarCategories[0],
                    englishTitle: azkarCategoriesEnglish[0],
                    count: morningAzkar?.content.length ?? 0,
                    icon: 'assets/svgs/sunrise-up-svgrepo-com.svg',
                  ),

                  const Gap(20),

                  ///Azkar Elmasaa
                  DhikrListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        GetPageRoute(
                          page: () => AzkarListView(
                            titleTranslation: "Evening Azkar",
                            azkarSectionEntity: eveningAzkar,
                            icon: 'assets/svgs/moon-svgrepo-com.svg',
                          ),
                        ),
                      );
                    },
                    englishTitle: azkarCategoriesEnglish[1],
                    title: azkarCategories[1],
                    count: eveningAzkar?.content.length ?? 0,
                    icon: 'assets/svgs/moon-svgrepo-com.svg',
                  ),
                  const Gap(20),

                  ///Azkar Elmasaa
                  DhikrListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        GetPageRoute(
                          page: () => AzkarListView(
                            titleTranslation: "Post Prayer Azkar",
                            azkarSectionEntity: postPratAzkar,
                            icon: 'assets/svgs/prayer-beads-svgrepo-com.svg',
                          ),
                        ),
                      );
                    },
                    englishTitle: azkarCategoriesEnglish[2],
                    title: azkarCategories[2],
                    count: postPratAzkar?.content.length ?? 0,
                    icon: 'assets/svgs/prayer-beads-svgrepo-com.svg',
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
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
