import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';
import 'components/sliding_pill_nav.dart';
import 'components/hex_fab.dart';
import 'components/data_tooltip.dart';

class PillNavBarPage extends StatefulWidget {
  const PillNavBarPage({super.key});

  @override
  State<PillNavBarPage> createState() => _PillNavBarPageState();
}

class _PillNavBarPageState extends State<PillNavBarPage> {
  String _activeTab = 'Data';
  bool _isFabOpen = false;
  String _lastAction = 'None';

  static const _tabs = [
    PillNavTab(id: 'Home', icon: Icons.home_outlined),
    PillNavTab(id: 'User', icon: Icons.person_outline),
    PillNavTab(id: 'Data', icon: Icons.layers_outlined),
  ];

  static const _fabActions = [
    FabAction(
      label: 'Scan',
      icon: Icon(Icons.document_scanner_outlined,
          size: 20, color: PNBTokens.scanBlue),
    ),
    FabAction(
      label: 'Record',
      icon: _RecordDot(),
    ),
    FabAction(
      label: 'View',
      icon: Icon(Icons.visibility_outlined,
          size: 20, color: PNBTokens.viewTeal),
    ),
  ];

  void _handleFabAction(String name) {
    setState(() {
      _lastAction = name;
      _isFabOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Pill Nav Bar',
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
          child: _phoneFrame(
            _PhoneContent(
              activeTab: _activeTab,
              isFabOpen: _isFabOpen,
              lastAction: _lastAction,
              tabs: _tabs,
              fabActions: _fabActions,
              onTabChanged: (id) => setState(() => _activeTab = id),
              onFabToggle: () => setState(() => _isFabOpen = !_isFabOpen),
              onFabAction: _handleFabAction,
              onOverlayTap: () => setState(() => _isFabOpen = false),
            ),
          ),
        ),
      ),
    );
  }

  Widget _phoneFrame(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PNBTokens.phoneBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PNBTokens.phoneBorderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: PNBTokens.phoneBg,
            border: Border.all(
              color: PNBTokens.phoneBorder,
              width: PNBTokens.phoneBorderWidth,
            ),
            borderRadius: BorderRadius.circular(PNBTokens.phoneBorderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              PNBTokens.phoneBorderRadius - PNBTokens.phoneBorderWidth,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// The inner phone content — background, overlay, nav bar, FAB, tooltip.
class _PhoneContent extends StatelessWidget {
  final String activeTab;
  final bool isFabOpen;
  final String lastAction;
  final List<PillNavTab> tabs;
  final List<FabAction> fabActions;
  final ValueChanged<String> onTabChanged;
  final VoidCallback onFabToggle;
  final ValueChanged<String> onFabAction;
  final VoidCallback onOverlayTap;

  const _PhoneContent({
    required this.activeTab,
    required this.isFabOpen,
    required this.lastAction,
    required this.tabs,
    required this.fabActions,
    required this.onTabChanged,
    required this.onFabToggle,
    required this.onFabAction,
    required this.onOverlayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Mock app content background
        Center(
          child: Opacity(
            opacity: 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.layers_outlined, size: 64, color: PNBTokens.contentIcon),
                const SizedBox(height: 16),
                Text('App Content Area', style: PNBTokens.contentMedium),
                const SizedBox(height: 8),
                Text('Last Action: $lastAction', style: PNBTokens.contentSmall),
              ],
            ),
          ),
        ),

        // Backdrop overlay for FAB menu
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isFabOpen
              ? GestureDetector(
                  onTap: onOverlayTap,
                  child: Container(
                    key: const ValueKey('overlay'),
                    color: PNBTokens.overlayColor.withAlpha(102), // 40% opacity
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: const SizedBox.expand(),
                    ),
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('no-overlay')),
        ),

        // Navigation bar + FAB + Tooltip — positioned at bottom
        Positioned(
          left: 0,
          right: 0,
          bottom: 32, // bottom-8 = 32px
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tooltip above the nav bar, aligned to the right side
              // Only visible when Data tab is active
              Padding(
                padding: const EdgeInsets.only(bottom: 12, right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    // Offset to align tooltip roughly above the Data tab area
                    padding: const EdgeInsets.only(right: 60),
                    child: DataTooltip(visible: activeTab == 'Data'),
                  ),
                ),
              ),

              // Nav bar row: pill nav + FAB
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SlidingPillNav(
                    tabs: tabs,
                    activeTabId: activeTab,
                    onTabChanged: onTabChanged,
                  ),
                  const SizedBox(width: PNBTokens.navGap),
                  HexFab(
                    isOpen: isFabOpen,
                    onToggle: onFabToggle,
                    actions: fabActions,
                    onActionTap: onFabAction,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The red recording dot used as an icon in the FAB menu.
class _RecordDot extends StatelessWidget {
  const _RecordDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: PNBTokens.recordRed,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: PNBTokens.recordRed.withAlpha(153), // 0.6 opacity
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}
