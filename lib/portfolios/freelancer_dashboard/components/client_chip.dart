import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_tokens.dart';

/// A horizontal pill chip showing an icon + client name.
/// Also supports an "add" variant for the + button.
class ClientChip extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isAdd;

  const ClientChip({
    super.key,
    required this.name,
    this.icon = Icons.business_rounded,
    this.isAdd = false,
  });

  const ClientChip.add({super.key}) : name = '', icon = Icons.add, isAdd = true;

  @override
  Widget build(BuildContext context) {
    if (isAdd) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: FDTokens.cream,
          shape: BoxShape.circle,
          border: Border.all(color: FDTokens.border, width: 1),
        ),
        child: const Icon(Icons.add, size: 20, color: FDTokens.textSecondary),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: FDTokens.white,
        borderRadius: BorderRadius.circular(FDTokens.radiusFull),
        border: Border.all(color: FDTokens.border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: FDTokens.cream,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 14, color: FDTokens.textSecondary),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: FDTokens.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
