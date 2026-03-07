import 'dart:ui';
import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A single FAB action button shown in the expanded vertical menu.
class FabAction {
  final String label;
  final Widget icon;

  const FabAction({required this.label, required this.icon});
}

/// Hexagon-styled floating action button with an expandable vertical menu.
/// Matches the React reference: dark circle with hexagon icon, vertical
/// stacked action buttons that appear with scale + translate animation,
/// and a backdrop overlay.
class HexFab extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onToggle;
  final List<FabAction> actions;
  final ValueChanged<String> onActionTap;

  const HexFab({
    super.key,
    required this.isOpen,
    required this.onToggle,
    required this.actions,
    required this.onActionTap,
  });

  @override
  State<HexFab> createState() => _HexFabState();
}

class _HexFabState extends State<HexFab> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _menuAnimation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _menuAnimation = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    if (widget.isOpen) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(HexFab old) {
    super.didUpdateWidget(old);
    if (widget.isOpen != old.isOpen) {
      widget.isOpen ? _ctrl.forward() : _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: PNBTokens.fabSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Vertical stacked action buttons
          AnimatedBuilder(
            animation: _menuAnimation,
            builder: (_, child) {
              return Opacity(
                opacity: _menuAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, 32 * (1 - _menuAnimation.value)),
                  child: Transform.scale(
                    scale: lerpDouble(0.9, 1.0, _menuAnimation.value)!,
                    alignment: Alignment.bottomCenter,
                    child: IgnorePointer(
                      ignoring: !widget.isOpen,
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.actions.map((action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _FabActionButton(
                    action: action,
                    onTap: () => widget.onActionTap(action.label),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 4), // mb-4 minus the bottom padding of actions

          // Anchor FAB
          GestureDetector(
            onTap: widget.onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: PNBTokens.fabSize,
              height: PNBTokens.fabSize,
              decoration: BoxDecoration(
                color: widget.isOpen ? PNBTokens.navBgHover : PNBTokens.navBg,
                shape: BoxShape.circle,
              ),
              child: AnimatedRotation(
                turns: widget.isOpen ? 0.25 : 0, // 90 degrees
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.hexagon_outlined,
                  size: 24,
                  color: widget.isOpen ? Colors.white : PNBTokens.tooltipText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FabActionButton extends StatelessWidget {
  final FabAction action;
  final VoidCallback onTap;

  const _FabActionButton({required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: PNBTokens.fabActionSize,
        height: PNBTokens.fabActionSize,
        decoration: BoxDecoration(
          color: PNBTokens.navBg,
          shape: BoxShape.circle,
          border: Border.all(color: PNBTokens.fabBorder, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: action.icon),
      ),
    );
  }
}
