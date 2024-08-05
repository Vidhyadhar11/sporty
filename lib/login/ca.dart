// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sporty/login/enterphn.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:get/get.dart';
import 'package:sporty/models/mycontroller.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   Mycontroller myController = Mycontroller(); // Create an instance

  bool _termsAccepted = false;
  bool _showError = false;

  final List<String> _sports = [
    'select',
    'football',
    'tennis',
    'badminton',
    'golf',
    'cricket',
    'swimming',
    'basketball'
  ];

  final List<String> _levels = ['select', 'beginner', 'intermediate', 'expert'];

  String? selectedLocation;

  final List<String> locations = [
    'Pachalam', 'Elamakkara', 'Cheranallur', 'Palarivattom', 'Edapally', 'Kaloor',
    'Marine Drive, Kochi', 'High Court Junction', 'Thevara', 'Panampilly Nagar',
    'Gandhi Nagar, Kochi', 'Ravipuram', 'Pachalam', 'Kathrikadavu', 'Thammanam',
    'Kadavanthra', 'Kaloor', 'Karanakodam', 'Ernakulam North', 'Ravipuram',
    'Ernakulam South', 'Kalabhavan Road', 'Willingdon Island', 'Fort Kochi',
    'Mattancherry', 'Thoppumpady', 'Palluruthy', 'Chellanam', 'Kumbalangi',
    'Kattiparambu', 'Kundannoor', 'Edakochi', 'Maradu', 'Thaikoodam metro station',
    'Chambakkara', 'Kakkanad', 'Vennala', 'Thrikkakara', 'Vyttila', 'Tripunithura',
    'Piravom', 'Kalamassery', 'Aluva', 'Angamaly', 'North Paravur', 'Eloor',
    'Koonammavu', 'Vaduthala', 'Vypin Island', 'Cherai', 'Kumbalam', 'Udayamperoor',
    'Panangad', 'Eramallur', 'Vaikom', 'Kothamangalam', 'Perumbavoor', 'Eroor',
    'Thiruvankulam', 'Kolenchery', 'Mamala', 'Kizhakkambalam', 'Piravom', 'Mulanthuruthy',
    'Chottanikkara'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(width: 40),
                            const Text(
                              'Create Account',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 24),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: myController.firstNameController
                                    .value, // Use the instance
                                label: 'First Name',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextField(
                                controller:
                                    myController.lastNameController.value,
                                label: 'Last Name',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _sports.contains(myController.intrestedsportsController.value.text)
                              ? myController.intrestedsportsController.value.text
                              : _sports[0], // Ensure the value is in the list
                          items: _sports.map((String sport) {
                            return DropdownMenuItem<String>(
                              value: sport,
                              child: Text(sport,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              myController.intrestedsportsController.value.text = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Interested sports',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          dropdownColor: const Color(
                              0xFF2C2C2C), // Set dropdown background color
                          isDense: true,
                          itemHeight:
                              48, // Adjust the height of each dropdown item
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _levels.contains(myController.levelController.value.text)
                              ? myController.levelController.value.text
                              : _levels[0], // Ensure the value is in the list
                          items: _levels.map((String level) {
                            return DropdownMenuItem<String>(
                              value: level,
                              child: Text(level,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              myController.levelController.value.text = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Level',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          dropdownColor: const Color(
                              0xFF2C2C2C), // Set dropdown background color
                          isDense: true,
                          itemHeight:
                              48, // Adjust the height of each dropdown item
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: myController.ageController.value,
                          label: 'Age',
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        CustomTextField(
                          controller: myController.noController.value,
                          label: 'Mobile Number',
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildDropdownSearch(
                          items: locations,
                          label: 'Select Location',
                          onChanged: (value) {
                            setState(() {
                              selectedLocation = value;
                              myController.locationController.value.text = value ?? '';
                            });
                          },
                          selectedItem: selectedLocation,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _termsAccepted,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _termsAccepted = newValue ?? false;
                                  _showError = !_termsAccepted;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'I understood the terms & policy.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        if (_showError)
                          const Text(
                            'You must accept the terms & policy to sign up.',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _termsAccepted
                            ? () {
                                // Handle sign up logic
                                _handlesignup();
                              }
                            : () {
                                setState(() {
                                  _showError = true;
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green,
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: const Row(
                          children: [
                            Text('Signup',
                                style: TextStyle(color: Colors.green)),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward, color: Colors.green),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownSearch({
    required List<String> items,
    required String label,
    required Function(String?) onChanged,
    required String? selectedItem,
  }) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Search $label",
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
        ),
        menuProps: MenuProps(
          backgroundColor: Colors.grey[800],
        ),
        itemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              item,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      items: items,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[900],
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onChanged: onChanged,
      selectedItem: selectedItem,
      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedItem ?? label,
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }

  void _handlesignup() async {
    // Collect data from controllers
    String firstName = myController.firstNameController.value.text;
    String lastName = myController.lastNameController.value.text;
    String age = myController.ageController.value.text;
    String phoneNumber = myController.noController.value.text;
    String interestedSports = myController.intrestedsportsController.value.text;
    String level = myController.levelController.value.text;
    String location = myController.locationController.value.text;

    // Prepare the data to be sent
    Map<String, dynamic> requestData = {
      'firstname': firstName,
      'lastname': lastName,
      'mobileno': phoneNumber,
      'intrestedsports': interestedSports,
      'level': level,
      'age': int.parse(age), // Ensure age is sent as an integer
      'location': location,
    };

    try {
      final response = await http.post(
        Uri.parse('https://3036-39-41-175-117.ngrok-free.app/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Handle successful signup, e.g., navigate to another screen
        Get.to(() => const EnterPhoneNumberScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error in HTTP request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }
}