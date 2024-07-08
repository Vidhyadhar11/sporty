import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporty/homepage/bookings1.dart';
import 'package:sporty/homepage/home.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({Key? key,required this.controller,required this.label,this.keyboardType = TextInputType.text,this.inputFormatters,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


//add navbar component here with new class

class CustomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home, 0, context),
            _buildNavItem(Icons.sports_soccer, 1, context),
            _buildNavItem(Icons.event, 2, context),
            _buildNavItem(Icons.people, 3, context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: currentIndex == index ? Colors.green : Colors.grey),
      onPressed: () {
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
            break;
        }
      },
    );
  }
}