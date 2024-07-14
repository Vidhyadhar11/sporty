import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporty/login/enterphn.dart';
import 'package:sporty/uicomponents/elements.dart';


import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedSport;
  String? _selectedLevel;
  bool _termsAccepted = false;
  bool _showError = false;

  final List<String> _sports = [
    'football',
    'tennis',
    'badminton',
    'golf',
    'cricket',
    'swimming',
    'basketball'
  ];

  final List<String> _levels = [
    'beginner',
    'intermediate',
    'expert'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.green, fontSize: 24),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _firstNameController,
                        label: 'First Name',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        controller: _lastNameController,
                        label: 'Last Name',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height : 10),
                DropdownButtonFormField<String>(
                  value: _selectedSport,
                  items: _sports.map((String sport) {
                    return DropdownMenuItem<String>(
                      value: sport,
                      child: Text(sport, style: const TextStyle(color: Colors.white, fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSport = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Interested sports',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  dropdownColor: const Color(0xFF2C2C2C), // Set dropdown background color
                  isDense: true,
                  itemHeight: 48, // Adjust the height of each dropdown item
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedLevel,
                  items: _levels.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level, style: const TextStyle(color: Colors.white, fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLevel = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Level',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  dropdownColor: const Color(0xFF2C2C2C), // Set dropdown background color
                  isDense: true,
                  itemHeight: 48, // Adjust the height of each dropdown item
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _ageController,
                  label: 'Age',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                 CustomTextField(
                  controller: _ageController,
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
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
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
                child: const Text('Signup', style: TextStyle(color: Colors.green)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}