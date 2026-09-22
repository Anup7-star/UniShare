enum ReportType { inappropriateBehavior, itemDamage, noShow, fakeProfile, other }

class Report {
  final String id;
  final String reporterId;
  final String reportedUserId;
  final String? transactionId;
  final ReportType type;
  final String description;
  final DateTime createdAt;

  Report({
    required this.id,
    required this.reporterId,
    required this.reportedUserId,
    this.transactionId,
    required this.type,
    required this.description,
    required this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as String,
      reporterId: json['reporterId'] as String,
      reportedUserId: json['reportedUserId'] as String,
      transactionId: json['transactionId'] as String?,
      type: ReportType.values.byName(json['type'] as String),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporterId': reporterId,
      'reportedUserId': reportedUserId,
      'transactionId': transactionId,
      'type': type.name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
