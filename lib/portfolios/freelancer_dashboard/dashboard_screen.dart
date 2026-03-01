import 'package:flutter/material.dart';
import 'design_tokens.dart';
import 'components/app_top_bar.dart';
import 'components/blob_tab_bar.dart';
import 'components/blob_bottom_nav_bar.dart';
import 'components/section_header.dart';
import 'components/circular_countdown.dart';
import 'components/project_card.dart';
import 'components/payment_list_tile.dart';

/// Left screen from the reference — the main Dashboard view.
class DashboardScreen extends StatefulWidget {
  final VoidCallback? onPaymentsSeeAll;

  const DashboardScreen({super.key, this.onPaymentsSeeAll});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _tabIndex = 1; // "Projects" selected by default
  int _navIndex = 2; // Center button selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FDTokens.creamLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Golden header zone
                    Container(
                      color: FDTokens.goldenBg,
                      child: Column(
                        children: [
                          FDAppTopBar(
                            title: 'Dashboard',
                            onBack: () => Navigator.maybePop(context),
                          ),
                          const SizedBox(height: 4),

                          // Blob tab bar
                          BlobTabBar(
                            labels: ['Stats', 'Projects'],
                            counts: [null, 182],
                            selectedIndex: _tabIndex,
                            onTabChanged: (i) => setState(() => _tabIndex = i),
                            tabBackgroundColor: FDTokens.goldenBg,
                            contentColor: FDTokens.goldenMuted,
                            child: _tabIndex == 0
                                ? _buildStatsContent()
                                : _buildProjectsTabContent(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Projects section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FDSectionHeader(title: 'Projects', count: 4),
                    ),
                    const SizedBox(height: 12),
                    _buildProjectCards(),
                    const SizedBox(height: 28),

                    // Payments section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FDSectionHeader(
                        title: 'Payments',
                        onSeeAll: widget.onPaymentsSeeAll,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: const [
                          PaymentListTile(
                            companyName: 'Tate Design Studio',
                            projectName: 'Travel Planning App UI',
                            amount: '\$400.00',
                            icon: Icons.auto_awesome_rounded,
                          ),
                          PaymentListTile(
                            companyName: 'Framely',
                            projectName: 'Company Landing UI',
                            amount: '\$1500.00',
                            icon: Icons.crop_square_rounded,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom nav
            BlobBottomNavBar(
              selectedIndex: _navIndex,
              onTap: (i) => setState(() => _navIndex = i),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Left Working Time', style: FDTokens.cardSubtitle),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            CircularCountdown(value: 7, label: 'Days', progress: 0.7),
            CircularCountdown(value: 10, label: 'Hours', progress: 0.42),
            CircularCountdown(value: 30, label: 'Min', progress: 0.5),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectsTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Left Working Time', style: FDTokens.cardSubtitle),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            CircularCountdown(value: 7, label: 'Days', progress: 0.7),
            CircularCountdown(value: 10, label: 'Hours', progress: 0.42),
            CircularCountdown(value: 30, label: 'Min', progress: 0.5),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectCards() {
    return SizedBox(
      height: 190,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: const [
          ProjectCard(
            title: 'Travel Planning',
            type: 'Mobile App',
            daysLeft: '7 Days Left',
            progress: 0.65,
            icon: Icons.edit_rounded,
            isDark: true,
          ),
          SizedBox(width: 12),
          ProjectCard(
            title: 'Company Landing',
            type: 'Website',
            daysLeft: '14 Days Left',
            progress: 0.35,
            icon: Icons.grid_view_rounded,
            isDark: false,
          ),
          SizedBox(width: 12),
          ProjectCard(
            title: 'Social App',
            type: 'Mobile App',
            daysLeft: '21 Days Left',
            progress: 0.2,
            icon: Icons.chat_rounded,
            isDark: true,
          ),
        ],
      ),
    );
  }
}
