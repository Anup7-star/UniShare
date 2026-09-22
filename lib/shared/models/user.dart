class UniUser {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String college;
  final String department;
  final bool isVerified;
  final double rating;
  final int completedDeliveries;
  final int completedRentals;
  final double earnings;
  final DateTime joinedAt;

  int get deliveries => completedDeliveries;
  int get rentalCount => completedRentals;
  String? get avatarimageUrl => avatarUrl;

  UniUser({
    required this.id,
    required this.name,
    required this.email,
    String? avatarUrl,
    String? avatarimageUrl,
    String? college,
    required this.department,
    this.isVerified = false,
    this.rating = 0.0,
    int? completedDeliveries,
    int? deliveries,
    int? completedRentals,
    int? rentalCount,
    this.earnings = 0.0,
    DateTime? joinedAt,
  })  : avatarUrl = avatarUrl ?? avatarimageUrl,
        college = college ?? 'IIT Delhi',
        completedDeliveries = completedDeliveries ?? deliveries ?? 0,
        completedRentals = completedRentals ?? rentalCount ?? 0,
        joinedAt = joinedAt ?? DateTime.now();

  factory UniUser.fromJson(Map<String, dynamic> json) {
    return UniUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      college: json['college'] as String,
      department: json['department'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      completedDeliveries: json['completedDeliveries'] as int? ?? 0,
      completedRentals: json['completedRentals'] as int? ?? 0,
      earnings: (json['earnings'] as num?)?.toDouble() ?? 0.0,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'college': college,
      'department': department,
      'isVerified': isVerified,
      'rating': rating,
      'completedDeliveries': completedDeliveries,
      'completedRentals': completedRentals,
      'earnings': earnings,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }

  UniUser copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? college,
    String? department,
    bool? isVerified,
    double? rating,
    int? completedDeliveries,
    int? completedRentals,
    double? earnings,
    DateTime? joinedAt,
  }) {
    return UniUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      college: college ?? this.college,
      department: department ?? this.department,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      completedDeliveries: completedDeliveries ?? this.completedDeliveries,
      completedRentals: completedRentals ?? this.completedRentals,
      earnings: earnings ?? this.earnings,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
