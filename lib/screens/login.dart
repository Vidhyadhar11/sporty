import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            Image.asset('assets/logo1.jpeg'), // Replace with your logo asset
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                style: const TextStyle(color: Colors.white), // White text color
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: const TextStyle(color: Colors.white), // White label color
                  filled: true,
                  fillColor: Colors.black, // Black background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white), // White border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white), // White border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white), // White border color
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Space between fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: true, // This ensures the text is obscured
                style: const TextStyle(color: Colors.white), // White text color
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.white), // White label color
                  filled: true,
                  fillColor: Colors.black, // Black background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white), // White border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white), // White border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white), // White border color
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // navigate to required page
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Button color
                foregroundColor: Colors.black, // Text color
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot-password'); // Navigate to Forgot Password Screen
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Navigate to Registration Screen
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
