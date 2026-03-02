import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Timeline card matching the React reference.
/// Golden variant: active highlight with black circular progress.
/// Dark variant: transparent bg with white/10 border, golden progress ring.
enum TimelineCardVariant { golden, dark }

class TimelineCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int weeks;
  final double progress; // 0.0 – 1.0 for the ring
  final IconData icon;
  final TimelineCardVariant variant;

  const TimelineCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.weeks,
    this.progress = 0.25,
    this.icon = Icons.bolt_rounded,
    this.variant = TimelineCardVariant.dark,
  });

  @override
  Widget build(BuildContext context) {
    final isGolden = variant == TimelineCardVariant.golden;

    // --- Colours ---
    final bgColor = isGolden ? const Color(0xFFF4C754) : Colors.transparent;
    final border = isGolden
        ? null
        : Border.all(color: Colors.white.withAlpha(25)); // white/10
    final shadow = isGolden
        ? const [
            BoxShadow(
                color: Color(0x30000000), blurRadius: 16, offset: Offset(0, 4))
          ]
        : null;

    final titleColor =
        isGolden ? const Color(0xFF111827) : Colors.white; // gray-900 / white
    final subtitleColor = isGolden
        ? Colors.black.withAlpha(128) // black/50
        : Colors.white.withAlpha(102); // white/40
    final subtitleWeight = isGolden ? FontWeight.w600 : FontWeight.w400;

    final iconBg = isGolden
        ? Colors.black.withAlpha(13) // black/5
        : Colors.white.withAlpha(13); // white/5
    final iconColor = isGolden
        ? Colors.black.withAlpha(153) // black/60
        : Colors.white.withAlpha(153); // white/60

    // Ring colours
    final ringTrack = isGolden
        ? Colors.black.withAlpha(25) // black/10
        : Colors.white.withAlpha(25); // white/10
    final ringFill =
        isGolden ? const Color(0xFF111827) : const Color(0xFFF4C754);
    final ringText = isGolden ? const Color(0xFF111827) : Colors.white;

    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24), // rounded-[1.5rem]
        border: border,
        boxShadow: shadow,
      ),
      child: Row(
        children: [
          // Icon — 40×40, rounded-xl (12px)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 16), // gap-4

          // Title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: subtitleWeight,
                    color: subtitleColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Circular progress ring — 40×40
          SizedBox(
            width: 40,
            height: 40,
            child: CustomPaint(
              painter: _MiniRingPainter(
                progress: progress,
                trackColor: ringTrack,
                fillColor: ringFill,
              ),
              child: Center(
                child: Text(
                  '$weeks',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: ringText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniRingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color fillColor;

  _MiniRingPainter({
    required this.progress,
    required this.trackColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 4) / 2; // strokeWidth = 4

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_MiniRingPainter old) =>
      old.progress != progress ||
      old.trackColor != trackColor ||
      old.fillColor != fillColor;
}
