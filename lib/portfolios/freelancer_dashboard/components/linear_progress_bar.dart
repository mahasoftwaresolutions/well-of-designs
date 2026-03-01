import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Thin rounded linear progress bar with golden fill.
class FDLinearProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Color? fillColor;
  final Color? backgroundColor;
  final double height;

  const FDLinearProgressBar({
    super.key,
    required this.progress,
    this.fillColor,
    this.backgroundColor,
    this.height = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? FDTokens.border,
        borderRadius: BorderRadius.circular(FDTokens.radiusFull),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: fillColor ?? FDTokens.golden,
            borderRadius: BorderRadius.circular(FDTokens.radiusFull),
          ),
        ),
      ),
    );
  }
}
