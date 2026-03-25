import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens for the Neumorphic Date Strip portfolio.
class NDSTokens {
  // ── Colors ──────────────────────────────────────────────
  static const Color background = Color(0xFFEDEDED);
  static const Color pillSelected = Color(0xFFFFFFFF);
  static const Color pillUnselected = Color(0xFFF6F6F6);
  static const Color pillBorder = Color(0xFFE0E0E0);
  static const Color circleUnselected = Color(0xFFE8E8E8);
  static const Color circleGradientStart = Color(0xFFE93B3B);
  static const Color circleGradientEnd = Color(0xFFD32424);
  static const Color dayLetter = Color(0xFF909090);
  static const Color numberUnselected = Color(0xFFA3A3A3);
  static const Color triangle = Color(0xFF555555);

  // ── Sizes ───────────────────────────────────────────────
  static const double itemWidth = 84;
  static const double pillSelectedWidth = 74;
  static const double pillSelectedHeight = 116;
  static const double pillUnselectedWidth = 60;
  static const double pillUnselectedHeight = 86;
  static const double circleSelectedSize = 58;
  static const double circleUnselectedSize = 46;
  static const double pillRadius = 40;
  static const double circleTopSelected = 8;
  static const double circleTopUnselected = 6;

  // ── Shadows ─────────────────────────────────────────────
  static final List<BoxShadow> pillSelectedShadow = [
    BoxShadow(
      color: Colors.black.withAlpha(20),
      blurRadius: 35,
      offset: const Offset(0, 15),
      spreadRadius: -5,
    ),
  ];

  static final List<BoxShadow> circleSelectedShadow = [
    BoxShadow(
      color: const Color(0xFFD32424).withAlpha(102),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static final List<BoxShadow> circleUnselectedShadow = [
    BoxShadow(
      color: Colors.black.withAlpha(15),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  // ── Typography ──────────────────────────────────────────
  static TextStyle dayLetterStyle = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: dayLetter,
  );

  static TextStyle numberSelected = GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: -0.5,
  );

  static TextStyle numberUnselectedStyle = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: numberUnselected,
    letterSpacing: -0.5,
  );

  // ── Animation ───────────────────────────────────────────
  static const Duration animDuration = Duration(milliseconds: 500);
  // Matches cubic-bezier(0.34, 1.56, 0.64, 1) — spring overshoot
  static const Cubic springCurve = Cubic(0.34, 1.56, 0.64, 1.0);

  // ── Phone Frame ─────────────────────────────────────────
  static const double phoneRadius = 40;
}
