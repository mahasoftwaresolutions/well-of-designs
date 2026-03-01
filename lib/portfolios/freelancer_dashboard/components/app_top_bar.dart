import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_tokens.dart';

/// The signature "App Top Bar" with back arrow, centered title, and avatar.
class FDAppTopBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color? textColor;

  const FDAppTopBar({
    super.key,
    required this.title,
    this.onBack,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: onBack ?? () => Navigator.maybePop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: (textColor ?? FDTokens.textPrimary).withAlpha(15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.chevron_left_rounded,
                color: textColor ?? FDTokens.textPrimary,
                size: 22,
              ),
            ),
          ),
          const Spacer(),

          // Title
          Text(
            title.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
              color: textColor ?? FDTokens.textPrimary,
            ),
          ),
          const Spacer(),

          // Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: FDTokens.golden,
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/100?img=12'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
