import 'package:flutter/material.dart';
import '../design_tokens.dart';
import 'type_pill.dart';
import 'linear_progress_bar.dart';

/// Project card as seen in the Dashboard's horizontal project list.
/// Supports dark and light variants.
class ProjectCard extends StatelessWidget {
  final String title;
  final String type;
  final String daysLeft;
  final double progress;
  final IconData icon;
  final bool isDark;

  const ProjectCard({
    super.key,
    required this.title,
    required this.type,
    required this.daysLeft,
    required this.progress,
    this.icon = Icons.edit_rounded,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? FDTokens.dark : FDTokens.white,
        borderRadius: BorderRadius.circular(FDTokens.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isDark ? FDTokens.darkElevated : FDTokens.cream,
              borderRadius: BorderRadius.circular(FDTokens.radiusSm),
            ),
            child: Icon(
              icon,
              size: 18,
              color: isDark ? FDTokens.textOnDark : FDTokens.textPrimary,
            ),
          ),
          const SizedBox(height: 14),

          // Title
          Text(
            title,
            style: isDark ? FDTokens.cardTitleOnDark : FDTokens.cardTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Type pill
          TypePill(label: type, onDark: isDark),
          const Spacer(),

          // Progress
          FDLinearProgressBar(
            progress: progress,
            fillColor: isDark ? FDTokens.golden : FDTokens.textSecondary,
            backgroundColor: isDark ? FDTokens.darkElevated : FDTokens.border,
          ),
          const SizedBox(height: 6),

          // Days left
          Text(
            daysLeft.toUpperCase(),
            style: FDTokens.pillText.copyWith(
              color: isDark ? FDTokens.textMuted : FDTokens.textSecondary,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
