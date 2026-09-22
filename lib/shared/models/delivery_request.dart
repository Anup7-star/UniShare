enum PackageType { document, food, parcel, fragile, electronics }
enum PackageSize { small, medium, large }
enum UrgencyLevel { low, medium, high, urgent }
enum DeliveryStatus { open, matched, pickup, inTransit, delivered, cancelled, expired }

class DeliveryRequest {
  final String id;
  final String requesterId;
  final String pickupLocationId;
  final String destinationId;
  final PackageType packageType;
  final PackageSize packageSize;
  final UrgencyLevel urgency;
  final DateTime preferredTime;
  final String? note;
  final double reward;
  final double priceCeiling;
  final DeliveryStatus status;
  final DateTime createdAt;
  final String? courierId;

  DeliveryRequest({
    required this.id,
    required this.requesterId,
    required this.pickupLocationId,
    required this.destinationId,
    required this.packageType,
    required this.packageSize,
    required this.urgency,
    required this.preferredTime,
    this.note,
    required this.reward,
    required this.priceCeiling,
    this.status = DeliveryStatus.open,
    required this.createdAt,
    this.courierId,
  });

  factory DeliveryRequest.fromJson(Map<String, dynamic> json) {
    return DeliveryRequest(
      id: json['id'] as String,
      requesterId: json['requesterId'] as String,
      pickupLocationId: json['pickupLocationId'] as String,
      destinationId: json['destinationId'] as String,
      packageType: PackageType.values.byName(json['packageType'] as String),
      packageSize: PackageSize.values.byName(json['packageSize'] as String),
      urgency: UrgencyLevel.values.byName(json['urgency'] as String),
      preferredTime: DateTime.parse(json['preferredTime'] as String),
      note: json['note'] as String?,
      reward: (json['reward'] as num).toDouble(),
      priceCeiling: (json['priceCeiling'] as num).toDouble(),
      status: DeliveryStatus.values.byName(json['status'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      courierId: json['courierId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requesterId': requesterId,
      'pickupLocationId': pickupLocationId,
      'destinationId': destinationId,
      'packageType': packageType.name,
      'packageSize': packageSize.name,
      'urgency': urgency.name,
      'preferredTime': preferredTime.toIso8601String(),
      'note': note,
      'reward': reward,
      'priceCeiling': priceCeiling,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'courierId': courierId,
    };
  }

  DeliveryRequest copyWith({
    String? id,
    String? requesterId,
    String? pickupLocationId,
    String? destinationId,
    PackageType? packageType,
    PackageSize? packageSize,
    UrgencyLevel? urgency,
    DateTime? preferredTime,
    String? note,
    double? reward,
    double? priceCeiling,
    DeliveryStatus? status,
    DateTime? createdAt,
    String? courierId,
  }) {
    return DeliveryRequest(
      id: id ?? this.id,
      requesterId: requesterId ?? this.requesterId,
      pickupLocationId: pickupLocationId ?? this.pickupLocationId,
      destinationId: destinationId ?? this.destinationId,
      packageType: packageType ?? this.packageType,
      packageSize: packageSize ?? this.packageSize,
      urgency: urgency ?? this.urgency,
      preferredTime: preferredTime ?? this.preferredTime,
      note: note ?? this.note,
      reward: reward ?? this.reward,
      priceCeiling: priceCeiling ?? this.priceCeiling,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      courierId: courierId ?? this.courierId,
    );
  }
}
