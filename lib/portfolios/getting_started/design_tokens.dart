import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens for the Getting Started portfolio.
/// Each new portfolio folder should have its own design_tokens.dart
/// with project-specific values.
class GettingStartedTokens {
  // ── Colors ──────────────────────────────────────────────
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF00D9A6);
  static const Color accent = Color(0xFFFF6B9D);
  static const Color warning = Color(0xFFFFB84D);
  static const Color info = Color(0xFF4DA6FF);

  static const Color surfaceDark = Color(0xFF0D0D12);
  static const Color surfaceCard = Color(0xFF16161F);
  static const Color surfaceElevated = Color(0xFF1E1E2A);
  static const Color borderSubtle = Color(0xFF2A2A38);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFAAAAAA);
  static const Color textMuted = Color(0xFF666680);

  static const List<Color> palette = [
    primary,
    secondary,
    accent,
    warning,
    info,
  ];

  static const List<String> paletteNames = [
    'Primary',
    'Secondary',
    'Accent',
    'Warning',
    'Info',
  ];

  // ── Typography ──────────────────────────────────────────
  static TextStyle displayLarge = GoogleFonts.outfit(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: textPrimary,
    letterSpacing: -1.5,
  );

  static TextStyle displayMedium = GoogleFonts.outfit(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle headlineLarge = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static TextStyle headlineMedium = GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.6,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textMuted,
  );

  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle mono = GoogleFonts.jetBrainsMono(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: secondary,
  );

  // ── Spacing ─────────────────────────────────────────────
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacing2Xl = 48;

  // ── Radii ───────────────────────────────────────────────
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusFull = 999;
}
