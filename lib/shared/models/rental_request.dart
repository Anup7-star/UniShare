enum RentalRequestStatus { pending, accepted, rejected, active, returned, cancelled }

class RentalRequest {
  final String id;
  final String listingId;
  final String requesterId;
  final DateTime startDate;
  final DateTime endDate;
  final RentalRequestStatus status;
  final String? message;
  final DateTime createdAt;

  RentalRequest({
    required this.id,
    required this.listingId,
    required this.requesterId,
    required this.startDate,
    required this.endDate,
    this.status = RentalRequestStatus.pending,
    this.message,
    required this.createdAt,
  });

  factory RentalRequest.fromJson(Map<String, dynamic> json) {
    return RentalRequest(
      id: json['id'] as String,
      listingId: json['listingId'] as String,
      requesterId: json['requesterId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: RentalRequestStatus.values.byName(json['status'] as String),
      message: json['message'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'listingId': listingId,
      'requesterId': requesterId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status.name,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
