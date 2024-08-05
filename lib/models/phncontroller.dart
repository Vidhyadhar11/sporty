import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/drawer/drawerview.dart';

class Phncontroller extends GetxController {
  static final phoneNumberController = TextEditingController().obs;
  static String get phoneNumber => phoneNumberController.value.text;

  static void setPhoneNumber(String number) {
    phoneNumberController.value.text = number;
  }
}
String getUserId() {
  final UserController userController = Get.find<UserController>();
  return userController.userId;
}