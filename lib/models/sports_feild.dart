class SportsFieldApi {
  final String imageUrl;
  final String category;
  final String turfName;
  final int totalMembers;
  final String location;
  final String description;
  final List<String> amenities;
  final double rating;
  final List<String> slots;
  final List<String> discounts;

  SportsFieldApi({
    required this.imageUrl,
    required this.category,
    required this.turfName,
    required this.totalMembers,
    required this.location,
    required this.description,
    required this.amenities,
    required this.rating,
    required this.slots,
    required this.discounts,
  });

  factory SportsFieldApi.fromJson(Map<String, dynamic> json) {
    return SportsFieldApi(
      imageUrl: json['images'],
      category: json['category'],
      turfName: json['turfname'],
      totalMembers: json['totalmember'],
      location: json['location'],
      description: json['description'],
      amenities: List<String>.from(json['amenties']),
      rating: json['rating'].toDouble(),
      slots: List<String>.from(json['slots']),
      discounts: List<String>.from(json['discounts']),
    );
  }
}
