import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A food item card with icon, name, meal time, and calorie count.
class MealCard extends StatelessWidget {
  final String name;
  final String time;
  final String calories;
  final IconData icon;
  final Color iconColor;

  const MealCard({
    super.key,
    required this.name,
    required this.time,
    required this.calories,
    this.icon = Icons.restaurant,
    this.iconColor = FTTokens.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FTTokens.cardWhite,
        borderRadius: BorderRadius.circular(FTTokens.cardRadiusMd),
        boxShadow: FTTokens.cardShadowSubtle,
      ),
      child: Row(
        children: [
          // Food icon placeholder
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: FTTokens.surfaceLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 28, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: FTTokens.mealName),
                const SizedBox(height: 2),
                Text(time, style: FTTokens.mealTime),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calories,
                  style: FTTokens.chipText.copyWith(fontWeight: FontWeight.w700),
                ),
                Text('kcal', style: FTTokens.barLabel),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
