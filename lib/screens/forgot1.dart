import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for TextInputFormatter and FilteringTextInputFormatter
import 'forgot2.dart'; // Import the second screen

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorMessage;

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
                  const SizedBox(height: 20),
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cursive', // Adjust font family as needed
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/logo1.jpeg', height: 150), // Adjust image path and size as needed
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Enter Mobile',
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  if (_errorMessage != null) // Display error message if it exists
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_phoneController.text.length == 10) {
                          _errorMessage = null;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ForgotPasswordScreen2()),
                          );
                        } else {
                          _errorMessage = 'Invalid phone number';
                        }
                      });
                    },
                    child: const Text('Send OTP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow, // Button color
                      foregroundColor: Colors.black, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Adjust padding as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                      ),
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
