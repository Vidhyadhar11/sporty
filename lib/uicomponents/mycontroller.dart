import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mycontroller extends GetxController {
  final Rx<TextEditingController> firstNameController = TextEditingController().obs;
  final Rx<TextEditingController> lastNameController = TextEditingController().obs;
  final Rx<TextEditingController> ageController = TextEditingController().obs;
  final Rx<TextEditingController> noController = TextEditingController().obs;
  Rx<String?> selectedSport = 'select'.obs;
  Rx<String?> selectedLevel = 'select'.obs;
}
