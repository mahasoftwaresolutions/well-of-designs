import 'dart:math';
import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Main "Your Goal" card with an area chart showing calorie progress.
class GoalCard extends StatelessWidget {
  const GoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      decoration: BoxDecoration(
        color: FTTokens.cardWhite,
        borderRadius: BorderRadius.circular(FTTokens.cardRadiusLg),
        boxShadow: FTTokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Goal', style: FTTokens.labelSmall),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('413', style: FTTokens.valueLarge),
                      const SizedBox(width: 8),
                      Text('kcal', style: FTTokens.unit),
                    ],
                  ),
                ],
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: FTTokens.surfaceLight,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: FTTokens.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Chart area
          SizedBox(
            height: 140,
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 140),
                  painter: _CalorieChartPainter(),
                ),
                // Annotation text
                Positioned(
                  right: 16,
                  top: 28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('burn 250', style: FTTokens.chartAnnotation),
                      Text('calorie left.', style: FTTokens.chartAnnotation),
                      const SizedBox(height: 4),
                      Text('163 Kcal', style: FTTokens.chartValue),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the calorie area chart.
class _CalorieChartPainter extends CustomPainter {
  // Normalised data points from the React SVG (viewBox 320×140)
  static const _rawPoints = [
    [10, 40], [25, 40], [35, 55], [55, 55], [65, 65], [85, 65],
    [95, 55], [120, 55], [135, 65], [150, 65], [165, 50], [185, 50],
    [200, 65], [215, 65], [235, 85], [250, 85], [260, 95],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 320;
    final sy = size.height / 140;

    final points =
        _rawPoints.map((p) => Offset(p[0] * sx, p[1] * sy)).toList();

    // Area gradient
    final areaPath = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      areaPath.lineTo(p.dx, p.dy);
    }
    areaPath.lineTo(points.last.dx, 125 * sy);
    areaPath.lineTo(points.first.dx, 125 * sy);
    areaPath.close();

    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          FTTokens.accent.withAlpha(64),
          FTTokens.accent.withAlpha(0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(areaPath, areaPaint);

    // Stroke line
    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      linePath.lineTo(p.dx, p.dy);
    }

    canvas.drawPath(
      linePath,
      Paint()
        ..color = FTTokens.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Dashed vertical line at end point
    final dashX = 250 * sx;
    final dashPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(dashX, 95 * sy),
      Offset(dashX, 125 * sy),
      dashPaint,
    );

    // End circle
    canvas.drawCircle(
      Offset(260 * sx, 95 * sy),
      5 * min(sx, sy),
      Paint()..color = FTTokens.accent,
    );

    // Bottom tick marks
    final tickPaint = Paint()
      ..color = const Color(0xFFF3F4F6)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 35; i++) {
      final x = i * 9 * sx;
      canvas.drawLine(
        Offset(x, 120 * sy),
        Offset(x, 125 * sy),
        tickPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
