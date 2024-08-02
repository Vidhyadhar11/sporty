import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sporty/models/sports_feild.dart';
import 'dart:convert';

class SportsFieldController extends GetxController {
  var sportsFields = <SportsFieldApi>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSportsFields();
  }

  Future<void> fetchSportsFields() async {
    try {
      print('Fetching sports fields...');
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/turf'));
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print('Raw data: $data');
        sportsFields.value = data.map((json) => SportsFieldApi.fromsnapshot(json)).toList();
        isLoading.value = false;
        
        print('Fetched sports fields: ${sportsFields.value}');
      } else {
        throw Exception('Failed to load sports fields');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
      Get.snackbar('Error', 'Failed to load sports fields');
    }
  }
}

class LikedFieldsController extends GetxController {
  final RxList<SportsFieldApi> likedFields = <SportsFieldApi>[].obs;

  void toggleLike(SportsFieldApi field) {
    field.isLiked = !field.isLiked;
    if (field.isLiked) {
      likedFields.add(field);
    } else {
      likedFields.removeWhere((f) => f.turfName == field.turfName);
    }
    update();
  }
}