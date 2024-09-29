class SportsFieldApi {
  final String imageUrl;
  final String category;
  final String turfName;
  final int courts; 
  final String location;
  final String description;
  final List<String> amenities;
  final double rating;
  final List<Map<String, dynamic>> slots;
  final int discounts;
  final String id;
  bool isLiked;
  final String ownerMobileNumber; // Add this line

  SportsFieldApi({
    required this.imageUrl,
    required this.category,
    required this.turfName,
    required this.courts,
    required this.location,
    required this.description,
    required this.amenities,
    required this.rating,
    required this.slots,
    required this.discounts,
    required this.id,
    this.isLiked = false, 
    required this.ownerMobileNumber, // Update this line
  });
  
  factory SportsFieldApi.fromsnapshot(Map<String, dynamic> json) {
    List<String> amenities = [];
    if (json['amenties'] != null) {
      if (json['amenties'] is Iterable) {
        for (var amenityList in json['amenties']) {
          if (amenityList is Iterable) {
            amenities.addAll(List<String>.from(amenityList));
          } else {
            amenities.add(amenityList.toString());
          }
        }
      } else if (json['amenties'] is String) {
        amenities.add(json['amenties']);
      }
    }

    return SportsFieldApi(
      imageUrl: json['images'] ?? '',
      category: json['category'] ?? '',
      turfName: json['turfname'] ?? '',
      courts: json['court'] != null ? int.parse(json['court'].toString()) : 0,
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      amenities: amenities,
      ownerMobileNumber: json['ownerMobileNo'] ?? '',
      rating: json['rating'] != null ? double.parse(json['rating'].toString()) : 0.0,
      slots: json['slots'] != null ? List<Map<String, dynamic>>.from(json['slots']) : [],
      discounts: json['discounts'] != null ? int.parse(json['discounts'].toString()) : 0,
      id: json['_id'] ?? '',
      isLiked: false,
    );
  }

  // Add this method
  factory SportsFieldApi.fromJson(Map<String, dynamic> json) {
    return SportsFieldApi(
      imageUrl: json['images'] ?? '',
      category: '', // Default value since it's not provided by the API
      turfName: json['turfname'] ?? '',
      courts: 0, // Default value since it's not provided by the API
      location: json['location'] ?? '',
      description: '', // Default value since it's not provided by the API
      amenities: [], // Default value since it's not provided by the API
      ownerMobileNumber: '', // Default value since it's not provided by the API
      rating: 0.0, // Default value since it's not provided by the API
      slots: [], // Default value since it's not provided by the API
      discounts: 0, // Default value since it's not provided by the API
      id: json['_id'] ?? '',
      isLiked: json['isLiked'] ?? false,
    );
  }

  // Add this method
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'images': imageUrl,
      'turfname': turfName,
      'location': location,
    };
  }

  // Rename this method to avoid conflict
  static SportsFieldApi? fromJsonMap(data) {
    if (data is Map<String, dynamic>) {
      return SportsFieldApi.fromJson(data);
    }
    return null;
  }
}