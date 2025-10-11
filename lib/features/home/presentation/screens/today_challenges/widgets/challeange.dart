import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class Challeange extends StatefulWidget {
  const Challeange({
    super.key,
    required this.challengeTitle,
    required this.challengeDesc,
    required this.numberOfSteps,
    required this.completed,
    required this.percentage,
    required this.hasanatReward,
    this.isDuaa = false,
    required this.isCompleted,
  });
  final String challengeTitle;
  final String challengeDesc;
  final int numberOfSteps;
  final int completed;
  final double percentage;
  final int hasanatReward;
  final bool isDuaa;
  final bool isCompleted;

  @override
  State<Challeange> createState() => _ChalleangeState();
}

class _ChalleangeState extends State<Challeange> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      decoration: widget.isCompleted
          ? BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              // gradient: LinearGradient(
              //   colors: widget.isCompleted
              //       ? const [Color(0xFF00A83F), Color(0xFF00BD4B)]
              //       : const [Color(0xFF2575F5), Color(0xFF1962F4)],
              // ),
              border: Border.all(color: const Color(0xFF00A83F)),
              color: const Color(0xFF00A83F).withValues(alpha: 0.1),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      colors: widget.isDuaa
                          ? const [Color(0xFF00A83F), Color(0xFF00BD4B)]
                          : const [Color(0xFF2575F5), Color(0xFF1962F4)],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SvgPicture.asset(
                        widget.isDuaa
                            ? "assets/svgs/heart-icon.svg"
                            : "assets/svgs/bookopen-icon.svg",
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.challengeTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          if (widget.isCompleted)
                            const Icon(
                              Iconsax.tick_circle,
                              color: Color(0xFF00A83F),
                            ),
                        ],
                      ),
                      Text(
                        widget.challengeDesc,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(30),
            Row(
              children: [
                Text(
                  "Progress: ${widget.completed}/${widget.numberOfSteps}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                Text(
                  "${widget.percentage.toInt()}%",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF009362),
                  ),
                ),
              ],
            ),
            const Gap(10),
            LinearProgressIndicator(
              value: widget.percentage / 100,
              backgroundColor: const Color(0xFFC4C4C7),
              color: const Color(0xFF009362),
              minHeight: 12,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            const Gap(30),
            Row(
              children: [
                SvgPicture.asset("assets/svgs/sparkles-svgrepo-com.svg"),
                const Gap(10),
                Text(
                  "Reward: +${widget.hasanatReward} hasanat",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                if (widget.isCompleted)
                  Text(
                    "✓ Earned!",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: const Color(0xFF00A83F),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
