import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:gap/gap.dart';

class SurahListTile extends StatelessWidget {
  const SurahListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Theme.of(context).cardColor),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                      ),
                    ),
                    child: Center(child: Text("1")),
                  ),
                  Gap(20),
                  Text(
                    "Al-Fatiha",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Text("الفاتحة"),
        ],
      ),
    );
  }
}
