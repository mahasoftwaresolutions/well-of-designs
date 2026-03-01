import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A small capsule label like "MOBILE APP" or "WEBSITE".
class TypePill extends StatelessWidget {
  final String label;
  final bool onDark;

  const TypePill({super.key, required this.label, this.onDark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: onDark ? FDTokens.darkElevated : FDTokens.cream,
        borderRadius: BorderRadius.circular(FDTokens.radiusFull),
        border: Border.all(
          color: onDark ? FDTokens.borderDark : FDTokens.border,
          width: 1,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: FDTokens.pillText.copyWith(
          color: onDark ? FDTokens.textOnDark : FDTokens.textPrimary,
        ),
      ),
    );
  }
}
