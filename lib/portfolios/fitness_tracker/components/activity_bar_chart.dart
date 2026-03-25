import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Weekly bar chart with day labels and a "Weekly" dropdown.
class ActivityBarChart extends StatelessWidget {
  const ActivityBarChart({super.key});

  static const _heights = [0.40, 0.60, 0.45, 0.80, 0.50, 0.95, 0.65];
  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

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
              Text('Activity', style: FTTokens.sectionTitle),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: FTTokens.surfaceLight,
                  borderRadius: BorderRadius.circular(FTTokens.chipRadius),
                ),
                child: Text(
                  'Weekly',
                  style: FTTokens.barLabel.copyWith(color: FTTokens.textGray),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Bars
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (i) {
                final isHighlight = i == 5; // Saturday
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: i == 0 || i == 6 ? 0 : 4,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Bar track
                        SizedBox(
                          height: 140,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FTTokens.surfaceLight,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                alignment: Alignment.bottomCenter,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.easeOutCubic,
                                  width: double.infinity,
                                  height: constraints.maxHeight * _heights[i],
                                  decoration: BoxDecoration(
                                    color: isHighlight
                                        ? FTTokens.accent
                                        : FTTokens.cardDark,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(_days[i], style: FTTokens.barLabel),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
