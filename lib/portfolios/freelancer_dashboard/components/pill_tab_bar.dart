import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Simple pill-style tab switcher matching the React FluidNavBar reference.
/// A rounded capsule container with a sliding white pill indicator.
class PillTabBar extends StatelessWidget {
  final List<String> labels;

  /// Small badge text for each tab (e.g. "Dec", "182", "8").
  /// Null entries = no badge for that tab.
  final List<String?> badges;

  /// Badge background colours per tab (defaults to gray-100 / yellow-400/50).
  final List<Color?> badgeBgColors;

  /// Badge text colours per tab.
  final List<Color?> badgeTextColors;

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  /// Container background (e.g. white/30 on Dashboard, #F0EEE9 on Payments).
  final Color backgroundColor;

  const PillTabBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    this.badges = const [],
    this.badgeBgColors = const [],
    this.badgeTextColors = const [],
    this.backgroundColor = const Color(0x4DFFFFFF), // white/30
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final tabWidth = constraints.maxWidth / labels.length;
        return Stack(
          children: [
            // Sliding white pill indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              left: selectedIndex * tabWidth,
              top: 0,
              bottom: 0,
              width: tabWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x10000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),

            // Tab labels
            Row(
              children: List.generate(labels.length, (i) {
                final isSelected = i == selectedIndex;
                final badge = i < badges.length ? badges[i] : null;
                final badgeBg = i < badgeBgColors.length
                    ? badgeBgColors[i]
                    : const Color(0xFFF3F4F6); // gray-100
                final badgeFg = i < badgeTextColors.length
                    ? badgeTextColors[i]
                    : const Color(0xFF6B7280); // gray-500

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onChanged(i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            labels[i],
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF111827) // black
                                  : const Color(0xFF111827)
                                      .withAlpha(153), // black/60
                            ),
                          ),
                          if (badge != null) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: badgeBg,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                badge,
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: badgeFg,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
