import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Bottom navigation bar with a raised center FAB button.
class DockNavBar extends StatelessWidget {
  const DockNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SCTTokens.navBarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _navIcon(Icons.directions_car_outlined),
            _navIcon(Icons.radio_button_unchecked),
            _centerFab(),
            _navIcon(Icons.emoji_events_outlined),
            _navIcon(Icons.settings_outlined),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon) {
    return Icon(icon, size: 24, color: Colors.white);
  }

  Widget _centerFab() {
    return Transform.translate(
      offset: const Offset(0, -16),
      child: Container(
        width: SCTTokens.fabOuter,
        height: SCTTokens.fabOuter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: SCTTokens.primaryDark,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(38),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Container(
          width: SCTTokens.fabInner,
          height: SCTTokens.fabInner,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(64),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.lock_outlined,
            size: 24,
            color: SCTTokens.textDark,
          ),
        ),
      ),
    );
  }
}
