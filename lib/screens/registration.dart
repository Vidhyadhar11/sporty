import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10), // Adjust padding as needed
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white), // iOS-style back icon, white color
                  onPressed: () => Navigator.of(context).pop(), // Pop the current route
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo1.jpeg', height: 100),
                  const SizedBox(height: 20),
                  const Text(
                    'Create your account',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _firstNameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _lastNameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _mobileController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Mobile',
                            labelStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _ageController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _dobController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Date of Birth',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
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
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'I understand the terms & policy',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Handle sign up logic
                          },
                          child: const Text('Sign Up'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
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
