enum TransactionStatus { awaitingPickup, pickedUp, inTransit, delivered, cancelled, disputed }

class DeliveryTransaction {
  final String id;
  final String requestId;
  final String requesterId;
  final String courierId;
  final String pickupVerification;
  final String dropoffVerification;
  final DateTime? pickedUpAt;
  final DateTime? deliveredAt;
  final TransactionStatus status;
  final DateTime createdAt;

  DeliveryTransaction({
    required this.id,
    required this.requestId,
    required this.requesterId,
    required this.courierId,
    required this.pickupVerification,
    required this.dropoffVerification,
    this.pickedUpAt,
    this.deliveredAt,
    this.status = TransactionStatus.awaitingPickup,
    required this.createdAt,
  });

  factory DeliveryTransaction.fromJson(Map<String, dynamic> json) {
    return DeliveryTransaction(
      id: json['id'] as String,
      requestId: json['requestId'] as String,
      requesterId: json['requesterId'] as String,
      courierId: json['courierId'] as String,
      pickupVerification: json['pickupVerification'] as String,
      dropoffVerification: json['dropoffVerification'] as String,
      pickedUpAt: json['pickedUpAt'] != null ? DateTime.parse(json['pickedUpAt'] as String) : null,
      deliveredAt: json['deliveredAt'] != null ? DateTime.parse(json['deliveredAt'] as String) : null,
      status: TransactionStatus.values.byName(json['status'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requestId': requestId,
      'requesterId': requesterId,
      'courierId': courierId,
      'pickupVerification': pickupVerification,
      'dropoffVerification': dropoffVerification,
      'pickedUpAt': pickedUpAt?.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
