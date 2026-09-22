class CampusRoute {
  final String id;
  final String fromId;
  final String toId;
  final double distanceMeters;
  final int estimatedMinutes;

  String get sourceId => fromId;
  String get targetId => toId;
  double get distance => distanceMeters;
  int get durationMinutes => estimatedMinutes;

  CampusRoute({
    String? id,
    String? sourceId,
    String? targetId,
    double? distance,
    int? durationMinutes,
    String? fromId,
    String? toId,
    double? distanceMeters,
    int? estimatedMinutes,
  })  : id = id ?? 'r_${DateTime.now().millisecondsSinceEpoch}',
        fromId = fromId ?? sourceId ?? '',
        toId = toId ?? targetId ?? '',
        distanceMeters = distanceMeters ?? distance ?? 0.0,
        estimatedMinutes = estimatedMinutes ?? durationMinutes ?? 0;

  factory CampusRoute.fromJson(Map<String, dynamic> json) {
    return CampusRoute(
      id: json['id'] as String?,
      fromId: (json['fromId'] ?? json['sourceId']) as String?,
      toId: (json['toId'] ?? json['targetId']) as String?,
      distanceMeters: ((json['distanceMeters'] ?? json['distance']) as num?)?.toDouble(),
      estimatedMinutes: (json['estimatedMinutes'] ?? json['durationMinutes']) as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromId': fromId,
      'toId': toId,
      'distanceMeters': distanceMeters,
      'estimatedMinutes': estimatedMinutes,
    };
  }
}
