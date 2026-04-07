import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Card header with circular avatar, name, and role.
class AvatarHeader extends StatelessWidget {
  final String name;
  final String role;
  final IconData avatarIcon;

  const AvatarHeader({
    super.key,
    required this.name,
    required this.role,
    this.avatarIcon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: FlexCardTokens.avatarSize,
          height: FlexCardTokens.avatarSize,
          decoration: const BoxDecoration(
            color: FlexCardTokens.avatarBg,
            shape: BoxShape.circle,
            boxShadow: [FlexCardTokens.buttonShadow],
          ),
          child: Icon(
            avatarIcon,
            size: 28,
            color: const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: FlexCardTokens.headerName),
            Text(role, style: FlexCardTokens.headerRole),
          ],
        ),
      ],
    );
  }
}
