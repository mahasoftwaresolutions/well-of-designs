import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A compact stat card (e.g. Heart Rate, Steps).
///
/// Set [isDark] for the dark variant with white text.
class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? unit;
  final bool isDark;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.unit,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? FTTokens.cardDark : FTTokens.cardWhite;
    final iconBg =
        isDark ? Colors.white.withAlpha(25) : FTTokens.surfaceLight;
    final iconColor = isDark ? Colors.white : FTTokens.accent;
    final valueColor = isDark ? Colors.white : FTTokens.textDark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(FTTokens.cardRadiusMd),
          boxShadow: FTTokens.cardShadowSubtle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBg,
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(height: 12),
            Text(label, style: FTTokens.labelSmall),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: FTTokens.valueMedium.copyWith(color: valueColor),
                ),
                if (unit != null) ...[
                  const SizedBox(width: 4),
                  Text(unit!, style: FTTokens.unitSmall),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
