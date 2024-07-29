import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporty/homepage/home.dart';
// ignore: depend_on_referenced_packages
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

    bool isVerified = await verifyOTP(phoneNumber, otp, orderId);
    if (isVerified) {
      Get.to(() => HomePage());
    } else {
      for (var controller in myController.otpControllers) {
        controller.clear();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  Future<bool> verifyOTP(String phoneNumber, String otp, String orderId) async {
    try {
      final response = await http.post(
        Uri.parse('https://f642-81-17-122-67.ngrok-free.app/verify'),
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
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['success'] == true;
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