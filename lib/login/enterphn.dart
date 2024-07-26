import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sporty/login/ca.dart';
import 'package:sporty/login/otp.dart';
import 'package:sporty/models/mycontroller.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  const EnterPhoneNumberScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EnterPhoneNumberScreenState createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {

  final Mycontroller myController = Mycontroller();
  bool _phoneNumberValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Tell us your\nmobile number',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  TextField(
                    controller: myController.phoneNumberController.value,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    style: const TextStyle(color: Colors.white),
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
                        _phoneNumberValid = value.length == 10;
                      });
                    },
                  ),


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
                      Get.to(() => const RegisterScreen());
                    },
                    child: const Text('Create Account',style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),
                    ),
                  ),
                ],
              ),
            ),


            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: _handleProceed,
                child: const Row(
                  children: [
                    Text('Proceed',style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.green),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleProceed() async {
    if (_phoneNumberValid) {
      String phoneNumber = myController.phoneNumberController.value.text;
      print('Phone number: $phoneNumber');

      // Navigate to OTP screen immediately
      Get.to(() => EnterOTPScreen(sentOTPController: TextEditingController(), orderId: ''));
      try {
        final response = await sendOTPToPhoneNumber(phoneNumber);
        if (response != null) {
          String otp = response['otp']!;
          String orderId = response['orderId']!;
          Get.to(() => EnterOTPScreen(sentOTPController: TextEditingController(text: otp), orderId: orderId));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send OTP. Please try again.')),
          );
        }
      } catch (e) {
        print('Error sending OTP: $e');
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
        Uri.parse('https://3036-39-41-175-117.ngrok-free.app/sendotp'),
        body: jsonEncode(<String, String>{
          'mobileno': '+91$phoneNumber',
        }),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey('orderId') && responseData.containsKey('otp')) {
          return {
            'orderId': responseData['orderId'],
            'otp': responseData['otp'],
          };
        } else {
          print('Response data does not contain required keys');
          return null;
        }
      } else {
        print('Failed to send OTP. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error in HTTP request: $e');
      return null;
    }
  }
}