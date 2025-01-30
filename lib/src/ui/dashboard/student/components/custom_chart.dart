import 'package:flutter/material.dart';

class CircularProgressIndicatorWithText extends StatelessWidget {
  final double progress;
  final Color progressColor;
  final double textValue;
  final double outermostBorderWidth;
  final double outerBorderWidth;
  final double innerBorderWidth;
  final double progressStrokeWidth; // Added stroke width for boldness

  const CircularProgressIndicatorWithText({
    super.key,
    required this.progress,
    required this.progressColor,
    required this.textValue,
    this.outermostBorderWidth = 2, // Outermost border width
    this.outerBorderWidth = 4, // Increased Outer border width
    this.innerBorderWidth = 2, // Inner border width
    this.progressStrokeWidth = 12, // Increased stroke width for bolder effect
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: CircularProgressPainter(
        progress: progress,
        progressColor: progressColor,
        textValue: textValue,
        outermostBorderWidth: outermostBorderWidth,
        outerBorderWidth: outerBorderWidth,
        innerBorderWidth: innerBorderWidth,
        progressStrokeWidth: progressStrokeWidth,
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final double textValue;
  final double outermostBorderWidth;
  final double outerBorderWidth;
  final double innerBorderWidth;
  final double progressStrokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.textValue,
    required this.outermostBorderWidth,
    required this.outerBorderWidth,
    required this.innerBorderWidth,
    required this.progressStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = (size.width - outermostBorderWidth * 2 - 10) / 2;
    double outerRadius = radius - outermostBorderWidth;
    double innerRadius = outerRadius - outerBorderWidth;

    // Paint for the outermost border
    Paint outermostBorderPaint = Paint()
      ..color = Colors.white // Outermost border color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = outermostBorderWidth;

    // Draw the outermost border circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, outermostBorderPaint);

    // Paint for the outer border
    Paint outerBorderPaint = Paint()
      ..color = Colors.red // Outer border color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerBorderWidth;

    // Draw the outer border circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), outerRadius, outerBorderPaint);

    // Paint for the inner border
    Paint innerBorderPaint = Paint()
      ..color = Colors.white // Inner border color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = innerBorderWidth;

    // Draw the inner border circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), innerRadius, innerBorderPaint);

    // Paint for the progress circle
    Paint progressPaint = Paint()
      ..color = progressColor // Set vibrant green or red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = progressStrokeWidth; // Thicker stroke for boldness

    // Draw the progress circle (arc)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: outerRadius),
      -3.1415927 / 2, // Start angle (top)
      2 * 3.1415927 * progress, // Sweep angle
      false,
      progressPaint,
    );

    // Draw the text in the center
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: textValue.toString(),
        style: const TextStyle(
          fontSize: 18, // Increased font size for better visibility
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color for contrast
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint when progress changes
  }
}
