import 'package:flutter/material.dart';
import 'design_tokens.dart';
import 'dashboard_screen.dart';
import 'payments_screen.dart';
import 'components/blob_bottom_nav_bar.dart';

class FreelancerDashboardPage extends StatefulWidget {
  const FreelancerDashboardPage({super.key});

  @override
  State<FreelancerDashboardPage> createState() =>
      _FreelancerDashboardPageState();
}

class _FreelancerDashboardPageState extends State<FreelancerDashboardPage> {
  // Index 2 = Dashboard (bolt), Index 3 = Payments (wallet) — matching React.
  int _activeNav = 2;

  /// Blob colour matches the bottom background of the active screen,
  /// creating a seamless visual connection between screen and nav bar.
  Color get _blobColor {
    if (_activeNav == 3) return const Color(0xFF222327); // Payments dark bottom
    return Colors.white; // Dashboard white bottom
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;
    return isWide ? _buildSideBySide() : _buildSingleScreen();
  }

  // ── Single-screen mode (mobile / narrow) ────────────────────────────────

  Widget _buildSingleScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E4E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8E4E0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: FDTokens.dark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Freelancer Dashboard',
          style: FDTokens.pageTitle.copyWith(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: _phoneFrame(
            Column(
              children: [
                Expanded(
                  // IndexedStack keeps each screen's scroll state alive.
                  child: IndexedStack(
                    index: switch (_activeNav) {
                      2 => 0,
                      3 => 1,
                      _ => 2,
                    },
                    children: [
                      DashboardScreen(
                        onPaymentsSeeAll: () =>
                            setState(() => _activeNav = 3),
                      ),
                      const PaymentsScreen(),
                      // Placeholder for unused tabs
                      const ColoredBox(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'Coming soon',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BlobBottomNavBar(
                  selectedIndex: _activeNav,
                  onTap: (i) => setState(() => _activeNav = i),
                  blobColor: _blobColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Side-by-side mode (desktop / wide) ──────────────────────────────────

  Widget _buildSideBySide() {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E4E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8E4E0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: FDTokens.dark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Freelancer Dashboard',
          style: FDTokens.pageTitle.copyWith(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Row(
            children: [
              Expanded(
                child: _phoneFrame(
                  _withNav(
                    DashboardScreen(onPaymentsSeeAll: () {}),
                    navIndex: 2,
                    blobColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _phoneFrame(
                  _withNav(
                    const PaymentsScreen(),
                    navIndex: 3,
                    blobColor: const Color(0xFF222327),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Wraps a screen with a static nav bar for the side-by-side showcase.
  Widget _withNav(Widget screen,
      {required int navIndex, required Color blobColor}) {
    return Column(
      children: [
        Expanded(child: screen),
        BlobBottomNavBar(
          selectedIndex: navIndex,
          onTap: (_) {},
          blobColor: blobColor,
        ),
      ],
    );
  }

  Widget _phoneFrame(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(32), child: child),
    );
  }
}
