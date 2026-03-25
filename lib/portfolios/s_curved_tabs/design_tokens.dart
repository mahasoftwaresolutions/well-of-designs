import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens for the S-Curved Tabs portfolio.
class SCTTokens {
  // ── Colors ──────────────────────────────────────────────
  static const Color primary = Color(0xFFF40057);
  static const Color primaryDark = Color(0xFFC80046);
  static const Color primaryMid = Color(0xFFE80052);
  static const Color primaryDeep = Color(0xFFD6004B);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textHeading = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF64748B);
  static const Color accent = Color(0xFFE11D48);

  // ── Radii ───────────────────────────────────────────────
  static const double phoneRadius = 40;
  static const double cardRadius = 32;
  static const double listTileRadius = 24;
  static const double buttonRadius = 16;
  static const double tabCornerRadius = 24;

  // ── Sizes ───────────────────────────────────────────────
  static const double tabHeight = 56;
  static const double sCurveWidth = 60;
  static const double navBarHeight = 90;
  static const double fabOuter = 72;
  static const double fabInner = 56;

  // ── Phone Frame ─────────────────────────────────────────
  static const double phoneWidth = 375;
  static const double phoneHeight = 812;
  static const double phoneBorderWidth = 6;

  // ── Typography ──────────────────────────────────────────
  static TextStyle headerTitle = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
    color: Colors.white,
  );

  static TextStyle cardHeading = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: textHeading,
  );

  static TextStyle cardBody = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: textMuted,
  );

  static TextStyle priceText = GoogleFonts.inter(
    fontSize: 56,
    fontWeight: FontWeight.w500,
    color: textDark,
    height: 1,
  );

  static TextStyle priceSubtitle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: accent,
  );

  static TextStyle ctaButton = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: textDark,
  );

  static TextStyle tabLabel = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
    height: 1.3,
  );

  static TextStyle listTitle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle listSubtitle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );
}
