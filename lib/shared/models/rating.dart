class Rating {
  final String id;
  final String fromUserId;
  final String toUserId;
  final String transactionId;
  final String transactionType; // 'delivery' or 'rental'
  final int score;
  final String? comment;
  final DateTime createdAt;

  Rating({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.transactionId,
    required this.transactionType,
    required this.score,
    this.comment,
    required this.createdAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] as String,
      fromUserId: json['fromUserId'] as String,
      toUserId: json['toUserId'] as String,
      transactionId: json['transactionId'] as String,
      transactionType: json['transactionType'] as String,
      score: json['score'] as int,
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'transactionId': transactionId,
      'transactionType': transactionType,
      'score': score,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
