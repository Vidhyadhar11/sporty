class DetailsPageApi {
  final String image;
  final String category;
  final String turfName;
  final int totalMember;
  final String location;
  final String description;
  final List<String> amenities;
  final double rating;
  final List<Map<String, dynamic>> slots;
  final int discounts;

  DetailsPageApi({
    required this.image,
    required this.category,
    required this.turfName,
    required this.totalMember,
    required this.location,
    required this.description,
    required this.amenities,
    required this.rating,
    required this.slots,
    required this.discounts,
  });

  factory DetailsPageApi.fromJson(Map<String, dynamic> json) {
    List<String> amenities = [];
    if (json['amenities'] != null) {
      if (json['amenities'] is Iterable) {
        amenities.addAll(List<String>.from(json['amenities']));
      } else {
        amenities.add(json['amenities']);
      }
    }

    return DetailsPageApi(
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      turfName: json['turfname'] ?? '',
      totalMember: json['totalmember'] ?? 0,
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      amenities: amenities,
      rating: json['rating'] != null ? double.parse(json['rating'].toString()) : 0.0,
      slots: json['slots'] != null ? List<Map<String, dynamic>>.from(json['slots']) : [],
      discounts: json['discounts'] != null ? int.parse(json['discounts'].toString()) : 0,
    );
  }
}
