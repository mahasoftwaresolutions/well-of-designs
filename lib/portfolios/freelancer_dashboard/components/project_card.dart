import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Project card matching the React reference.
/// Dark variant: bg-[#222327], golden title, border-white/10 icon.
/// Light variant: bg-white, gray title, bg-gray-50 icon.
class ProjectCard extends StatelessWidget {
  final String title;
  final String type;
  final String daysLeft;
  final double progress;
  final IconData icon;
  final bool isDark;

  const ProjectCard({
    super.key,
    required this.title,
    required this.type,
    required this.daysLeft,
    required this.progress,
    this.icon = Icons.bolt_rounded,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF222327) : Colors.white;
    final titleColor =
        isDark ? const Color(0xFFF4C754) : const Color(0xFF1F2937);
    final iconBg = isDark ? Colors.transparent : const Color(0xFFF9FAFB);
    final iconBorder = isDark ? Colors.white.withAlpha(25) : Colors.transparent;
    final iconColor = isDark ? Colors.white : const Color(0xFF9CA3AF);
    final typeColor = isDark ? Colors.white.withAlpha(153) : const Color(0xFF9CA3AF);
    final typeBorder = isDark ? Colors.white.withAlpha(51) : const Color(0xFFE5E7EB);
    final progressFill = isDark ? const Color(0xFFF4C754) : const Color(0xFF9CA3AF);
    final progressTrack = isDark ? Colors.white.withAlpha(25) : const Color(0xFFF3F4F6);
    final daysColor = isDark ? Colors.white.withAlpha(102) : const Color(0xFF9CA3AF);

    return Container(
      width: 160, // min-w-[160px]
      padding: const EdgeInsets.all(20), // p-5
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(32), // rounded-[2rem]
        border: isDark ? null : Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          if (isDark)
            const BoxShadow(
                color: Color(0x40000000), blurRadius: 20, offset: Offset(0, 4))
          else
            BoxShadow(
                color: const Color(0xFFE5E7EB).withAlpha(128),
                blurRadius: 16,
                offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon — 40×40, rounded-2xl (16px)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(16),
              border: iconBorder != Colors.transparent
                  ? Border.all(color: iconBorder)
                  : null,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(height: 16),

          // Title — 15px bold
          Text(
            title,
            style: GoogleFonts.inter(
                fontSize: 15, fontWeight: FontWeight.w700, color: titleColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),

          // Type pill — border style, 8px text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: typeBorder),
            ),
            child: Text(
              type.toUpperCase(),
              style: GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: typeColor),
            ),
          ),
          const Spacer(),

          // Progress bar — h-1 (4px)
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: progressTrack,
              borderRadius: BorderRadius.circular(999),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: progressFill,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Days left — 9px bold uppercase
          Text(
            daysLeft.toUpperCase(),
            style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: daysColor),
          ),
        ],
      ),
    );
  }
}
