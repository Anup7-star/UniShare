import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/notification_tile.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mockNotifications = [
      {
        'id': '1',
        'title': 'Delivery Request Accepted',
        'body': 'Rahul has accepted your delivery request from Hostel A to Library.',
        'timeAgo': '2m ago',
        'type': 'delivery',
        'isUnread': true,
      },
      {
        'id': '2',
        'title': 'Rental Request',
        'body': 'Priya wants to rent your Scientific Calculator.',
        'timeAgo': '1h ago',
        'type': 'rental',
        'isUnread': true,
      },
      {
        'id': '3',
        'title': 'New Rating Received',
        'body': 'You received a 5-star rating for your recent delivery.',
        'timeAgo': 'Yesterday',
        'type': 'rating',
        'isUnread': false,
      },
      {
        'id': '4',
        'title': 'System Update',
        'body': 'Welcome to UniShare! Please complete your profile verification.',
        'timeAgo': 'Oct 10',
        'type': 'info',
        'isUnread': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Notifications',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: Color(0xFF00BF6D)),
            onPressed: () {},
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: mockNotifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.notifications_off_outlined, color: Color(0xFF8E8E93)),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFF6B6B6B),
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              itemCount: mockNotifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFE5E5EA)),
              itemBuilder: (context, index) {
                return NotificationTile(
                  notification: mockNotifications[index],
                );
              },
            ),
    );
  }
}
