import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iroots/src/ui/dashboard/student/components/allocation_tracker_painter.dart';
import 'package:iroots/src/utility/constant/asset_path.dart';

class StudentDetailCard extends StatefulWidget {
  const StudentDetailCard({super.key});

  @override
  State<StudentDetailCard> createState() => _StudentDetailCardState();
}

class _StudentDetailCardState extends State<StudentDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF69A6FE), Color(0xFF1575FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        AssetPath.onePNG,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover, // Ensures the image covers the circular area properly
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Guy Hawkins",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Class: X-B ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: ' | Roll No: 12 ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SvgPicture.asset(AssetPath.edit, height: 30, width: 30),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AssetPath.calendar, height: 30, width: 30),
                        const SizedBox(width: 14),
                        Text(
                          'Attendance',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "02-Jan-2024",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "Present",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8,
                                ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "Absent",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8,
                                ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "Leave ",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const CircularProgressIndicatorWidget(
                  percentage: 75, // Change this value to update the progress
                ),
              ],
            ),
          ],
        ));
  }
}

class CircularProgressIndicatorWidget extends StatelessWidget {
  final double percentage;

  const CircularProgressIndicatorWidget({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(
        painter: AllocationTrackerPainter(progress: 0.75),
      ),
    );
  }
}



class CircularProgressPainter extends CustomPainter {
  final double percentage;

  CircularProgressPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double outerRadius = size.width / 2; // Outer white circle
    double innerRadius = outerRadius - 2; // Inner grey background
    double progressRadius = innerRadius - 6; // Blue progress arc

    // 1. Outer White Background Circle
    Paint outerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill; // Filled background

    canvas.drawCircle(center, outerRadius, outerCirclePaint);

    // 2. Inner Grey Circle
    Paint backgroundPaint = Paint()
      ..color = Colors.transparent // Black for contrast (change if needed)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, innerRadius, backgroundPaint);

    // 3. Blue Progress Arc
    Paint progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    double angle = 2 * pi * (percentage / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: progressRadius),
      -pi / 2,
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
