import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_tokens.dart';

/// Monthly stat column: month label on top, amount below.
/// The active month can be highlighted.
class StatCard extends StatelessWidget {
  final String month;
  final String amount;
  final bool isActive;

  const StatCard({
    super.key,
    required this.month,
    required this.amount,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: isActive
          ? BoxDecoration(
              color: FDTokens.goldenMuted,
              borderRadius: BorderRadius.circular(FDTokens.radiusSm),
            )
          : null,
      child: Column(
        children: [
          Text(
            month.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: FDTokens.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isActive ? FDTokens.textPrimary : FDTokens.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
