import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A schedule/plan item card with day label, title, and duration.
///
/// Set [isHighlighted] for the orange accent variant.
class PlanCard extends StatelessWidget {
  final String day;
  final String title;
  final String duration;
  final bool isHighlighted;

  const PlanCard({
    super.key,
    required this.day,
    required this.title,
    required this.duration,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isHighlighted ? FTTokens.accent : FTTokens.cardWhite;
    final titleColor = isHighlighted ? Colors.white : FTTokens.textDark;
    final dayColor = isHighlighted ? Colors.white70 : FTTokens.textLight;
    final durColor = isHighlighted ? Colors.white : FTTokens.textGray;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(FTTokens.cardRadiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: -12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: FTTokens.labelSmall.copyWith(color: dayColor),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: FTTokens.planTitle.copyWith(color: titleColor),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: durColor),
              const SizedBox(width: 4),
              Text(
                duration,
                style: FTTokens.barLabel.copyWith(
                  color: durColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
