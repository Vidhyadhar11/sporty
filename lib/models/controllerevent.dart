import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventController extends GetxController {
  var isLoading = true.obs;
  var sportsFields = <EventSportsField>[].obs;

  @override
  void onInit() {
    fetchSportsField();
    super.onInit();
  }

  void fetchSportsField() async {
    print('Fetching sports fields...');
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://your-api-endpoint.com/sportsfields'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('Fetched data: $data');
        sportsFields.value = (data as List).map((field) => EventSportsField.fromJson(field)).toList();
      } else {
        throw Exception('Failed to load sports fields');
      }
    } catch (e) {
      print('Error fetching sports fields: $e');
    } finally {
      isLoading(false);
    }
  }
}

class EventSportsField {
  final String imageUrl;
  final String category;
  final String turfName;
  final String location;
  final double rating;
  final int courts;
  final int discounts;

  EventSportsField({
    required this.imageUrl,
    required this.category,
    required this.turfName,
    required this.location,
    required this.rating,
    required this.courts,
    required this.discounts,
  });

  factory EventSportsField.fromJson(Map<String, dynamic> json) {
    return EventSportsField(
      imageUrl: json['imageUrl'],
      category: json['category'],
      turfName: json['turfName'],
      location: json['location'],
      rating: json['rating'].toDouble(),
      courts: json['courts'],
      discounts: json['discounts'],
    );
  }
}