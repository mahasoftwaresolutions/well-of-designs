import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens extracted from the Pill Nav Bar reference.
class PNBTokens {
  // ── Colors ──────────────────────────────────────────────
  static const Color navBg = Color(0xFF1D1D1F);
  static const Color navBgHover = Color(0xFF2C2C2E);
  static const Color pillBg = Color(0xFFE5E5EA);
  static const Color iconInactive = Color(0xFF8E8E93);
  static const Color iconActive = Color(0xFF1D1D1F);
  static const Color textActive = Color(0xFF1D1D1F);
  static const Color tooltipText = Color(0xFFA1A1A6);
  static const Color badgeGreen = Color(0xFF5EC28E);
  static const Color fabBorder = Color(0xFF2A2A2C);
  static const Color scanBlue = Color(0xFF4B89A8);
  static const Color recordRed = Color(0xFFD63F3F);
  static const Color viewTeal = Color(0xFF3B9F9F);
  static const Color phoneBg = Color(0xFFD7D7D9);
  static const Color phoneBorder = Color(0xFF2A2A2C);
  static const Color overlayColor = Color(0xFF0C0C0E);
  static const Color contentIcon = Color(0xFF9CA3AF); // gray-400
  static const Color contentText = Color(0xFF6B7280); // gray-500
  static const Color contentTextLight = Color(0xFF9CA3AF); // gray-400

  // ── Typography ──────────────────────────────────────────
  static TextStyle tabLabel = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: textActive,
  );

  static TextStyle tooltipLabel = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: tooltipText,
  );

  static TextStyle contentMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: contentText,
  );

  static TextStyle contentSmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: contentTextLight,
  );

  // ── Sizes ─────────────────────────────────────────────
  static const double navPadding = 6; // p-1.5 = 6px
  static const double tabHeight = 48;
  static const double activeTabWidth = 110;
  static const double inactiveTabWidth = 48;
  static const double fabSize = 60;
  static const double fabActionSize = 52;
  static const double iconSize = 20;
  static const double navGap = 12; // gap-3

  // ── Phone Frame ───────────────────────────────────────
  static const double phoneWidth = 390;
  static const double phoneHeight = 844;
  static const double phoneBorderRadius = 48; // 3rem
  static const double phoneBorderWidth = 6;
}
