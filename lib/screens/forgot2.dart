import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen2 extends StatefulWidget {
  const ForgotPasswordScreen2({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreen2State createState() => _ForgotPasswordScreen2State();
}

class _ForgotPasswordScreen2State extends State<ForgotPasswordScreen2> {
  final List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

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
                    'OTP Verification',
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
                  const Text(
                    'Please Enter OTP here',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: 50,
                          child: TextField(
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(1),
                            ],
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 24),
                            decoration: InputDecoration(
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
                            onChanged: (value) {
                              if (value.length == 1 && index < 3) {
                                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                              }
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle OTP verification logic here
                    },
                    child: const Text('Verify OTP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow, // Button color
                      foregroundColor: Colors.black, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Adjust padding as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Handle resend OTP logic here
                    },
                    child: const Text(
                      'Resend OTP?',
                      style: TextStyle(color: Colors.white),
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
