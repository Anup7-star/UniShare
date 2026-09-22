class CampusLocation {
  final String id;
  final String name;
  final String type; // gate, hostel, academic, lab, library, canteen, sports
  final double x; // graph coordinate
  final double y; // graph coordinate
  final String zone; // North, South, East, West
  final String? description;

  CampusLocation({
    required this.id,
    required this.name,
    required this.type,
    required this.x,
    required this.y,
    this.zone = 'Central',
    this.description,
  });

  factory CampusLocation.fromJson(Map<String, dynamic> json) {
    return CampusLocation(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      zone: json['zone'] as String? ?? 'Central',
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'x': x,
      'y': y,
      'zone': zone,
      'description': description,
    };
  }
}
