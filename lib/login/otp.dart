import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for TextInputFormatter

class EnterOTPScreen extends StatefulWidget {
  @override
  _EnterOTPScreenState createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  String _enteredOTP = ''; // Holds the entered OTP
  bool _otpValid = true; // Validation flag for OTP format

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _enteredOTP.length > index ? _enteredOTP[index] : '',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4), // Limit input to 4 digits
                  ],
                  style: const TextStyle(color: Colors.white),
                  obscureText: true, // Hides entered digits with '*'
                  decoration: const InputDecoration(
                    labelText: 'OTP',
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
                      _otpValid = value.length == 4; // Validate OTP format
                      _enteredOTP = value; // Store entered OTP
                    });
                  },
                ),
                const SizedBox(height: 8),
                if (!_otpValid)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Enter a valid 4-digit OTP',
                      style: TextStyle(color: Colors.red),
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
                // Verify OTP logic here
                _handleVerifyOTP();
              },
              child: const Text(
                'Verify',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Handle verify OTP action (e.g., check against server)
  void _handleVerifyOTP() {
    // Simulated verification logic - Replace with actual logic
    if (_enteredOTP == '1234') {
      // OTP is valid, proceed to next screen or action
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('OTP Verified'),
            content: const Text('You have successfully verified your OTP.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to the next screen after OTP verification
                  // Example:
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => NextPage()),
                  // );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // OTP is invalid, show error message
      setState(() {
        _otpValid = false;
      });
    }
  }
}
