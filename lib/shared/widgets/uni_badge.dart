import 'package:flutter/material.dart';

enum UniBadgeType { verified, pending, unverified }

class UniBadge extends StatelessWidget {
  final String label;
  final UniBadgeType type;

  const UniBadge({
    super.key,
    required this.label,
    this.type = UniBadgeType.unverified,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    IconData? iconData;

    switch (type) {
      case UniBadgeType.verified:
        backgroundColor = const Color(0xFFE6F9F0);
        textColor = const Color(0xFF00BF6D);
        iconData = Icons.check_circle_outline;
        break;
      case UniBadgeType.pending:
        backgroundColor = const Color(0xFFFFF4E5);
        textColor = const Color(0xFFFF9500); // Warning
        iconData = Icons.schedule;
        break;
      case UniBadgeType.unverified:
        backgroundColor = const Color(0xFFF5F5F5);
        textColor = const Color(0xFF6B6B6B);
        iconData = null;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconData != null) ...[
            Icon(iconData, size: 14, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
