import 'dart:math';
import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// GitHub-style activity heatmap grid with a colour legend.
class ActivityHeatmap extends StatelessWidget {
  const ActivityHeatmap({super.key});

  int _level(int col, int row) =>
      (sin((col * 13 + row * 7).toDouble()).abs() * 5).floor().clamp(0, 4);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: FTTokens.cardWhite,
        borderRadius: BorderRadius.circular(FTTokens.cardRadiusLg),
        boxShadow: FTTokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Activity Log', style: FTTokens.sectionTitle),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: FTTokens.accent.withAlpha(25),
                  borderRadius: BorderRadius.circular(FTTokens.chipRadius),
                ),
                child: Text('284 entries', style: FTTokens.chipText),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Grid
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(16, (col) {
                return Padding(
                  padding: EdgeInsets.only(right: col < 15 ? 6 : 0),
                  child: Column(
                    children: List.generate(7, (row) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: row < 6 ? 6 : 0),
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: FTTokens.heatmapColors[_level(col, row)],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Less',
                style: FTTokens.barLabel.copyWith(fontSize: 12),
              ),
              const SizedBox(width: 8),
              ...FTTokens.heatmapColors.map(
                (c) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: c,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'More',
                style: FTTokens.barLabel.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
