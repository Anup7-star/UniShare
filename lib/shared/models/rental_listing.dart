enum RentalCategory { books, calculators, electronics, tools, labEquipment, sports, clothing, other }
enum ItemCondition { newItem, good, fair, worn }

class RentalListing {
  final String id;
  final String ownerId;
  final String name;
  final String description;
  final RentalCategory category;
  final List<String> imageUrls;
  final double pricePerDay;
  final double? deposit;
  final ItemCondition condition;
  final String locationId;
  final bool isAvailable;
  final DateTime createdAt;

  String get title => name;
  double get ratePerDay => pricePerDay;

  RentalListing({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrls,
    required this.pricePerDay,
    this.deposit,
    required this.condition,
    required this.locationId,
    this.isAvailable = true,
    required this.createdAt,
  });

  factory RentalListing.fromJson(Map<String, dynamic> json) {
    return RentalListing(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: RentalCategory.values.byName(json['category'] as String),
      imageUrls: List<String>.from(json['imageUrls'] as List),
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      deposit: (json['deposit'] as num?)?.toDouble(),
      condition: ItemCondition.values.byName(json['condition'] as String),
      locationId: json['locationId'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'description': description,
      'category': category.name,
      'imageUrls': imageUrls,
      'pricePerDay': pricePerDay,
      'deposit': deposit,
      'condition': condition.name,
      'locationId': locationId,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
