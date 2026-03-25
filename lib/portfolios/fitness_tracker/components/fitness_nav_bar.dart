import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Bottom navigation with 4 tabs and a centre floating action button.
class FitnessNavBar extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String> onTabChanged;
  final VoidCallback onFabTap;

  const FitnessNavBar({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
    required this.onFabTap,
  });

  static const _tabs = [
    _NavTab('home', Icons.home_rounded, Icons.home_outlined),
    _NavTab('analyze', Icons.insert_chart_outlined_rounded,
        Icons.insert_chart_outlined_rounded),
    _NavTab('food', Icons.lunch_dining_rounded, Icons.lunch_dining_outlined),
    _NavTab('plans', Icons.calendar_month_rounded,
        Icons.calendar_month_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Gradient fade background
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      FTTokens.background.withAlpha(0),
                      FTTokens.background,
                      FTTokens.background,
                    ],
                    stops: const [0.0, 0.3, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Nav items
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ..._tabs.take(2).map((t) => _buildTab(t)),
                const SizedBox(width: 64), // FAB spacer
                ..._tabs.skip(2).map((t) => _buildTab(t)),
              ],
            ),
          ),

          // FAB
          Positioned(
            bottom: 45,
            child: GestureDetector(
              onTap: onFabTap,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(38),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(Icons.add, size: 32, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(_NavTab tab) {
    final isActive = activeTab == tab.id;
    final color = isActive ? FTTokens.accent : FTTokens.textLight;
    final icon = isActive ? tab.activeIcon : tab.inactiveIcon;

    return GestureDetector(
      onTap: () => onTabChanged(tab.id),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 48,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 8),
            Text(
              tab.id[0].toUpperCase() + tab.id.substring(1),
              style: FTTokens.navLabel.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavTab {
  final String id;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const _NavTab(this.id, this.activeIcon, this.inactiveIcon);
}
