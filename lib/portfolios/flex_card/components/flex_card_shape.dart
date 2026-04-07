import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// The custom background shape with a top-right cutout and inner curve.
///
/// Draws the neon lime card with:
/// - Rounded top-left section (stops before the cutout)
/// - Full-width bottom section
/// - An inverse radial curve connecting the two sections
class FlexCardShape extends StatelessWidget {
  const FlexCardShape({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: FlexCardTokens.cardWidth,
      height: FlexCardTokens.cardHeight,
      child: CustomPaint(
        painter: _FlexCardPainter(),
      ),
    );
  }
}

class _FlexCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = FlexCardTokens.cardBg
      ..style = PaintingStyle.fill;

    const r = FlexCardTokens.cardRadius;
    const cutW = FlexCardTokens.cutoutWidth;
    const cutH = FlexCardTokens.cutoutHeight;
    const curve = FlexCardTokens.innerCurveSize;

    final path = Path();

    // Start at top-left corner (after radius)
    path.moveTo(0, r);
    // Top-left rounded corner
    path.arcToPoint(
      const Offset(r, 0),
      radius: const Radius.circular(r),
      clockwise: false,
    );

    // Top edge to the start of the cutout section
    path.lineTo(size.width - cutW - curve, 0);

    // Round the corner where the top section meets the cutout
    path.arcToPoint(
      Offset(size.width - cutW, r),
      radius: const Radius.circular(r),
      clockwise: true,
    );

    // Go down to where the inner curve starts
    path.lineTo(size.width - cutW, cutH - curve);

    // Inner inverse curve (concave connection)
    path.arcToPoint(
      Offset(size.width - cutW + curve, cutH),
      radius: const Radius.circular(curve),
      clockwise: false,
    );

    // Right edge of the main body, going to the top-right rounded corner
    path.lineTo(size.width - r, cutH);
    path.arcToPoint(
      Offset(size.width, cutH + r),
      radius: const Radius.circular(r),
      clockwise: true,
    );

    // Right edge down to bottom-right corner
    path.lineTo(size.width, size.height - r);
    path.arcToPoint(
      Offset(size.width - r, size.height),
      radius: const Radius.circular(r),
      clockwise: true,
    );

    // Bottom edge
    path.lineTo(r, size.height);
    path.arcToPoint(
      Offset(0, size.height - r),
      radius: const Radius.circular(r),
      clockwise: true,
    );

    // Left edge back to start
    path.close();

    // Draw shadow
    canvas.drawShadow(path, Colors.black, 12, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
