import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A circular action button used in the top-right cutout area.
class CircleActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const CircleActionButton({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xFF222222),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: FlexCardTokens.actionButtonSize,
        height: FlexCardTokens.actionButtonSize,
        decoration: const BoxDecoration(
          color: FlexCardTokens.actionButtonBg,
          shape: BoxShape.circle,
          boxShadow: [FlexCardTokens.buttonShadow],
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
    );
  }
}
