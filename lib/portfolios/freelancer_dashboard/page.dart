import 'package:flutter/material.dart';
import 'design_tokens.dart';
import 'dashboard_screen.dart';
import 'payments_screen.dart';

/// Portfolio page for the Freelancer Dashboard design.
/// Displays both screens side-by-side on wide viewports,
/// or as a switchable tab view on narrow ones.
class FreelancerDashboardPage extends StatefulWidget {
  const FreelancerDashboardPage({super.key});

  @override
  State<FreelancerDashboardPage> createState() =>
      _FreelancerDashboardPageState();
}

class _FreelancerDashboardPageState extends State<FreelancerDashboardPage> {
  int _screenIndex = 0; // 0 = Dashboard, 1 = Payments

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 800;

    if (isWide) {
      return _buildSideBySide();
    }
    return _buildSingleScreen();
  }

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
                child: _phoneFrame(DashboardScreen(onPaymentsSeeAll: () {})),
              ),
              const SizedBox(width: 24),
              Expanded(child: _phoneFrame(const PaymentsScreen())),
            ],
          ),
        ),
      ),
    );
  }

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
        actions: [
          // Toggle between screens
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Dashboard')),
                ButtonSegment(value: 1, label: Text('Payments')),
              ],
              selected: {_screenIndex},
              onSelectionChanged: (s) => setState(() => _screenIndex = s.first),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return FDTokens.golden;
                  }
                  return FDTokens.white;
                }),
                foregroundColor: WidgetStateProperty.all(FDTokens.dark),
                textStyle: WidgetStateProperty.all(
                  FDTokens.pillText.copyWith(fontSize: 11),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: _phoneFrame(
            _screenIndex == 0
                ? DashboardScreen(
                    onPaymentsSeeAll: () => setState(() => _screenIndex = 1),
                  )
                : const PaymentsScreen(),
          ),
        ),
      ),
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
