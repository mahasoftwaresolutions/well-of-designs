import 'package:flutter/material.dart';
import '../design_tokens.dart';
import 'count_badge.dart';

/// Section header like "PROJECTS [4]" — uppercase title with optional count badge.
class FDSectionHeader extends StatelessWidget {
  final String title;
  final int? count;
  final bool onDark;
  final VoidCallback? onSeeAll;

  const FDSectionHeader({
    super.key,
    required this.title,
    this.count,
    this.onDark = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: FDTokens.sectionTitle.copyWith(
            color: onDark ? FDTokens.golden : FDTokens.textPrimary,
          ),
        ),
        if (count != null) ...[
          const SizedBox(width: 8),
          CountBadge(
            count: count!,
            backgroundColor: onDark ? FDTokens.darkElevated : null,
            textColor: onDark ? FDTokens.textOnDark : null,
          ),
        ],
        const Spacer(),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text('SEE ALL', style: FDTokens.seeAll),
          ),
      ],
    );
  }
}
