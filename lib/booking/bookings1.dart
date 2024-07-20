import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/homepage/home.dart';
import 'package:sporty/uicomponents/elements.dart'; // Import the ToggleButton widget

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                         onPressed: () {
                  Get.to(() => const HomePage());
                         }
                        ),
              ),
              // Booking title below the back button
              const Text(
                'Bookings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ToggleButton(
                leftLabel: 'Previous',
                rightLabel: 'Upcoming',
                onToggle: (isLeftSelected) {
                  setState(() {
                    showUpcoming = !isLeftSelected;
                  });
                },
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 10, // Replace this with your actual count of items
                itemBuilder: (context, index) {
                  return BookingCard(showUpcoming);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final bool showUpcoming;

  BookingCard(this.showUpcoming);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network('https://imgs.search.brave.com/zN2JDwLs9UxC0UGzY3mIqh_C1SxfAo6Vt5EUPwwRnMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Ry/b3R1cmYuY29tL3N0/YXRpYy85NDMxNTZm/YmQ1ODg3NWEyMDZl/ZjdkMGMxMmJlY2Yz/NS8xM2U0My9VVFNB/LmpwZw', width: 150, height: 150,),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(
              showUpcoming
                  ? 'Star Strikers (Upcoming)'
                  : 'Star Strikers (Previous)',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text('KPHB, Hyderabad', style: TextStyle(color: Colors.white)),
            const Text('20 Thursday 6pm-7pm', style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
    // return Card(
    //   color: Colors.black,
    //   margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    //   child: ListTile(
    //     leading: Image.network('https://imgs.search.brave.com/zN2JDwLs9UxC0UGzY3mIqh_C1SxfAo6Vt5EUPwwRnMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Ry/b3R1cmYuY29tL3N0/YXRpYy85NDMxNTZm/YmQ1ODg3NWEyMDZl/ZjdkMGMxMmJlY2Yz/NS8xM2U0My9VVFNB/LmpwZw'), // Use the local image
    //     title: Text(
    //       showUpcoming
    //           ? 'Star Strikers (Upcoming)'
    //           : 'Star Strikers (Previous)',
    //       style: const TextStyle(
    //         fontSize: 16,
    //         fontWeight: FontWeight.bold,
    //         color: Colors.white,
    //         // decoration: TextDecoration.underline,
    //       ),
    //     ),
     

  }
}