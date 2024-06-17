import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Image.asset('assets/assets/file_2024-06-17_16.48.13.png'), // Replace with your logo asset
            const SizedBox(height: 20),
            
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Phone',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle OTP send
              },
              child: const Text('Send OTP'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Button color
                foregroundColor: Colors.black, // Text color
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigate to registration screen
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                "Don't have an account? Sign up",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
