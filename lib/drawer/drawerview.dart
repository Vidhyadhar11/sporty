import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sporty/booking/bookings1.dart';
import 'package:sporty/drawer/favorite.dart';
import 'package:sporty/drawer/rewards.dart';
import 'package:sporty/login/enterphn.dart';

class UserModel {
  static String id = '';
  static String firstname = '';
  static String lastname = '';
  static String profile = '';
  static String mobileno = '';
  static String intrestedsports = '';
  static String level = '';
  static int age = 0;
  static String location = '';
  static String otpOrderId = '';

  static void updateFromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    firstname = json['firstname'] ?? '';
    lastname = json['lastname'] ?? '';
    profile = json['profile'] ?? '';
    mobileno = json['mobileno'] ?? '';
    intrestedsports = json['intrestedsports'] ?? '';
    level = json['level'] ?? '';
    age = json['age'] ?? 0;
    location = json['location'] ?? '';
    otpOrderId = json['otpOrderId'] ?? '';
  }

  static bool get isEmpty => id.isEmpty;

  // Add a method to get the user ID
  static String getUserId() {
    return id;
  }
}

class UserController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  Timer? _retryTimer;
  int _retryCount = 0;
  static const int maxRetries = 3;
  static const int retryDelay = 5; // seconds

  // Add a getter for the user ID
  String get userId => UserModel.getUserId();

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  @override
  void onClose() {
    _retryTimer?.cancel();
    super.onClose();
  }

  Future<void> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('phoneNumber');
    print('Fetching user details for phone number: $phoneNumber');
    print('API URL: http://65.1.5.180:3000/users/$phoneNumber');
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    try {
      final response = await http.get(
        Uri.parse('http://65.1.5.180:3000/users/$phoneNumber'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 10));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        UserModel.updateFromJson(userData);
        print('User details fetched successfully: ${UserModel.firstname}');
        print('User ID set: ${UserModel.getUserId()}');
        _resetRetry();
      } else {
        throw Exception(
            'Failed to fetch user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in HTTP request: $e');
      hasError.value = true;
      errorMessage.value = 'An error occurred: ${e.toString()}';
      _scheduleRetry();
    } finally {
      isLoading.value = false;
    }
  }

  void _scheduleRetry() {
    if (_retryCount < maxRetries) {
      _retryCount++;
      print(
          'Scheduling retry $_retryCount of $maxRetries in $retryDelay seconds');
      _retryTimer =
          Timer(const Duration(seconds: retryDelay), fetchUserDetails);
    } else {
      print('Max retries reached. User interaction required.');
    }
  }

  void _resetRetry() {
    _retryCount = 0;
    _retryTimer?.cancel();
  }

  void manualRetry() {
    _resetRetry();
    fetchUserDetails();
  }
}

class Drawerview extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  Drawerview({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${controller.errorMessage.value}'),
              if (controller._retryCount < UserController.maxRetries)
                Text(
                    'Retrying... (${controller._retryCount + 1}/${UserController.maxRetries})'),
              if (controller._retryCount >= UserController.maxRetries)
                ElevatedButton(
                  onPressed: controller.manualRetry,
                  child: const Text('Retry Manually'),
                ),
            ],
          );
        }

        if (UserModel.isEmpty) {
          return const Center(child: Text('No user data available'));
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(UserModel.profile),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${UserModel.firstname} ${UserModel.lastname}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                UserModel.mobileno,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Get.to(() => BookingScreen()),
                child: const Text(
                  'Booking',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Get.to(() => FavoriteScreen()),
                child: const Text(
                  'Favorites',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Get.to(() => RewardsPage()),
                child: const Text(
                  'Rewards',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('phoneNumber');
                  Get.to(() => const EnterPhoneNumberScreen());
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const Text(
                'Version 1.0.0',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      }),
    );
  }
}
