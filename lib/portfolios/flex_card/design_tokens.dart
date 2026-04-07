import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens for the FlexCard portfolio.
class FlexCardTokens {
  // ── Colors ──────────────────────────────────────────────
  static const Color cardBg = Color(0xFFDEFA39); // Neon Lime Green
  static const Color pageBg = Color(0xFFA2A49E);
  static const Color textDark = Color(0xFF111111);
  static const Color textBody = Color(0xFF333333);
  static const Color progressTrack = Colors.white;
  static const Color progressFill = Color(0xFF111111);
  static const Color actionButtonBg = Colors.white;
  static const Color sendButtonBg = Color(0xFF111111);
  static const Color reportBorderColor = Color(0x4DC0DF21); // ~30% opacity
  static const Color avatarBg = Colors.white;

  // ── Radii ───────────────────────────────────────────────
  static const double cardRadius = 36.0;
  static const double actionButtonRadius = 25.0;
  static const double progressRadius = 5.0;
  static const double reportButtonRadius = 30.0;
  static const double phoneRadius = 48.0;

  // ── Sizes ───────────────────────────────────────────────
  static const double cardWidth = 440.0;
  static const double cardHeight = 390.0;
  static const double cutoutWidth = 140.0;
  static const double cutoutHeight = 100.0;
  static const double innerCurveSize = 36.0;
  static const double avatarSize = 56.0;
  static const double actionButtonSize = 50.0;
  static const double sendButtonSize = 56.0;
  static const double reportIconSize = 40.0;
  static const double progressHeight = 10.0;
  static const double phoneBorderWidth = 6.0;

  // ── Typography ──────────────────────────────────────────
  static TextStyle headerName = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF111827),
  );

  static TextStyle headerRole = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF374151),
  );

  static TextStyle projectTitle = GoogleFonts.inter(
    fontSize: 34,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
    color: textDark,
    height: 1.0,
  );

  static TextStyle industryLabel = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textBody,
  );

  static TextStyle industryValue = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle progressLabel = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: textDark,
  );

  static TextStyle reportLabel = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: textDark,
  );

  // ── Shadows ─────────────────────────────────────────────
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x22000000),
    blurRadius: 20,
    offset: Offset(0, 8),
  );

  static const BoxShadow buttonShadow = BoxShadow(
    color: Color(0x18000000),
    blurRadius: 8,
    offset: Offset(0, 2),
  );

  static const BoxShadow sendShadow = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 16,
    offset: Offset(0, 4),
  );
}
