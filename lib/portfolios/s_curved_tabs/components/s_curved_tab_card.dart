import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A card with an S-curved tab bar at the bottom.
///
/// The active tab merges seamlessly with the white card above via an organic
/// cubic bezier S-curve. The inactive tab shows the [inactiveTabColor].
class SCurvedTabCard extends StatelessWidget {
  final Animation<double> animation;
  final int activeIndex;
  final ValueChanged<int> onTabChanged;
  final List<String> tabLabels;
  final Widget child;
  final Color inactiveTabColor;

  const SCurvedTabCard({
    super.key,
    required this.animation,
    required this.activeIndex,
    required this.onTabChanged,
    required this.tabLabels,
    required this.child,
    this.inactiveTabColor = SCTTokens.primaryDark,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Stack(
          children: [
            // Background: custom painted card + S-curved tabs
            Positioned.fill(
              child: CustomPaint(
                painter: _SCurvedCardPainter(
                  progress: animation.value,
                  tabHeight: SCTTokens.tabHeight,
                  cardRadius: SCTTokens.cardRadius,
                  curveRadius: SCTTokens.tabCornerRadius,
                  curveWidth: SCTTokens.sCurveWidth,
                  activeColor: SCTTokens.cardWhite,
                  inactiveColor: inactiveTabColor,
                ),
              ),
            ),

            // Foreground: content + tab labels
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Card content
                child,

                // Tab labels
                SizedBox(
                  height: SCTTokens.tabHeight,
                  child: Row(
                    children: List.generate(tabLabels.length, (i) {
                      final isActive = i == activeIndex;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => onTabChanged(i),
                          behavior: HitTestBehavior.opaque,
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: SCTTokens.tabLabel.copyWith(
                                color: isActive
                                    ? SCTTokens.textDark
                                    : Colors.white,
                              ),
                              child: Text(
                                tabLabels[i],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// Paints the white card background and S-curved tab shapes.
///
/// [progress] interpolates from 0.0 (left tab active) to 1.0 (right tab active).
/// Both tab paths extend upward behind the card area; the white card rectangle
/// is painted last to cleanly cover the overlap.
class _SCurvedCardPainter extends CustomPainter {
  final double progress;
  final double tabHeight;
  final double cardRadius;
  final double curveRadius;
  final double curveWidth;
  final Color activeColor;
  final Color inactiveColor;

  _SCurvedCardPainter({
    required this.progress,
    required this.tabHeight,
    required this.cardRadius,
    required this.curveRadius,
    required this.curveWidth,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final tabTop = size.height - tabHeight;
    final m = w / 2;
    final r = curveRadius;
    final c = curveWidth;

    // Active tab: left side low when progress=0, high when progress=1
    final activeLeftY = tabHeight * (1 - progress);
    final activeRightY = tabHeight * progress;

    // Inactive tab: opposite
    final inactiveLeftY = tabHeight * progress;
    final inactiveRightY = tabHeight * (1 - progress);

    // Draw inactive tab (behind)
    canvas.drawPath(
      _tabPath(w, tabTop, m, r, c, inactiveLeftY, inactiveRightY),
      Paint()..color = inactiveColor,
    );

    // Draw active tab with subtle shadow
    final activePath =
        _tabPath(w, tabTop, m, r, c, activeLeftY, activeRightY);
    canvas.drawShadow(activePath, Colors.black, 8, false);
    canvas.drawPath(activePath, Paint()..color = activeColor);

    // Draw white card rectangle on top — covers the upward tab extensions
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        0,
        0,
        w,
        tabTop,
        topLeft: Radius.circular(cardRadius),
        topRight: Radius.circular(cardRadius),
      ),
      Paint()..color = activeColor,
    );
  }

  /// Builds a tab path that extends from the top of the widget down to the
  /// tab area, with an S-curve connecting [leftY] and [rightY].
  Path _tabPath(
    double w,
    double tabTop,
    double m,
    double r,
    double c,
    double leftY,
    double rightY,
  ) {
    final absLeftY = tabTop + leftY;
    final absRightY = tabTop + rightY;

    return Path()
      ..moveTo(0, 0)
      ..lineTo(0, absLeftY - r)
      ..arcToPoint(
        Offset(r, absLeftY),
        radius: Radius.circular(r),
        clockwise: false,
      )
      ..lineTo(m - c / 2, absLeftY)
      ..cubicTo(m, absLeftY, m, absRightY, m + c / 2, absRightY)
      ..lineTo(w - r, absRightY)
      ..arcToPoint(
        Offset(w, absRightY - r),
        radius: Radius.circular(r),
        clockwise: false,
      )
      ..lineTo(w, 0)
      ..close();
  }

  @override
  bool shouldRepaint(_SCurvedCardPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
