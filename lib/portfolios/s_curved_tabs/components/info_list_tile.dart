import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// A rounded pink list tile with leading dot, title, optional subtitle,
/// and trailing arrow.
class InfoListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color backgroundColor;
  final double contentOpacity;

  const InfoListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.backgroundColor = SCTTokens.primaryMid,
    this.contentOpacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final dotAlpha = (contentOpacity * 0.7 * 255).round();
    final titleAlpha = contentOpacity < 1 ? 204 : 255; // 0.8 or 1.0
    final subAlpha = (contentOpacity * 0.7 * 255).round();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(SCTTokens.listTileRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withAlpha(dotAlpha),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: SCTTokens.listTitle.copyWith(
                    color: Colors.white.withAlpha(titleAlpha),
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: SCTTokens.listSubtitle.copyWith(
                        color: Colors.white.withAlpha(subAlpha),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward,
            size: 20,
            color: Colors.white.withAlpha(subAlpha),
          ),
        ],
      ),
    );
  }
}
