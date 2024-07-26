import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    'assets/Cricket-pana.png', 
    'assets/Badminton-bro.png',
    'assets/Beach volleyball-bro.png',
    'assets/Soccer-bro.png',
    'assets/basketball player-bro.png',
    'assets/swimming.png',
    'assets/Tennis-bro.png',
    'assets/Golf-bro.png',
    'assets/Grand slam-bro.png',
  ];

  void _onSportSelected(String sportImage) {
    switch (sportImage) {
      case 'assets/Cricket-pana.png':
        // Navigate to Cricket screen or perform Cricket-specific action
        Get.to(() => const TestPage());
        break;
      case 'assets/Badminton-bro.png':
        // Navigate to Badminton screen or perform Badminton-specific action
       Get.to(() => const TestPage());
        break;
      case 'assets/Beach volleyball-bro.png':
        // Navigate to Beach Volleyball screen or perform Beach Volleyball-specific action
        Get.to(() => const TestPage());
        break;
      case 'assets/Soccer-bro.png':
        // Navigate to Soccer screen or perform Soccer-specific action
        Get.to(() => const TestPage());
        break;
      case 'assets/Golf-bro.png':
        // Navigate to Golf screen or perform Golf-specific action
        Get.to(() => const TestPage());
        break;
      case 'assets/Tennis-bro.png':
        // Navigate to Tennis screen or perform Tennis-specific action
        Get.to(() => const TestPage());
        break;
      case 'assets/swimming.png':
        // Navigate to Swimming screen or perform Swimming-specific action
        Get.to(() => const TestPage());
        break;
      case 'assets/basketball player-bro.png':
        // Navigate to Basketball screen or perform Basketball-specific action
        Get.to(() => const TestPage());
        break;
      case 'assets/Grand slam-bro.png':
        // Navigate to Grand Slam screen or perform Grand Slam-specific action
        Get.to(() => const TestPage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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
            const SizedBox(height: 20),
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
                        // color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: AssetImage(sportsImages[index]),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomNavBar(currentIndex: 1),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

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
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
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