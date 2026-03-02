import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Payment list row matching React: circular icon + name/subtitle + amount.
class PaymentListTile extends StatelessWidget {
  final String companyName;
  final String projectName;
  final String amount;
  final IconData icon;

  const PaymentListTile({
    super.key,
    required this.companyName,
    required this.projectName,
    required this.amount,
    this.icon = Icons.more_horiz_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Icon — rounded-full, bg-gray-50
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB), // gray-50
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF9CA3AF)),
          ),
          const SizedBox(width: 12),

          // Name + project
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937), // gray-800
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  projectName,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF), // gray-400
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Amount — 14px bold
          Text(
            amount,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}
