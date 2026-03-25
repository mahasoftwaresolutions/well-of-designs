import 'dart:ui';
import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Visual style configuration for [DatePill].
///
/// Encapsulates all colors, sizes, and decorations so the same pill
/// structure can render in different themes (neumorphic, fitness, etc.).
class DatePillStyle {
  final Color pillSelectedColor;
  final Color pillUnselectedColor;
  final BoxBorder? pillUnselectedBorder;
  final List<BoxShadow> pillSelectedShadow;
  final List<BoxShadow> pillUnselectedShadow;
  final BoxDecoration circleSelectedDecoration;
  final BoxDecoration circleUnselectedDecoration;
  final TextStyle numberSelectedStyle;
  final TextStyle numberUnselectedStyle;
  final TextStyle dayLetterStyle;
  final Color triangleColor;
  final double itemWidth;
  final double pillSelectedWidth;
  final double pillSelectedHeight;
  final double pillUnselectedWidth;
  final double pillUnselectedHeight;
  final double circleSelectedSize;
  final double circleUnselectedSize;
  final double circleTopSelected;
  final double circleTopUnselected;
  final double pillRadius;
  final Duration animDuration;
  final Curve animCurve;

  const DatePillStyle({
    required this.pillSelectedColor,
    required this.pillUnselectedColor,
    this.pillUnselectedBorder,
    required this.pillSelectedShadow,
    this.pillUnselectedShadow = const [],
    required this.circleSelectedDecoration,
    required this.circleUnselectedDecoration,
    required this.numberSelectedStyle,
    required this.numberUnselectedStyle,
    required this.dayLetterStyle,
    required this.triangleColor,
    this.itemWidth = 84,
    this.pillSelectedWidth = 74,
    this.pillSelectedHeight = 116,
    this.pillUnselectedWidth = 60,
    this.pillUnselectedHeight = 86,
    this.circleSelectedSize = 58,
    this.circleUnselectedSize = 46,
    this.circleTopSelected = 8,
    this.circleTopUnselected = 6,
    this.pillRadius = 40,
    this.animDuration = const Duration(milliseconds: 500),
    this.animCurve = const Cubic(0.34, 1.56, 0.64, 1.0),
  });

  /// Original neumorphic style: white pill, red gradient circle.
  factory DatePillStyle.neumorphic() => DatePillStyle(
        pillSelectedColor: NDSTokens.pillSelected,
        pillUnselectedColor: NDSTokens.pillUnselected,
        pillUnselectedBorder: Border.all(color: NDSTokens.pillBorder),
        pillSelectedShadow: NDSTokens.pillSelectedShadow,
        circleSelectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              NDSTokens.circleGradientStart,
              NDSTokens.circleGradientEnd,
            ],
          ),
          boxShadow: NDSTokens.circleSelectedShadow,
        ),
        circleUnselectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: NDSTokens.circleUnselected,
          border: Border.all(color: NDSTokens.pillBorder),
          boxShadow: NDSTokens.circleUnselectedShadow,
        ),
        numberSelectedStyle: NDSTokens.numberSelected,
        numberUnselectedStyle: NDSTokens.numberUnselectedStyle,
        dayLetterStyle: NDSTokens.dayLetterStyle,
        triangleColor: NDSTokens.triangle,
      );
}

/// A single date item in the strip: triangle indicator, day letter, and
/// pill with an inner circle showing the day number.
///
/// [progress] drives the visual state: 0.0 = fully unselected,
/// 1.0 = fully selected. The parent owns the [AnimationController] and
/// computes progress for each pill, guaranteeing perfect sync between
/// the selecting and deselecting pills.
///
/// Set [showTriangle] to `false` when using a fixed external indicator
/// (e.g. in [ScrollDateStrip]).
class DatePill extends StatelessWidget {
  final String dayLetter;
  final int dayNumber;
  final double progress;
  final VoidCallback onTap;
  final DatePillStyle style;
  final bool showTriangle;

  const DatePill({
    super.key,
    required this.dayLetter,
    required this.dayNumber,
    required this.progress,
    required this.onTap,
    required this.style,
    this.showTriangle = true,
  });

