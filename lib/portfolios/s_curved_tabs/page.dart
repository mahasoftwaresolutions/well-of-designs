import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';
import 'components/s_curved_tab_card.dart';
import 'components/campaign_header.dart';
import 'components/info_list_tile.dart';
import 'components/dock_nav_bar.dart';

class SCurvedTabsPage extends StatefulWidget {
  const SCurvedTabsPage({super.key});

  @override
  State<SCurvedTabsPage> createState() => _SCurvedTabsPageState();
}

class _SCurvedTabsPageState extends State<SCurvedTabsPage>
    with SingleTickerProviderStateMixin {
  int _activeIndex = 1; // Default: right tab (Self Unwrap)
  late final AnimationController _controller;
  late final CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: 1.0, // Start at right tab
    );
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _curvedAnimation.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    if (index == _activeIndex) return;
    setState(() => _activeIndex = index);
    if (index == 0) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  bool get _isMobileDevice =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    final content = _PhoneContent(
      activeIndex: _activeIndex,
      animation: _curvedAnimation,
      onTabChanged: _onTabChanged,
      onBack: () => Navigator.maybePop(context),
    );

    if (_isMobileDevice) {
      return Scaffold(body: content);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE8E4E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8E4E0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'S-Curved Tabs',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: _phoneFrame(content),
        ),
      ),
    );
  }

  Widget _phoneFrame(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SCTTokens.phoneRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(153),
            blurRadius: 64,
            offset: const Offset(0, 32),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SCTTokens.phoneRadius),
        child: child,
      ),
    );
  }
}

// ── Phone content ─────────────────────────────────────────

class _PhoneContent extends StatelessWidget {
  final int activeIndex;
  final Animation<double> animation;
  final ValueChanged<int> onTabChanged;
  final VoidCallback onBack;

  const _PhoneContent({
    required this.activeIndex,
    required this.animation,
    required this.onTabChanged,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SCTTokens.primary,
      child: Stack(
        children: [
          // Scrollable main content
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const SizedBox(height: 8),
                CampaignHeader(onBack: onBack),
                const SizedBox(height: 24),

                // Card + S-curved tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SCurvedTabCard(
                    animation: animation,
                    activeIndex: activeIndex,
                    onTabChanged: onTabChanged,
                    tabLabels: const ['SCHEDULE\nUNWRAP', 'SELF\nUNWRAP'],
                    child: _CardContent(activeIndex: activeIndex),
                  ),
                ),

                const SizedBox(height: 24),

                // List tiles
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const InfoListTile(
                        title: 'How to remove wrap?',
                        subtitle: 'Step-by-Step guide',
                        backgroundColor: SCTTokens.primaryMid,
                      ),
                      const SizedBox(height: 12),
                      InfoListTile(
                        title: 'Tools to remove wrap?',
                        backgroundColor: SCTTokens.primaryDeep,
                        contentOpacity: 0.6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom dock nav bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DockNavBar(),
          ),
        ],
      ),
    );
  }
}

// ── Card inner content ────────────────────────────────────

class _CardContent extends StatelessWidget {
  final int activeIndex;

  const _CardContent({required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    final isRight = activeIndex == 1;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Padding(
        key: ValueKey(activeIndex),
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
        child: Column(
          children: [
            Text(
              isRight ? 'Wrap Removal' : 'Schedule Service',
              style: SCTTokens.cardHeading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                isRight
                    ? 'If you remove the wrap yourself you will earn an additional \$10.'
                    : 'Choose a certified shop near you to professionally remove the wrap.',
                style: SCTTokens.cardBody,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            const Icon(
              Icons.account_balance_wallet_outlined,
              size: 24,
              color: SCTTokens.accent,
            ),
            const SizedBox(height: 8),
            Text(
              isRight ? '\$50' : '\$40',
              style: SCTTokens.priceText,
            ),
            const SizedBox(height: 8),
            Text(
              isRight ? 'Self unwrap bonus' : 'Standard removal',
              style: SCTTokens.priceSubtitle,
            ),
            const SizedBox(height: 32),
            _CtaButton(label: isRight ? "I'LL REMOVE THE WRAP" : 'FIND A SHOP'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  final String label;

  const _CtaButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SCTTokens.buttonRadius),
        boxShadow: [
          BoxShadow(
            color: SCTTokens.textDark.withAlpha(31),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(label, style: SCTTokens.ctaButton),
    );
  }
}
