import 'package:flutter/material.dart';

enum UniStatus { active, pending, completed, cancelled, failed }

class UniStatusIndicator extends StatelessWidget {
  final UniStatus status;
  final String label;

  const UniStatusIndicator({
    super.key,
    required this.status,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    switch (status) {
      case UniStatus.active:
      case UniStatus.completed:
        statusColor = const Color(0xFF00BF6D); // Success/Primary
        break;
      case UniStatus.pending:
        statusColor = const Color(0xFFFF9500); // Warning
        break;
      case UniStatus.failed:
      case UniStatus.cancelled:
        statusColor = const Color(0xFFFF3B30); // Error
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: statusColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
