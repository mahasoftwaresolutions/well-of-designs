import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// App header with date, greeting title, and profile avatar.
class FitnessHeader extends StatelessWidget {
  final String title;

  const FitnessHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    final dateStr = '${months[now.month - 1]} ${now.day}, ${now.year}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dateStr, style: FTTokens.dateLabel),
                const SizedBox(height: 4),
                Text(title, style: FTTokens.heading),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: FTTokens.textLight.withAlpha(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Icon(
              Icons.person,
              size: 28,
              color: FTTokens.textGray,
            ),
          ),
        ],
      ),
    );
  }
}
