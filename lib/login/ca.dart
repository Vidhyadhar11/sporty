import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporty/uicomponents/elements.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool _football = false;
  bool _tennis = false;
  bool _badminton = false;
  bool _golf = false;
  bool _cricket = false;
  bool _swimming = false;
  bool _basketball = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(color: Colors.green, fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _firstNameController,
                          label: 'First Name',
                        ),
                        CustomTextField(
                          controller: _lastNameController,
                          label: 'Last Name',
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Interested sports',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: _football,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _football = newValue ?? false;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'Football',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _tennis,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _tennis = newValue ?? false;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'Tennis',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _badminton,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _badminton = newValue ?? false;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'Badminton',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _golf,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _golf = newValue ?? false;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'Golf',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _cricket,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _cricket = newValue ?? false;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'Cricket',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _swimming,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _swimming = newValue ?? false;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'Swimming',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _basketball,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _basketball = newValue ?? false;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'Basketball',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        CustomTextField(
                          controller: _ageController,
                          label: 'Age',
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Handle sign up logic
                          },
                           child: const Text('Signup', style: TextStyle(color: Colors.green)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}