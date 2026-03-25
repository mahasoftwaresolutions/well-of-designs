import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Compact card showing current weight with a change indicator.
class WeightCard extends StatelessWidget {
  const WeightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: FTTokens.cardWhite,
        borderRadius: BorderRadius.circular(FTTokens.cardRadiusMd),
        boxShadow: FTTokens.cardShadowSubtle,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Weight', style: FTTokens.labelSmall),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '62.5',
                    style: FTTokens.heading.copyWith(fontSize: 24),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'kg',
                    style: FTTokens.unitSmall.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: FTTokens.emeraldBg,
              borderRadius: BorderRadius.circular(FTTokens.chipRadius),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_upward,
                  size: 16,
                  color: FTTokens.emerald,
                ),
                const SizedBox(width: 4),
                Text(
                  '1.2 kg',
                  style: FTTokens.chipText.copyWith(
                    color: FTTokens.emerald,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
