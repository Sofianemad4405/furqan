import 'dart:math';
import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furqan/core/entities/dhikr_entity.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/reading/presentation/widgets/session_stats.dart';
import 'package:gap/gap.dart';

class ZikrCounter extends StatefulWidget {
  const ZikrCounter({super.key, required this.dhikr, required this.title});
  final DhikrEntity? dhikr;
  final String? title;
  @override
  State<ZikrCounter> createState() => _ZikrCounterState();
}

class _ZikrCounterState extends State<ZikrCounter>
    with SingleTickerProviderStateMixin {
  int count = 0;
  bool countChange = false;
  void increaseCount() {
    setState(() {
      count++;
      countChange = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        countChange = false;
      });
    });
  }

  late AnimationController _controller;
  late Animation<double> _scale;
  late ConfettiController _confettiController;
  final GlobalKey<_AnimatedRewardBoxState> rewardBoxKey =
      GlobalKey<_AnimatedRewardBoxState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  void _onTap() {
    _controller.forward();
    setState(() {
      if (count == (widget.dhikr?.repeat ?? 1)) {
        _confettiController.play();
      }
    });
    rewardBoxKey.currentState?.animate();
    increaseCount();
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(12),
          CustomContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.title}",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Gap(5),
                      Text(
                        "Repeat ${widget.dhikr?.repeat} times",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: widget.title == "أذكار الصباح"
                              ? QuranAppTheme.morningAzkar
                              : widget.title == "أذكار المساء"
                              ? QuranAppTheme.nightAzkar
                              : widget.title == "أذكار بعد الصلاة"
                              ? QuranAppTheme.afterPrayerAzkar
                              : QuranAppTheme.theRest,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Text(
                              widget.dhikr?.zekr ?? "",
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Amiri",
                                    fontSize: 24,
                                  ),
                              textDirection: TextDirection.rtl,
                            ),
                            const Gap(30),
                            LinearProgressIndicator(
                              valueColor: const AlwaysStoppedAnimation(
                                Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              minHeight: 15,
                              value: count / (widget.dhikr?.repeat ?? 1),
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                Text(
                                  "${(count / (widget.dhikr?.repeat ?? 1) * 100).toInt()}% complete",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                Text(
                                  "${(widget.dhikr?.repeat ?? 1) - count >= 0 ? (widget.dhikr?.repeat ?? 1) - count : 0} remaining",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            if (widget.dhikr!.repeat <= count) const Gap(50),
                            if (widget.dhikr!.repeat <= count)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: AnimatedRewardBox(
                                  count: count,
                                  key: rewardBoxKey,
                                ),
                              ),
                            const Gap(50),
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: _onTap,
                                    child: ScaleTransition(
                                      scale: _scale,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.1,
                                          ),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.add,
                                                  color: Color(0xFF27BBDD),
                                                ),
                                                const Gap(10),
                                                Text(
                                                  "Count",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                          0xFF27BBDD,
                                                        ),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Stack(
                                        children: [
                                          BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 4,
                                              sigmaY: 4,
                                            ),
                                            child: Container(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              width: 50,
                                              height: 50,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.restart_alt_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: AnimatedScale(
                        scale: 1.0 + (countChange ? 0.2 : 0.0),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: Text(
                          count.toString(),
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                SizedBox(
                  height: 100,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SessionStats(
                          icon: const Icon(
                            Icons.alarm,
                            color: Color(0xff27A57A),
                            size: 15,
                          ),
                          title: 'Sessions Time',
                          iconColor: const Color(0xff27A57A),
                          topColumn: Text(
                            "2:49",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: SessionStats(
                          icon: const Icon(
                            Icons.alarm,
                            color: Color(0xff27A57A),
                            size: 15,
                          ),
                          title: '+$count',
                          iconColor: const Color(0xff27A57A),
                          topColumn: Expanded(
                            child: Center(
                              child: Text(
                                "Hasanat Earned",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(50),
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive, // متوزعة
                  blastDirection: -pi / 2, // تطلع لفوق
                  emissionFrequency: .2, // معدل الانبعاث
                  numberOfParticles: 25, // عدد الورق
                  gravity: 0.2, // الجاذبية تخليها تنزل لتحت تاني
                  colors: const [
                    // ألوان الورق
                    Colors.red,
                    Colors.blue,
                    Colors.green,
                    Colors.orange,
                    Colors.purple,
                  ],
                ),
                const Gap(120),
              ],
            ),
          ),
          // CustomContainer(
          //   isDarkMood: context.read<ThemeCubit>().isDarkMood(),
          //   child: child,
          // ),
        ],
      ),
    );
  }
}

class AnimatedRewardBox extends StatefulWidget {
  final int count;
  const AnimatedRewardBox({super.key, required this.count});

  @override
  State<AnimatedRewardBox> createState() => _AnimatedRewardBoxState();
}

class _AnimatedRewardBoxState extends State<AnimatedRewardBox> {
  bool isScaled = false;
  void animate() {
    setState(() => isScaled = true); // يكبر شوية
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() => isScaled = false); // يرجع لحجمه الطبيعي
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: animate,
        child: AnimatedScale(
          scale: isScaled ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          height: 30,
                          width: 30,
                          "assets/svgs/celebrations.svg",
                        ),
                        const Gap(10),
                        Text(
                          "Target Reached!",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Text(
                      "+ ${widget.count} hasanat earned!",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
