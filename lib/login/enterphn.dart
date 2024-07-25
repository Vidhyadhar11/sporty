import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:sporty/login/ca.dart';
import 'package:sporty/login/otp.dart';
import 'package:sporty/uicomponents/mycontroller.dart'; // Required for TextInputFormatter
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        children:[
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
                    LengthLimitingTextInputFormatter(10), // Limit input to 10 digits
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
                      _phoneNumberValid =value.length == 10; // Validate phone number format
                      _maskedPhoneNumber =_getMaskedPhoneNumber(value); // Mask entered digits
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
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() =>const RegisterScreen());
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
                _handleProceed();
              },
              child: const Row(
                children: [
                  Text('Proceed',style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold,)),
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
  void _handleProceed() async {
    if (_phoneNumberValid) {
      String phoneNumber = myController.phoneNumberController.value.text;
      print('Phone number: $phoneNumber'); // Debugging line

      try {
        final response = await sendOTPToPhoneNumber(phoneNumber);
        if (response != null) {
          String otp = response['otp']!;
          Get.to(() => EnterOTPScreen(sentOTPController: TextEditingController(text: otp)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send OTP. Please try again.')),
          );
        }
      } catch (e) {
        print('Error sending OTP: $e'); // Debugging line
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid 10-digit number')),
      );
    }
  }

  Future<Map<String, String>?> sendOTPToPhoneNumber(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('https://c524-81-17-122-43.ngrok-free.app/sendotp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mobileno': '+91$phoneNumber',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'orderId': responseData['orderId'],
          'otp': responseData['otp'],
        };
      } else {
        print('Failed to send OTP. Status code: ${response.statusCode}'); // Debugging line
        return null;
      }
    } catch (e) {
      print('Error in HTTP request: $e'); // Debugging line
      return null;
    }
  }
}