  @override
  Widget build(BuildContext context) {
    final t = progress;
    final ct = t.clamp(0.0, 1.0);

    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: style.itemWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Triangle indicator (hidden when parent provides a fixed one)
              if (showTriangle) ...[
                SizedBox(
                  height: 20,
                  child: Opacity(
                    opacity: ct,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TriangleIndicator(color: style.triangleColor),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // Day letter (static)
              SizedBox(
                height: 24,
                child: Center(
                  child: Text(dayLetter, style: style.dayLetterStyle),
                ),
              ),
              const SizedBox(height: 16),

              // Pill + circle
              SizedBox(
                height: 130,
                child: Center(child: _buildPill(t, ct)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPill(double t, double ct) {
    final s = style;

    // ── Sizes (allow overshoot for the bouncy feel) ──────────
    final pillW = lerpDouble(s.pillUnselectedWidth, s.pillSelectedWidth, t)!;
    final pillH = lerpDouble(s.pillUnselectedHeight, s.pillSelectedHeight, t)!;
    final circleSize =
        lerpDouble(s.circleUnselectedSize, s.circleSelectedSize, t)!;
    final circleTop =
        lerpDouble(s.circleTopUnselected, s.circleTopSelected, t)!;

    // ── Pill colour (clamped) ────────────────────────────────
    final pillColor =
        Color.lerp(s.pillUnselectedColor, s.pillSelectedColor, ct)!;

    // ── Pill border — fade out during first half ─────────────
    final borderOpacity = (1.0 - ct * 2).clamp(0.0, 1.0);
    BoxBorder? pillBorder;
    if (s.pillUnselectedBorder != null && borderOpacity > 0) {
      final base = s.pillUnselectedBorder! as Border;
      final baseAlpha = (base.top.color.a * 255).round();
      pillBorder = Border.all(
        color: base.top.color.withAlpha((baseAlpha * borderOpacity).round()),
        width: base.top.width,
      );
    }

    // ── Pill shadow — lerp alpha ─────────────────────────────
    final pillShadows = _lerpShadows(
      s.pillUnselectedShadow,
      s.pillSelectedShadow,
      ct,
    );

    // ── Circle decoration — crossfade gradient/solid ─────────
    final fadeIn = ((ct - 0.5) * 2).clamp(0.0, 1.0);
    final fadeOut = (1.0 - ct * 2).clamp(0.0, 1.0);

    final circleDecoration = ct > 0.5
        ? s.circleSelectedDecoration.copyWith(
            boxShadow: s.circleSelectedDecoration.boxShadow
                ?.map((sh) {
                  final a = (sh.color.a * 255 * fadeIn).round();
                  return BoxShadow(
                    color: sh.color.withAlpha(a),
                    blurRadius: sh.blurRadius,
                    offset: sh.offset,
                    spreadRadius: sh.spreadRadius,
                  );
                })
                .toList(),
          )
        : s.circleUnselectedDecoration.copyWith(
            boxShadow: s.circleUnselectedDecoration.boxShadow
                ?.map((sh) {
                  final a = (sh.color.a * 255 * fadeOut).round();
                  return BoxShadow(
                    color: sh.color.withAlpha(a),
                    blurRadius: sh.blurRadius,
                    offset: sh.offset,
                    spreadRadius: sh.spreadRadius,
                  );
                })
                .toList(),
            border: s.circleUnselectedDecoration.border != null
                ? Border.all(
                    color: NDSTokens.pillBorder.withAlpha(
                      (NDSTokens.pillBorder.a * 255 * fadeOut).round(),
                    ),
                  )
                : null,
          );

    // ── Text style (clamped lerp) ────────────────────────────
    final textStyle =
        TextStyle.lerp(s.numberUnselectedStyle, s.numberSelectedStyle, ct)!;

    return Container(
      width: pillW,
      height: pillH,
      decoration: BoxDecoration(
        color: pillColor,
        borderRadius: BorderRadius.circular(s.pillRadius),
        border: pillBorder,
        boxShadow: pillShadows,
      ),
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: circleTop),
        width: circleSize,
        height: circleSize,
        decoration: circleDecoration,
        alignment: Alignment.center,
        child: Text('$dayNumber', style: textStyle),
      ),
    );
  }

  List<BoxShadow> _lerpShadows(
    List<BoxShadow> a,
    List<BoxShadow> b,
    double t,
  ) {
    if (a.isEmpty && b.isEmpty) return const [];
    final len = a.length > b.length ? a.length : b.length;
    return List.generate(len, (i) {
      final from =
          i < a.length ? a[i] : const BoxShadow(color: Colors.transparent);
      final to =
          i < b.length ? b[i] : const BoxShadow(color: Colors.transparent);
      return BoxShadow.lerp(from, to, t)!;
    });
  }
}

/// Small downward-pointing triangle drawn with CustomPaint.
class TriangleIndicator extends StatelessWidget {
  final Color color;

  const TriangleIndicator({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(11, 9),
      painter: _TrianglePainter(color),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) =>
      oldDelegate.color != color;
}
