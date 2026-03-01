import 'package:flutter/material.dart';
import 'design_tokens.dart';
import 'components/app_top_bar.dart';
import 'components/blob_tab_bar.dart';
import 'components/blob_bottom_nav_bar.dart';
import 'components/section_header.dart';
import 'components/stat_card.dart';
import 'components/timeline_card.dart';
import 'components/client_chip.dart';

/// Right screen from the reference — the Payments detail view.
class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  int _tabIndex = 0; // "Paid" selected
  int _navIndex = 1; // Folder selected

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
                    // Light header
                    Container(
                      color: FDTokens.white,
                      child: Column(
                        children: [
                          FDAppTopBar(
                            title: 'Payments',
                            onBack: () => Navigator.maybePop(context),
                          ),
                          const SizedBox(height: 4),

                          // Blob tab bar
                          BlobTabBar(
                            labels: ['Paid', 'Unpaid'],
                            counts: [8, 2],
                            selectedIndex: _tabIndex,
                            onTabChanged: (i) => setState(() => _tabIndex = i),
                            tabBackgroundColor: FDTokens.white,
                            contentColor: FDTokens.white,
                            child: _buildMonthlyStats(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Timelines
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FDSectionHeader(title: 'Timelines', count: 3),
                    ),
                    const SizedBox(height: 12),
                    _buildTimelines(),
                    const SizedBox(height: 28),

                    // Clients
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FDSectionHeader(title: 'Clients', count: 4),
                    ),
                    const SizedBox(height: 12),
                    _buildClients(),
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

  Widget _buildMonthlyStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Last 3 Months', style: FDTokens.cardSubtitle),
            const Spacer(),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: FDTokens.dark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.bar_chart_rounded,
                size: 16,
                color: FDTokens.textOnDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            StatCard(month: 'Oct', amount: '\$2600.00'),
            StatCard(month: 'Nov', amount: '\$3200.00'),
            StatCard(month: 'Dec', amount: '\$2100.00', isActive: true),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelines() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: const [
          TimelineCard(
            title: 'Tate Design Studio',
            subtitle: 'Travel Planning App UI',
            weeks: 1,
            icon: Icons.auto_awesome_rounded,
            variant: TimelineCardVariant.golden,
          ),
          SizedBox(height: 10),
          TimelineCard(
            title: 'Framely',
            subtitle: 'Company Landing UI',
            weeks: 4,
            icon: Icons.crop_square_rounded,
            variant: TimelineCardVariant.dark,
          ),
          SizedBox(height: 10),
          TimelineCard(
            title: 'Crowd',
            subtitle: 'Forex Dashboard App',
            weeks: 12,
            icon: Icons.circle_outlined,
            variant: TimelineCardVariant.dark,
          ),
        ],
      ),
    );
  }

  Widget _buildClients() {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: const [
          ClientChip.add(),
          SizedBox(width: 8),
          ClientChip(name: 'Rubion', icon: Icons.add_circle_outline),
          SizedBox(width: 8),
          ClientChip(name: 'Tate', icon: Icons.cloud_outlined),
          SizedBox(width: 8),
          ClientChip(name: 'Crowd', icon: Icons.square_rounded),
        ],
      ),
    );
  }
}
