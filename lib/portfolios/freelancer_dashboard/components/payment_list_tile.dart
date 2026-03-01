import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A payment list row: icon + name/subtitle + amount right-aligned.
class PaymentListTile extends StatelessWidget {
  final String companyName;
  final String projectName;
  final String amount;
  final IconData icon;

  const PaymentListTile({
    super.key,
    required this.companyName,
    required this.projectName,
    required this.amount,
    this.icon = Icons.attach_money_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: FDTokens.cream,
              borderRadius: BorderRadius.circular(FDTokens.radiusMd),
            ),
            child: Icon(icon, size: 20, color: FDTokens.textSecondary),
          ),
          const SizedBox(width: 12),

          // Name + project
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: FDTokens.cardTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  projectName,
                  style: FDTokens.cardSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Amount
          Text(amount, style: FDTokens.amount),
        ],
      ),
    );
  }
}
