import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
         onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()),
            );
         }
        ),
        title: Container(), // Remove the title from the AppBar
      ),
      body: Column(
        children: [
          // Booking title below the back button
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Bookings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ToggleButton(
            leftLabel: 'Previous',
            rightLabel: 'Upcoming',
            onToggle: (isLeftSelected) {
              setState(() {
                showUpcoming = !isLeftSelected;
              });
            },
          ),
          Expanded(
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4, // Replace this with your actual count of items
                itemBuilder: (context, index) {
                  return BookingCard(showUpcoming);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final bool showUpcoming;

  BookingCard(this.showUpcoming);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.asset('assets/images/field.jpg'), // Use the local image
        title: Text(
          showUpcoming
              ? 'Star Strikers (Upcoming)'
              : 'Star Strikers (Previous)',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('KPHB, Hyderabad', style: TextStyle(color: Colors.white)),
            Text('20 Thursday 6pm-7pm', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}