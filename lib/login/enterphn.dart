import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:sporty/login/ca.dart';
import 'package:sporty/login/otp.dart';
import 'package:sporty/uicomponents/mycontroller.dart'; // Required for TextInputFormatter

class EnterPhoneNumberScreen extends StatefulWidget {
  @override
  _EnterPhoneNumberScreenState createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {
  final Mycontroller myController = Mycontroller(); // Add this line
  String _maskedPhoneNumber = ''; // Holds the masked phone number
  bool _phoneNumberValid = true; // Validation flag for phone number format

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'tell us your\nmobile number',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: myController.phoneNumberController.value, // Add this line
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(
                        10), // Limit input to 10 digits
                  ],
                  style: const TextStyle(color: Colors.white),
                  obscureText: true, // Hides entered digits with '*'
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _phoneNumberValid =
                          value.length == 10; // Validate phone number format
                      _maskedPhoneNumber =
                          _getMaskedPhoneNumber(value); // Mask entered digits
                    });
                  },
                ),
                const SizedBox(height: 8),
                if (!_phoneNumberValid)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Enter a valid 10-digit number',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(
                    height: 20), // Add some space before the new text
                GestureDetector(
                  onTap: () {
                    // Handle create account action here
                    Get.to(() =>
                        const RegisterScreen()); // Navigate to CreateAccountScreen
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Proceed button logic here
                _handleProceed();
              },
              child: const Row(
                children: [
                  Text('Proceed',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: Colors.green),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to mask entered phone number with asterisks
  String _getMaskedPhoneNumber(String text) {
    String maskedText = '';
    for (int i = 0; i < text.length; i++) {
      maskedText += '*'; // Replace each entered digit with '*'
    }
    return maskedText;
  }

  // Handle proceed action (e.g., clear fields)
  void _handleProceed() {
    if (_phoneNumberValid) {
      String otp = generateRandomOTP();
      String phoneNumber = myController.phoneNumberController.value.text;
      sendOTPToPhoneNumber(phoneNumber, otp);
      Get.to(() => EnterOTPScreen(sentOTPController: TextEditingController(text: otp)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid 10-digit number')),
      );
    }
  }

  String generateRandomOTP() {
    return '';
  }
  void sendOTPToPhoneNumber(String phoneNumber, String otp) {}
}