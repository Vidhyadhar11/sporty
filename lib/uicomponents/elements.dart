import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class CustomNavBar extends StatefulWidget {
  final Function(int) onTap;
  final int currentIndex;

  const CustomNavBar({Key? key, required this.onTap, required this.currentIndex}) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
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
            IconButton(
              icon: Icon(Icons.home, color: widget.currentIndex == 0 ? Colors.green : Colors.grey),
              onPressed: () => widget.onTap(0),
            ),
            IconButton(
              icon: Icon(Icons.sports_soccer, color: widget.currentIndex == 1 ? Colors.green : Colors.grey),
              onPressed: () => widget.onTap(1),
            ),
            IconButton(
              icon: Icon(Icons.event, color: widget.currentIndex == 2 ? Colors.green : Colors.grey),
              onPressed: () => widget.onTap(2),
            ),
            IconButton(
              icon: Icon(Icons.people, color: widget.currentIndex == 3 ? Colors.green : Colors.grey),
              onPressed: () => widget.onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}