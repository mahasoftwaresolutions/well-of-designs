import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_tokens.dart';

/// Circular or pill badge showing a duration like "1 WEEK" or "4 WEEKS".
/// Supports golden, dark-bordered, and dark-filled variants.
enum WeekBadgeVariant { golden, bordered, filled }

class WeekBadge extends StatelessWidget {
  final int weeks;
  final WeekBadgeVariant variant;

  const WeekBadge({
    super.key,
    required this.weeks,
    this.variant = WeekBadgeVariant.bordered,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color fgColor;
    Color borderColor;

    switch (variant) {
      case WeekBadgeVariant.golden:
        bgColor = FDTokens.golden;
        fgColor = FDTokens.textOnGolden;
        borderColor = FDTokens.golden;
      case WeekBadgeVariant.bordered:
        bgColor = Colors.transparent;
        fgColor = FDTokens.textOnDark;
        borderColor = FDTokens.textMuted;
      case WeekBadgeVariant.filled:
        bgColor = FDTokens.golden;
        fgColor = FDTokens.textOnGolden;
        borderColor = FDTokens.golden;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$weeks',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: fgColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the badge with the "X WEEKS" text to the side.
  static Widget withLabel({
    required int weeks,
    WeekBadgeVariant variant = WeekBadgeVariant.bordered,
  }) {
    final label = weeks == 1 ? 'WEEK' : 'WEEKS';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeekBadge(weeks: weeks, variant: variant),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: variant == WeekBadgeVariant.golden
                ? FDTokens.textPrimary
                : FDTokens.textOnDark,
          ),
        ),
      ],
    );
  }
}
