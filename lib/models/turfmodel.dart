class Turf {
  final String name;
  final String location;
  final double rating;
  final int price;
  final String imageUrl;
  final String discount;
  final String sportType;

  Turf({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.discount,
    required this.sportType,
  });

  factory Turf.fromJson(Map<String, dynamic> json) {
    return Turf(
      name: json['turfname'],
      location: json['location'],
      rating: double.parse(json['rating']),
      price: json['slots'][0]['price'], // Assuming you want the first slot's price
      imageUrl: json['images'],
      discount: json['discounts'].toString() + '% Off',
      sportType: json['category'],
    );
  }
}
