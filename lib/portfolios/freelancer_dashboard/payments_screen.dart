import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/pill_tab_bar.dart';
import 'components/timeline_card.dart';
import 'components/client_chip.dart';

/// Payments screen matching the React PaymentsScreen exactly.
/// Stack layout: light top section + absolute-positioned dark bottom.
class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  int _tabIndex = 0; // "Paid" selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          // ── Light top section ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar: ← PAYMENTS avatar
                _buildTopBar(),
                const SizedBox(height: 32),

                // Pill tab bar
                PillTabBar(
                  labels: const ['Paid', 'Unpaid'],
                  badges: const ['8', '2'],
                  badgeBgColors: const [
                    Color(0xFFF3F4F6), // gray-100
                    Color(0xFFFFFFFF), // white
                  ],
                  badgeTextColors: const [
                    Color(0xFF6B7280), // gray-500
                    Color(0xFF9CA3AF), // gray-400
                  ],
                  selectedIndex: _tabIndex,
                  onChanged: (i) => setState(() => _tabIndex = i),
                  backgroundColor: const Color(0xFFF0EEE9),
                ),
                const SizedBox(height: 24),

                // Last 3 Months header + more button
                Row(
                  children: [
                    Text(
                      'Last 3 Months',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0EEE9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.more_horiz_rounded,
                          size: 18, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Monthly stats: Oct | Nov | Dec
                _buildMonthlyStats(),
              ],
            ),
          ),

          // ── Dark bottom section (absolute positioned) ─────────
          Positioned(
            top: 380,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF222327),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(40)),
              ),
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timelines header
                    _sectionHeader('Timelines', '3',
                        titleColor: Colors.white.withAlpha(178),
                        badgeBg: Colors.white.withAlpha(25),
                        badgeText: Colors.white.withAlpha(204)),
                    const SizedBox(height: 24),

                    // Timeline cards
                    const TimelineCard(
                      title: 'Tate Design Studio',
                      subtitle: 'Travel Planning App UI',
                      weeks: 1,
                      progress: 0.25,
                      icon: Icons.bolt_rounded,
                      variant: TimelineCardVariant.golden,
                    ),
                    const SizedBox(height: 12),
                    const TimelineCard(
                      title: 'Framely',
                      subtitle: 'Company Landing UI',
                      weeks: 4,
                      progress: 0.60,
                      icon: Icons.folder_rounded,
                      variant: TimelineCardVariant.dark,
                    ),
                    const SizedBox(height: 24),

                    // Clients header (golden text)
                    _sectionHeader('Clients', '4',
                        titleColor: const Color(0xFFF4C754),
                        badgeBg: Colors.transparent,
                        badgeText: const Color(0xFFF4C754),
                        badgeBorder: const Color(0xFFF4C754)),
                    const SizedBox(height: 16),

                    // Client chips
                    const Row(
                      children: [
                        ClientChip.add(),
                        SizedBox(width: 12),
                        ClientChip(name: 'Rubion'),
                        SizedBox(width: 12),
                        ClientChip(name: 'Tate'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        // Back button
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(Icons.chevron_left_rounded,
                size: 24, color: Colors.black.withAlpha(204)),
          ),
        ),
        const Spacer(),
        Text(
          'PAYMENTS',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
            color: Colors.black.withAlpha(204),
          ),
        ),
        const Spacer(),
        // Avatar (no badge on Payments)
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFD1D5DB),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          clipBehavior: Clip.antiAlias,
          child: const Image(
            image: NetworkImage('https://i.pravatar.cc/100?img=12'),
            fit: BoxFit.cover,
            errorBuilder: _avatarFallback,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyStats() {
    return Row(
      children: [
        _statColumn('Oct', '\$2600.00'),
        _divider(),
        _statColumn('Nov', '\$3200.00'),
        _divider(),
        _statColumn('Dec', '\$2100.00'),
      ],
    );
  }

  Widget _statColumn(String month, String amount) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            month.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _divider() {
    return Container(
      width: 1,
      height: 32,
      color: const Color(0xFFE5E7EB), // gray-200
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _sectionHeader(
    String title,
    String count, {
    required Color titleColor,
    required Color badgeBg,
    required Color badgeText,
    Color? badgeBorder,
  }) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
            color: titleColor,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: badgeBg,
            shape: BoxShape.circle,
            border: badgeBorder != null
                ? Border.all(color: badgeBorder)
                : null,
          ),
          child: Center(
            child: Text(
              count,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: badgeText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _avatarFallback(
      BuildContext context, Object error, StackTrace? stack) {
    return Container(color: const Color(0xFFD1D5DB));
  }
}
