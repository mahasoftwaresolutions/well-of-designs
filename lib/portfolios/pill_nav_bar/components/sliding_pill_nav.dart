import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Tab data model for the sliding pill nav.
class PillNavTab {
  final String id;
  final IconData icon;

  const PillNavTab({required this.id, required this.icon});
}

/// A dark pill-shaped navigation bar with a sliding white indicator.
/// The active tab expands to show its label, matching the React reference
/// pixel-for-pixel.
class SlidingPillNav extends StatelessWidget {
  final List<PillNavTab> tabs;
  final String activeTabId;
  final ValueChanged<String> onTabChanged;

  const SlidingPillNav({
    super.key,
    required this.tabs,
    required this.activeTabId,
    required this.onTabChanged,
  });

  int get _activeIndex => tabs.indexWhere((t) => t.id == activeTabId);

  /// Calculates the horizontal offset of the sliding pill indicator.
  /// Each inactive tab is [inactiveTabWidth] wide, so the offset equals
  /// activeIndex * inactiveTabWidth.
  double get _indicatorOffset =>
      _activeIndex * PNBTokens.inactiveTabWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PNBTokens.navPadding),
      decoration: BoxDecoration(
        color: PNBTokens.navBg,
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000), // rgba(0,0,0,0.2)
            blurRadius: 40,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Sliding white pill indicator
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            left: _indicatorOffset,
            top: 0,
            bottom: 0,
            width: PNBTokens.activeTabWidth,
            child: Container(
              decoration: BoxDecoration(
                color: PNBTokens.pillBg,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),

          // Tab buttons row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: tabs.map((tab) {
              final isActive = tab.id == activeTabId;
              return GestureDetector(
                onTap: () => onTabChanged(tab.id),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  width: isActive
                      ? PNBTokens.activeTabWidth
                      : PNBTokens.inactiveTabWidth,
                  height: PNBTokens.tabHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tab.icon,
                        size: PNBTokens.iconSize,
                        color: isActive
                            ? PNBTokens.iconActive
                            : PNBTokens.iconInactive,
                      ),
                      // Animated label
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        child: SizedBox(
                          width: isActive ? null : 0,
                          child: isActive
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    tab.id,
                                    style: PNBTokens.tabLabel,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
