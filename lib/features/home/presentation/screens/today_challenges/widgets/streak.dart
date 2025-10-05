import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class Streak extends StatelessWidget {
  const Streak({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8F0DC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: Icon(
                            Iconsax.calendar,
                            color: Color(0xFF25A479),
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current \nStreak",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Text(
                          "0 days",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(20),
          Expanded(
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4EFBA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: Icon(
                            Iconsax.cup,
                            color: Color(0xFFD09724),
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Completed",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Text(
                          "0 days",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
