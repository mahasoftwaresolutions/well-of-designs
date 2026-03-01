import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens extracted from the Freelancer Dashboard reference.
class FDTokens {
  // ── Colors ──────────────────────────────────────────────
  static const Color golden = Color(0xFFF2C94C);
  static const Color goldenLight = Color(0xFFF5DEB3);
  static const Color goldenBg = Color(0xFFFAE6A0);
  static const Color goldenMuted = Color(0xFFF7ECCD);

  static const Color dark = Color(0xFF1A1A2E);
  static const Color darkCard = Color(0xFF2A2A3C);
  static const Color darkElevated = Color(0xFF32324A);

  static const Color cream = Color(0xFFF5F0E8);
  static const Color creamLight = Color(0xFFFAF6F0);
  static const Color white = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF7A7A8A);
  static const Color textMuted = Color(0xFFAAAAAA);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnGolden = Color(0xFF1A1A1A);

  static const Color border = Color(0xFFE8E4DC);
  static const Color borderDark = Color(0xFF3A3A4E);

  // ── Typography ──────────────────────────────────────────
  static TextStyle pageTitle = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.8,
    color: textPrimary,
  );

  static TextStyle tabLabel = GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static TextStyle tabLabelInactive = GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: textSecondary,
  );

  static TextStyle sectionTitle = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.4,
    color: textPrimary,
  );

  static TextStyle cardTitle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static TextStyle cardTitleOnDark = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textOnDark,
  );

  static TextStyle cardSubtitle = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );

  static TextStyle cardSubtitleOnDark = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9999AA),
  );

  static TextStyle amount = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static TextStyle badgeText = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: textSecondary,
  );

  static TextStyle pillText = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: textPrimary,
  );

  static TextStyle countdownNumber = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: textPrimary,
  );

  static TextStyle countdownLabel = GoogleFonts.inter(
    fontSize: 8,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,
    color: textSecondary,
  );

  static TextStyle seeAll = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
    color: textSecondary,
  );

  // ── Spacing ─────────────────────────────────────────────
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 12;
  static const double spacingLg = 16;
  static const double spacingXl = 20;
  static const double spacing2Xl = 24;
  static const double spacing3Xl = 32;

  // ── Radii ───────────────────────────────────────────────
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusCard = 20;
  static const double radiusBlob = 24;
  static const double radiusFull = 999;
}
