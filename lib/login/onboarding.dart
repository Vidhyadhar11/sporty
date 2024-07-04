import 'package:flutter/material.dart';
//import 'package:sporty/screens/login.dart';
import 'package:sporty/login/enterphn.dart';
class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<String> imgList = [
    'assets/Cricket.gif',
    'assets/Badminton.gif',
    'assets/Beach volleyball.gif',
    'assets/Soccer.gif'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return CarouselImage(
                  imagePath: imgList[index],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'WELCOME TO THE CLUB!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height:10),
          const Text(
            'book places',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const Text(
            'play games',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EnterPhoneNumberScreen()),
              );
            },
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}

class CarouselImage extends StatefulWidget {
  final String imagePath;

  const CarouselImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          widget.imagePath,
          key: UniqueKey(), // Forces the widget to rebuild and reload the GIF
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}