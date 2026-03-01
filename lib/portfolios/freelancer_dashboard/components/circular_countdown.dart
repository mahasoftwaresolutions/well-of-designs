import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Circular countdown ring with a number + label centered.
/// e.g. "7 DAYS", "10 HOURS", "30 MIN"
class CircularCountdown extends StatelessWidget {
  final int value;
  final String label;
  final double progress; // 0.0 to 1.0 for the ring
  final double size;

  const CircularCountdown({
    super.key,
    required this.value,
    required this.label,
    this.progress = 0.7,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(
          progress: progress,
          ringColor: FDTokens.dark,
          trackColor: FDTokens.border,
          strokeWidth: 3,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$value',
                style: FDTokens.countdownNumber.copyWith(fontSize: size * 0.28),
              ),
              Text(
                label.toUpperCase(),
                style: FDTokens.countdownLabel.copyWith(fontSize: size * 0.12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color ringColor;
  final Color trackColor;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.ringColor,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
