import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sporty/drawer/drawermodel.dart';
import 'dart:convert';


class UserController extends GetxController {
  final Rx<UserModel> user = UserModel(
    id: '',
    firstname: '',
    lastname: '',
    profile: '',
    mobileno: '',
    intrestedsports: '',
    level: '',
    age: 0,
    isVerified: false,
  ).obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchUserDetails() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('https://10.0.2.2:3000/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        user.value = UserModel.fromJson(data);
      } else {
        Get.snackbar('Error', 'Failed to fetch user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in HTTP request: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}