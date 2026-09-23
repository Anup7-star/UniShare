import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationTile extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationTile({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUnread = notification['isUnread'] ?? false;
    final String type = notification['type'] ?? 'info';
    
    IconData icon;
    Color iconColor;
    Color bgColor;

    switch (type) {
      case 'delivery':
        icon = Icons.local_shipping;
        iconColor = const Color(0xFF007AFF);
        bgColor = const Color(0xFFE5F0FF);
        break;
      case 'rental':
        icon = Icons.inventory_2;
        iconColor = const Color(0xFF00BF6D);
        bgColor = const Color(0xFFE6F9F0);
        break;
      case 'rating':
        icon = Icons.star;
        iconColor = const Color(0xFFFF9500);
        bgColor = const Color(0xFFFFF9E6);
        break;
      default:
        icon = Icons.info;
        iconColor = const Color(0xFF8E8E93);
        bgColor = const Color(0xFFF2F2F7);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: isUnread ? const Color(0xFFFAFAFA) : const Color(0xFFFFFFFF),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title'] ?? 'Notification',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: isUnread ? FontWeight.w600 : FontWeight.w500,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['body'] ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['timeAgo'] ?? 'Just now',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF00BF6D),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
