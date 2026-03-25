import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Top header bar with back chevron, title, and profile icon.
class CampaignHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const CampaignHeader({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleButton(
            icon: Icons.chevron_left,
            size: 24,
            onTap: onBack,
          ),
          Text('CAMPAIGN DASHBOARD', style: SCTTokens.headerTitle),
          _circleButton(
            icon: Icons.person_outline,
            size: 20,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required double size,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: size, color: Colors.white),
      ),
    );
  }
}
