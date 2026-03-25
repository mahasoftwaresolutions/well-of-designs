import 'package:flutter/material.dart';
import '../design_tokens.dart';
import 'sliding_pill_nav.dart';
import 'hex_fab.dart';
import 'data_tooltip.dart';

/// A unified navigation component that combines the sliding pill nav bar,
/// hexagon FAB, and a floating tooltip into a single reusable widget.
///
/// The tooltip is automatically positioned above the tab matching
/// [tooltipTabId]. Pass `null` to hide the tooltip.
class FabbyNavBarWithTip extends StatelessWidget {
  final List<PillNavTab> tabs;
  final String activeTabId;
  final ValueChanged<String> onTabChanged;
  final bool isFabOpen;
  final VoidCallback onFabToggle;
  final List<FabAction> fabActions;
  final ValueChanged<String> onFabAction;

  /// The tab id above which to show the tooltip. `null` hides it.
  final String? tooltipTabId;

  const FabbyNavBarWithTip({
    super.key,
    required this.tabs,
    required this.activeTabId,
    required this.onTabChanged,
    required this.isFabOpen,
    required this.onFabToggle,
    required this.fabActions,
    required this.onFabAction,
    this.tooltipTabId,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Nav bar row — establishes the Stack's intrinsic size
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SlidingPillNav(
              tabs: tabs,
              activeTabId: activeTabId,
              onTabChanged: onTabChanged,
            ),
            const SizedBox(width: PNBTokens.navGap),
            HexFab(
              isOpen: isFabOpen,
              onToggle: onFabToggle,
              actions: fabActions,
              onActionTap: onFabAction,
            ),
          ],
        ),

        // Tooltip anchored above the target tab
        if (tooltipTabId != null)
          Positioned(
            bottom: PNBTokens.tabHeight + PNBTokens.navPadding * 2 + 12,
            left: _tooltipLeft(tooltipTabId!),
            child: FractionalTranslation(
              translation: const Offset(-0.5, 0),
              child: DataTooltip(visible: true),
            ),
          ),
      ],
    );
  }

  /// Calculates the left offset to center the tooltip above the given tab.
  ///
  /// When a tab is active it expands to [activeTabWidth]; all others are
  /// [inactiveTabWidth]. We find the target tab's center by summing the
  /// widths of preceding tabs plus half the target tab's own width.
  double _tooltipLeft(String tabId) {
    final targetIndex = tabs.indexWhere((t) => t.id == tabId);
    if (targetIndex < 0) return 0;

    final isTargetActive = tabId == activeTabId;
    double left = PNBTokens.navPadding;

    for (int i = 0; i < targetIndex; i++) {
      left += tabs[i].id == activeTabId
          ? PNBTokens.activeTabWidth
          : PNBTokens.inactiveTabWidth;
    }

    // Add half the target tab's width to reach its center
    left += (isTargetActive
            ? PNBTokens.activeTabWidth
            : PNBTokens.inactiveTabWidth) /
        2;

    return left;
  }
}
