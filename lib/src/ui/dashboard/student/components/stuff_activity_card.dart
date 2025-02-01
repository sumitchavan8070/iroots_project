import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iroots/src/ui/dashboard/student/components/allocation_tracker_painter.dart';

class StuffActivityCard extends StatefulWidget {
  final String? studentName;
  final String? classId;
  final String? rollNumber;
  final String? date;
  final String? percentage;
  final String? userImage;

  const StuffActivityCard({
    super.key,
    this.studentName,
    this.classId,
    this.rollNumber,
    this.date,
    this.percentage,
    this.userImage,
  });

  @override
  State<StuffActivityCard> createState() => _StuffActivityCardState();
}

class _StuffActivityCardState extends State<StuffActivityCard> {
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 14),
                  Text(
                    'Stuff Activity',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "13 % Attendance",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 8, color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "62 % Co-Collective",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 8, color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: Colors.purpleAccent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "23% Mark Academic performance",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 8, color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const CircularProgressIndicatorWidget(
                percentages: [62, 23, 13], // Percentages
                colors: [Color(0xFF1575FF), Color(0xFF0DB166), Color(0xFF9F7CCB)],
                text: "2024",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircularProgressIndicatorWidget extends StatelessWidget {
  // final double percentage;
  final List<double> percentages;
  final List<Color> colors;
  final String text;

  const CircularProgressIndicatorWidget({
    super.key,
    required this.percentages,
    required this.colors,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(
        painter: CircularProgressPainter(percentages, colors, text) ??
            AllocationTrackerPainter(progress: 0.75),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final List<double> percentages;
  final List<Color> colors;
  final String text;

  CircularProgressPainter(this.percentages, this.colors, this.text);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double outerRadius = size.width / 2; // Outer white circle
    double innerRadius = outerRadius - 2; // Inner grey background
    double progressRadius = innerRadius - 6; // Arc radius
    double innerCircleRadius = progressRadius - 8; // Inner blue circle radius

    // 1. Outer White Background Circle
    Paint outerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, outerRadius, outerCirclePaint);

    // 2. Inner Grey Circle (Background)
    Paint backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerRadius, backgroundPaint);

    // 3. Draw Progress Arcs
    double startAngle = -pi / 2;
    for (int i = 0; i < percentages.length; i++) {
      double sweepAngle = 2 * pi * (percentages[i] / 100);
      Paint progressPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: progressRadius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
      startAngle += sweepAngle; // Move start position for next segment
    }

    // 4. Draw Inner Blue Circle
    Paint innerCirclePaint = Paint()
      ..color = const Color(0xFF1575FF)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerCircleRadius, innerCirclePaint);

    // 5. Draw Text in Center
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.white,
          fontSize: innerCircleRadius / 2,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    Offset textOffset = center - Offset(textPainter.width / 2, textPainter.height / 2);
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
