import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporty/homepage/home.dart';
import 'package:get/get.dart';
import 'package:sporty/models/mycontroller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnterOTPScreen extends StatefulWidget {
  final TextEditingController phoneController;
  final String orderId;

  const EnterOTPScreen({super.key, required this.orderId, required this.phoneController});

  @override
  // ignore: library_private_types_in_public_api
  _EnterOTPScreenState createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  final Mycontroller myController = Mycontroller();

  @override
  void initState() {
    super.initState();
    // Print statements to check if data is received
    print('Phone number received: ${widget.phoneController.text}');
    print('Order ID received: ${widget.orderId}');
  }

  void _handleVerifyOTP() async {
    String otp = myController.otpControllers.map((controller) => controller.text).join();
    String phoneNumber = widget.phoneController.text;
    String orderId = widget.orderId;

    print('Verifying OTP for phone number: $phoneNumber with order ID: $orderId and OTP: $otp');

    try {
      bool isVerified = await verifyOTP(phoneNumber, otp, orderId);
      print('OTP verification result: $isVerified');

      await Future.delayed(const Duration(milliseconds: 500)); // Add a delay to ensure all print statements are visible

      if (isVerified) {
        print('OTP verified successfully. Navigating to HomePage...');
        await Get.off(() => HomePage());
        print('Navigation to HomePage completed');
      } else {
        print('OTP verification failed. Clearing input fields...');
        for (var controller in myController.otpControllers) {
          controller.clear();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP')),
        );
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  Future<bool> verifyOTP(String phoneNumber, String otp, String orderId) async {
    try {
      print('Sending verification request for:');
      print('Phone: $phoneNumber');
      print('OTP: $otp');
      print('OrderID: $orderId');

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/verify'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'mobileno': phoneNumber,
          'orderId': orderId,
          'otp': otp,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Raw response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Decoded response data: $responseData');
        
        if (responseData.containsKey('isOTPVerified')) {
          bool isVerified = responseData['isOTPVerified'] == true;
          print('isOTPVerified key found. Value: $isVerified');
          if (!isVerified && responseData.containsKey('error')) {
            print('Verification failed. Reason: ${responseData['error']}');
          }
          return isVerified;
        } else if (responseData.containsKey('message')) {
          bool isVerified = responseData['message'] == "User verified successfully";
          print('message key found. Interpreted as verified: $isVerified');
          return isVerified;
        } else {
          print('Unexpected response format');
          return false;
        }
      } else {
        print('Failed to verify OTP. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error in HTTP request: $e');
      return false;
    }
  }

  @override
  void dispose() {
    for (var controller in myController.otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
                  'Enter OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          controller: myController.otpControllers[index],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.length == 1 && index < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                            if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                        ),
                      ),
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
              onTap: _handleVerifyOTP,
              child: const Row(
                children: [
                  Text(
                    'Verify',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
}