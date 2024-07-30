import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class Mycontroller extends GetxController {
  final Rx<TextEditingController> firstNameController = TextEditingController().obs;
  final Rx<TextEditingController> lastNameController = TextEditingController().obs;
  final Rx<TextEditingController> ageController = TextEditingController().obs;
  final Rx<TextEditingController> noController = TextEditingController().obs;
  final Rx<TextEditingController> intrestedsportsController = TextEditingController().obs;
  final Rx<TextEditingController> levelController = TextEditingController().obs;
  final RxList<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController()).obs;
  final Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<String?> selectedSport = 'select'.obs;
  Rx<String?> selectedLevel = 'select'.obs;
  var isFavorite = false.obs;
  var isLoading = true.obs;

}