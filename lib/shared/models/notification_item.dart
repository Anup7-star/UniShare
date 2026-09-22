enum NotificationType { deliveryRequest, deliveryAccepted, pickupReminder, deliveryCompleted, rentalRequest, rentalApproved, rentalRejected, transactionUpdate, ratingReminder, system }

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final String? actionRoute;
  final bool isRead;
  final DateTime createdAt;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.actionRoute,
    this.isRead = false,
    required this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] as String,
      type: NotificationType.values.byName(json['type'] as String),
      title: json['title'] as String,
      body: json['body'] as String,
      actionRoute: json['actionRoute'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'body': body,
      'actionRoute': actionRoute,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
