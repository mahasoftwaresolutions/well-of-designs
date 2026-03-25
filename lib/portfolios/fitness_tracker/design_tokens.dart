import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens for the Fitness Tracker portfolio.
class FTTokens {
  // ── Colors ──────────────────────────────────────────────
  static const Color background = Color(0xFFF4F5F9);
  static const Color accent = Color(0xFFF58220);
  static const Color textDark = Color(0xFF111827);
  static const Color textGray = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF111827);
  static const Color surfaceLight = Color(0xFFF4F5F9);
  static const Color emerald = Color(0xFF10B981);
  static const Color emeraldBg = Color(0xFFECFDF5);

  // Heatmap levels
  static const List<Color> heatmapColors = [
    Color(0xFFF4F5F9),
    Color(0xFFFDE9D2),
    Color(0xFFFBC694),
    Color(0xFFF8A356),
    Color(0xFFF58220),
  ];

  // ── Radii ───────────────────────────────────────────────
  static const double cardRadiusLg = 32;
  static const double cardRadiusMd = 24;
  static const double chipRadius = 999;
  static const double phoneRadius = 48;

  // ── Shadows ─────────────────────────────────────────────
  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withAlpha(20),
      blurRadius: 40,
      offset: const Offset(0, 12),
      spreadRadius: -12,
    ),
  ];

  static final List<BoxShadow> cardShadowSubtle = [
    BoxShadow(
      color: Colors.black.withAlpha(13),
      blurRadius: 20,
      offset: const Offset(0, 4),
      spreadRadius: -10,
    ),
  ];

  // ── Typography ──────────────────────────────────────────
  static TextStyle dateLabel = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: textGray,
    letterSpacing: 0.3,
  );

  static TextStyle heading = GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: textDark,
    letterSpacing: -0.5,
  );

  static TextStyle sectionTitle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: textDark,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: textLight,
  );

  static TextStyle valueLarge = GoogleFonts.inter(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    color: textDark,
    letterSpacing: -1,
    height: 1,
  );

  static TextStyle valueMedium = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: textDark,
  );

  static TextStyle unit = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: textDark,
  );

  static TextStyle unitSmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textLight,
  );

  static TextStyle chipText = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: accent,
  );

  static TextStyle navLabel = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static TextStyle chartAnnotation = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: textGray,
    height: 1.3,
  );

  static TextStyle chartValue = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: accent,
  );

  static TextStyle barLabel = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textLight,
  );

  static TextStyle modalTitle = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: textDark,
  );

  static TextStyle mealName = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textDark,
  );

  static TextStyle mealTime = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: textLight,
  );

  static TextStyle planTitle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: textDark,
  );
}
