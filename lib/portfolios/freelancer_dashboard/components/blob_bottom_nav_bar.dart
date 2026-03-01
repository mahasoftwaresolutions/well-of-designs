import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Bottom navigation bar where the selected item has a raised circle
/// that visually connects (merges) with the content above via a blob shape.
class BlobBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final int centerActionIndex;

  const BlobBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.centerActionIndex = 2,
  });

  static const _icons = [
    Icons.home_rounded,
    Icons.folder_rounded,
    Icons.bolt_rounded,
    Icons.chat_bubble_outline_rounded,
    Icons.person_outline_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: CustomPaint(
        painter: _NavBarBlobPainter(
          selectedIndex: selectedIndex,
          centerIndex: centerActionIndex,
          backgroundColor: FDTokens.creamLight,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (i) {
            final isCenter = i == centerActionIndex;
            final isSelected = i == selectedIndex;

            if (isCenter) {
              return _buildCenterButton(i);
            }

            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  _icons[i],
                  size: 24,
                  color: isSelected
                      ? FDTokens.textPrimary
                      : FDTokens.textSecondary,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCenterButton(int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: FDTokens.golden,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: FDTokens.golden.withAlpha(80),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(_icons[index], size: 26, color: FDTokens.dark),
      ),
    );
  }
}

class _NavBarBlobPainter extends CustomPainter {
  final int selectedIndex;
  final int centerIndex;
  final Color backgroundColor;

  _NavBarBlobPainter({
    required this.selectedIndex,
    required this.centerIndex,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path();
    const topRadius = 20.0;
    const centerNotchRadius = 32.0;

    // Calculate center FAB position
    final centerX = size.width / 2;
    final notchTop = 4.0;

    path.moveTo(0, topRadius);
    path.quadraticBezierTo(0, 0, topRadius, 0);

    // Curve up to the center notch
    final notchLeft = centerX - centerNotchRadius - 8;
    final notchRight = centerX + centerNotchRadius + 8;

    path.lineTo(notchLeft, 0);
    // Scoop up around the center FAB
    path.quadraticBezierTo(
      centerX - centerNotchRadius + 4,
      0,
      centerX - centerNotchRadius + 8,
      -notchTop - 6,
    );
    path.quadraticBezierTo(
      centerX,
      -notchTop - 18,
      centerX + centerNotchRadius - 8,
      -notchTop - 6,
    );
    path.quadraticBezierTo(centerX + centerNotchRadius - 4, 0, notchRight, 0);

    path.lineTo(size.width - topRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, topRadius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _NavBarBlobPainter old) {
    return old.selectedIndex != selectedIndex;
  }
}
