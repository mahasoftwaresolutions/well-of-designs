import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_tokens.dart';
import 'count_badge.dart';

/// The signature blob tab bar: selected tab merges into the content area below
/// using concave corner curves, creating an organic L-shaped blob.
class BlobTabBar extends StatelessWidget {
  final List<String> labels;
  final List<int?> counts;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final Color tabBackgroundColor;
  final Color contentColor;
  final Widget child;

  const BlobTabBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.child,
    this.counts = const [],
    this.tabBackgroundColor = const Color(0xFFFAE6A0),
    this.contentColor = const Color(0xFFFAE6A0),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab row
        _buildTabRow(),
        // Content area with blob merge
        _buildContentArea(),
      ],
    );
  }

  Widget _buildTabRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(labels.length, (i) {
          final isSelected = i == selectedIndex;
          final count = i < counts.length ? counts[i] : null;

          return GestureDetector(
            onTap: () => onTabChanged(i),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    labels[i],
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? FDTokens.textPrimary
                          : FDTokens.textSecondary,
                    ),
                  ),
                  if (count != null) ...[
                    const SizedBox(width: 6),
                    CountBadge(
                      count: count,
                      backgroundColor: isSelected
                          ? FDTokens.dark
                          : FDTokens.border,
                      textColor: isSelected
                          ? FDTokens.textOnDark
                          : FDTokens.textSecondary,
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildContentArea() {
    return ClipPath(
      clipper: _BlobContentClipper(
        selectedIndex: selectedIndex,
        tabCount: labels.length,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: contentColor),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: child,
        ),
      ),
    );
  }
}

class _BlobContentClipper extends CustomClipper<Path> {
  final int selectedIndex;
  final int tabCount;

  _BlobContentClipper({required this.selectedIndex, required this.tabCount});

  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 24.0;

    // Start from top-left with a concave notch (to create the blob junction)
    // The selected tab's content connects at the top

    if (selectedIndex == 0) {
      // First tab selected: top-left is straight (connected to tab), top-right has concave notch
      path.moveTo(0, 0);
      path.lineTo(size.width - radius, 0);
      path.quadraticBezierTo(size.width, 0, size.width, radius);
    } else {
      // Non-first tab: top-left has concave notch
      path.moveTo(0, radius);
      path.quadraticBezierTo(0, 0, radius, 0);

      // Walk to the right side
      path.lineTo(size.width - radius, 0);
      path.quadraticBezierTo(size.width, 0, size.width, radius);
    }

    // Right side → bottom-right
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );

    // Bottom → bottom-left
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // Left side → back to start
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant _BlobContentClipper oldClipper) {
    return oldClipper.selectedIndex != selectedIndex;
  }
}
