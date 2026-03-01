import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_tokens.dart';
import 'week_badge.dart';

/// A timeline row showing a project with logo, title, subtitle, and week badge.
/// Supports golden (active), dark, and light variants.
enum TimelineCardVariant { golden, dark, light }

class TimelineCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int weeks;
  final IconData icon;
  final TimelineCardVariant variant;

  const TimelineCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.weeks,
    this.icon = Icons.auto_awesome_rounded,
    this.variant = TimelineCardVariant.dark,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color titleColor;
    Color subtitleColor;
    Color iconBgColor;
    Color iconColor;
    WeekBadgeVariant badgeVariant;

    switch (variant) {
      case TimelineCardVariant.golden:
        bgColor = FDTokens.golden;
        titleColor = FDTokens.textOnGolden;
        subtitleColor = FDTokens.textOnGolden.withAlpha(160);
        iconBgColor = FDTokens.dark;
        iconColor = FDTokens.golden;
        badgeVariant = WeekBadgeVariant.golden;
      case TimelineCardVariant.dark:
        bgColor = FDTokens.dark;
        titleColor = FDTokens.textOnDark;
        subtitleColor = FDTokens.cardSubtitleOnDark.color!;
        iconBgColor = FDTokens.darkElevated;
        iconColor = FDTokens.textOnDark;
        badgeVariant = WeekBadgeVariant.bordered;
      case TimelineCardVariant.light:
        bgColor = FDTokens.white;
        titleColor = FDTokens.textPrimary;
        subtitleColor = FDTokens.textSecondary;
        iconBgColor = FDTokens.cream;
        iconColor = FDTokens.textPrimary;
        badgeVariant = WeekBadgeVariant.golden;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(FDTokens.radiusLg),
      ),
      child: Row(
        children: [
          // Logo icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(FDTokens.radiusMd),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),

          // Title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: subtitleColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Week badge
          WeekBadge.withLabel(weeks: weeks, variant: badgeVariant),
        ],
      ),
    );
  }
}
