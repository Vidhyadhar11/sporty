
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporty/login/enterphn.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:get/get.dart';
import 'package:sporty/uicomponents/mycontroller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Mycontroller myController = Mycontroller(); // Create an instance


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

  final List<String> _levels = [
    'select',
    'beginner',
    'intermediate',
    'expert'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => SingleChildScrollView(
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
                              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(width: 40),
                            const Text(
                              'Create Account',
                              style: TextStyle(color: Colors.green, fontSize: 24),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: myController.firstNameController.value, // Use the instance
                                label: 'First Name',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextField(
                                controller: myController.lastNameController.value,
                                label: 'Last Name',
                              ),
                            
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: myController.selectedSport.value,
                          items: _sports.map((String sport) {
                            return DropdownMenuItem<String>(
                              value: sport,
                              child: Text(sport, style: const TextStyle(color: Colors.white, fontSize: 14)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              myController.selectedSport.value = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Interested sports',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          dropdownColor: const Color(0xFF2C2C2C), // Set dropdown background color
                          isDense: true,
                          itemHeight: 48, // Adjust the height of each dropdown item
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: myController.selectedLevel.value,
                          items: _levels.map((String level) {
                            return DropdownMenuItem<String>(
                              value: level,
                              child: Text(level, style: const TextStyle(color: Colors.white, fontSize: 14)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              myController.selectedLevel.value = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Level',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          dropdownColor: const Color(0xFF2C2C2C), // Set dropdown background color
                          isDense: true,
                          itemHeight: 48, // Adjust the height of each dropdown item
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
                                Get.to(() => EnterPhoneNumberScreen());
                              }
                            : () {
                                setState(() {
                                  _showError = true;
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green,
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: const Row(
                          children: [
                            Text('Signup', style: TextStyle(color: Colors.green)),
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
}