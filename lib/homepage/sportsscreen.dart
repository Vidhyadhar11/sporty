import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sporty/homepage/testpage.dart';
import 'package:sporty/uicomponents/elements.dart';

class SportsScreen extends StatefulWidget {
  @override
  _SportsScreenState createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> sportsImages = [
    'assets/Cricket.gif',
    'assets/Badminton.gif',
    'assets/Beach volleyball.gif',
    'assets/Soccer.gif',
    'assets/Golf.gif',
    'assets/Grand slam.gif',
  ];

  void _onSportSelected(String sportImage) {
    switch (sportImage) {
      case 'assets/Cricket.gif':
        // Navigate to Cricket screen or perform Cricket-specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestPage()),
        );
        break;
      case 'assets/Badminton.gif':
        // Navigate to Badminton screen or perform Badminton-specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestPage()),
        );
        break;
      case 'assets/Beach volleyball.gif':
        // Navigate to Beach Volleyball screen or perform Beach Volleyball-specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestPage()),
        );
        break;
      case 'assets/Soccer.gif':
        // Navigate to Soccer screen or perform Soccer-specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestPage()),
        );
        break;
      case 'assets/Golf.gif':
        // Navigate to Golf screen or perform Golf-specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestPage()),
        );
        break;
      case 'assets/Grand slam.gif':
        // Navigate to Grand Slam screen or perform Grand Slam-specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              controller: searchController,
              label: 'Search',
              inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Select another sport',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: sportsImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _onSportSelected(sportsImages[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                        image: AssetImage(sportsImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 1),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  }) : super(key: key);

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
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}