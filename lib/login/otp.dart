import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporty/homepage/home.dart';
import 'package:get/get.dart';
import 'package:sporty/models/mycontroller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';
import 'dart:io';

class EnterOTPScreen extends StatefulWidget {
  final String orderId;
  final String phoneNumber;

  EnterOTPScreen({
    super.key,
    required this.orderId,
    required this.phoneNumber,
  });

  @override
  _EnterOTPScreenState createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  final Mycontroller myController = Mycontroller();
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    // Print statements to check if data is received
    print('Phone number received: ${widget.phoneNumber}');
    print('Order ID received: ${widget.orderId}');
  }

  void _verifyOTP() async {
    String enteredOTP = myController.otpControllers.map((c) => c.text).join();
    print('Entered OTP: $enteredOTP');
    try {
      final response = await verifyOTP(widget.phoneNumber, enteredOTP, widget.orderId);
      print('Verification response: $response');
      if (response != null && response['message'] == "User verified successfully") {
        print('OTP verified successfully');
        Get.offAll(() => const HomePage());
      } else {
        print('OTP verification failed');
        Get.snackbar('Error', 'Invalid OTP. Please try again.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<Map<String, dynamic>?> verifyOTP(String phoneNumber, String otp, String orderId) async {
    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      final http = IOClient(ioc);

      const url = 'http://13.233.98.192:3000/verify';
      print('Sending request to: $url');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'mobileno': phoneNumber,
          'otp': otp,
          'orderId': orderId,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        print('Decoded response: $decodedResponse');
        return decodedResponse;
      } else {
        print('Failed to verify OTP. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error in HTTP request: $e');
      return null;
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
              onTap: _verifyOTP,
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