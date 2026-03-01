import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A small rounded pill showing a count number, used next to section headers.
/// e.g. "PROJECTS [4]"
class CountBadge extends StatelessWidget {
  final int count;
  final Color? backgroundColor;
  final Color? textColor;

  const CountBadge({
    super.key,
    required this.count,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor ?? FDTokens.border,
        borderRadius: BorderRadius.circular(FDTokens.radiusFull),
      ),
      child: Text(
        '$count',
        style: FDTokens.badgeText.copyWith(
          color: textColor ?? FDTokens.textSecondary,
        ),
      ),
    );
  }
}
