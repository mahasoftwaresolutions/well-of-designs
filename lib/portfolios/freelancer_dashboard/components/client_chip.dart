import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Client chip matching the React reference (on dark #222327 background).
/// Add variant: circular bg-white/10, + icon.
/// Named variant: pill bg-white/5, border-white/10, white text, no icon.
class ClientChip extends StatelessWidget {
  final String name;
  final bool isAdd;

  const ClientChip({
    super.key,
    required this.name,
    this.isAdd = false,
  });

  const ClientChip.add({super.key})
      : name = '',
        isAdd = true;

  @override
  Widget build(BuildContext context) {
    if (isAdd) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25), // bg-white/10
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, size: 20, color: Colors.white),
      );
    }

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13), // bg-white/5
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withAlpha(25)), // white/10
      ),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
