import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A rounded progress bar with label and percentage.
class ProgressBar extends StatelessWidget {
  final double progress;
  final String label;

  const ProgressBar({
    super.key,
    required this.progress,
    this.label = 'Project progress',
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).round();

    return Column(
      children: [
        Container(
          height: FlexCardTokens.progressHeight,
          decoration: BoxDecoration(
            color: FlexCardTokens.progressTrack,
            borderRadius: BorderRadius.circular(FlexCardTokens.progressRadius),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: FlexCardTokens.progressFill,
                  borderRadius:
                      BorderRadius.circular(FlexCardTokens.progressRadius),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: FlexCardTokens.progressLabel),
            Text('$percentage%', style: FlexCardTokens.progressLabel),
          ],
        ),
      ],
    );
  }
}
