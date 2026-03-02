import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/pill_tab_bar.dart';
import 'components/circular_countdown.dart';
import 'components/project_card.dart';
import 'components/payment_list_tile.dart';

/// Dashboard screen matching the React DashboardScreen exactly.
/// Stack layout: yellow top section + absolute-positioned white bottom.
class DashboardScreen extends StatefulWidget {
  final VoidCallback? onPaymentsSeeAll;
  const DashboardScreen({super.key, this.onPaymentsSeeAll});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _tabIndex = 0; // Stats selected by default (matching React)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4C754),
      body: Stack(
        children: [
          // ── Yellow top section ─────────────────────────────────
          Column(
            children: [
              Container(
                color: const Color(0xFFF4C754),
                padding: const EdgeInsets.fromLTRB(24, 56, 24, 64),
                child: Column(
                  children: [
                    // Top bar: ← DASHBOARD avatar
                    _buildTopBar(),
                    const SizedBox(height: 32),

                    // Pill tab bar
                    PillTabBar(
                      labels: const ['Stats', 'Projects'],
                      badges: const ['Dec', '182'],
                      badgeBgColors: const [
                        Color(0xFFF3F4F6), // gray-100
                        Color(0x80F4C754), // yellow-400/50
                      ],
                      badgeTextColors: const [
                        Color(0xFF6B7280), // gray-500
                        Color(0xFF713F12), // yellow-900
                      ],
                      selectedIndex: _tabIndex,
                      onChanged: (i) => setState(() => _tabIndex = i),
                      backgroundColor:
                          Colors.white.withAlpha(77), // white/30
                    ),
                    const SizedBox(height: 32),

                    // White card: Left Working Time
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x08000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LEFT WORKING TIME',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircularCountdown(
                                  value: 7,
                                  label: 'Days',
                                  progress: 0.60,
                                  size: 48),
                              CircularCountdown(
                                  value: 10,
                                  label: 'Hours',
                                  progress: 0.40,
                                  size: 48),
                              CircularCountdown(
                                  value: 30,
                                  label: 'Min',
                                  progress: 0.80,
                                  size: 48),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── White bottom section (absolute positioned) ────────
          Positioned(
            top: 380,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Projects header
                    _sectionHeader('Projects', '4'),
                    const SizedBox(height: 16),

                    // Horizontal project cards
                    SizedBox(
                      height: 210,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        children: const [
                          ProjectCard(
                            title: 'Travel Planning',
                            type: 'Mobile App',
                            daysLeft: '7 Days Left',
                            progress: 0.65,
                            icon: Icons.bolt_rounded,
                            isDark: true,
                          ),
                          SizedBox(width: 16),
                          ProjectCard(
                            title: 'Company Landing',
                            type: 'Website',
                            daysLeft: '14 Days Left',
                            progress: 0.30,
                            icon: Icons.folder_rounded,
                            isDark: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Payments header
                    Text(
                      'PAYMENTS',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                        color: const Color(0xFF111827).withAlpha(178),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Payment list
                    const PaymentListTile(
                      companyName: 'Tate Design Studio',
                      projectName: 'Travel Planning App UI',
                      amount: '\$400.00',
                      icon: Icons.more_horiz_rounded,
                    ),
                    const PaymentListTile(
                      companyName: 'Framely',
                      projectName: 'Company Landing UI',
                      amount: '\$1500.00',
                      icon: Icons.folder_rounded,
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
          'DASHBOARD',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
            color: Colors.black.withAlpha(204),
          ),
        ),
        const Spacer(),
        // Avatar
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFD1D5DB),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              const Positioned.fill(
                child: Image(
                  image: NetworkImage('https://i.pravatar.cc/100?img=12'),
                  fit: BoxFit.cover,
                  errorBuilder: _avatarFallback,
                ),
              ),
              // Orange badge
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C), // orange-400
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title, String count) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
            color: const Color(0xFF111827).withAlpha(178),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Color(0xFFFEF9C3), // yellow-100
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              count,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF854D0E), // yellow-800
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
