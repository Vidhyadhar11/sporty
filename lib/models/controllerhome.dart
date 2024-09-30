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
      final response = await http.get(Uri.parse('http://65.1.5.180:3000/turf'));
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print('Raw data: $data');
        sportsFields.value =
            data.map((json) => SportsFieldApi.fromsnapshot(json)).toList();
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
  final RxList<SportsFieldApi> _likedFields = <SportsFieldApi>[].obs;
  final String userId = '8374013715';

  List<SportsFieldApi> get likedFields => _likedFields;

  @override
  void onInit() {
    super.onInit();
    fetchLikedFields();
  }

  bool isLiked(SportsFieldApi field) {
    return _likedFields.any((likedField) => likedField.id == field.id);
  }

  void toggleLike(SportsFieldApi field) async {
    if (isLiked(field)) {
      _likedFields.removeWhere((likedField) => likedField.id == field.id);
    } else {
      _likedFields.add(field);
    }
    await updateLikedFieldsInApi();
  }

  Future<void> fetchLikedFields() async {
    try {
      final response = await http.get(Uri.parse('http://65.1.5.180:3000/users/toggle-fav/$userId'));
      if (response.statusCode == 200) {
        var fields = json.decode(response.body) as List;
        _likedFields.value = fields.map((field) => SportsFieldApi.fromJsonMap(field)).toList() as List<SportsFieldApi>;
      } else {
        // Handle error
        print('Failed to fetch liked fields');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateLikedFieldsInApi() async {
    try {
      final response = await http.post(
        Uri.parse('http://65.1.5.180:3000/users/toggle-fav/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(_likedFields.map((field) => field.toJson()).toList()),
      );
      if (response.statusCode != 200) {
        // Handle error
        print('Failed to update liked fields');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
