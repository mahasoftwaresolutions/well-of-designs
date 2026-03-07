import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Floating tooltip bubble that appears above the "Data" tab.
/// Shows "+6%" with a green circle badge and an arrow-up icon.
/// Includes a gentle floating animation matching the React animate-float.
class DataTooltip extends StatefulWidget {
  final bool visible;

  const DataTooltip({super.key, required this.visible});

  @override
  State<DataTooltip> createState() => _DataTooltipState();
}

class _DataTooltipState extends State<DataTooltip>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatCtrl;

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _floatCtrl,
      builder: (_, child) {
        // Float between 0 and -4px, matching CSS float keyframes
        final offset = -4.0 * Curves.easeInOut.transform(_floatCtrl.value);
        return Transform.translate(
          offset: Offset(0, offset),
          child: child,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tooltip body
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PNBTokens.navBg,
              borderRadius: BorderRadius.circular(999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x60000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('+6%', style: PNBTokens.tooltipLabel),
                const SizedBox(width: 8),
                // Green circle with arrow
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: PNBTokens.badgeGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_upward_rounded,
                    size: 12,
                    color: PNBTokens.navBg,
                  ),
                ),
              ],
            ),
          ),
          // Arrow pointing down
          CustomPaint(
            size: const Size(12, 6),
            painter: _TooltipArrowPainter(),
          ),
        ],
      ),
    );
  }
}

class _TooltipArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PNBTokens.navBg
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
