import 'package:flutter/material.dart';

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
            Navigator.pop(context); // Go back to the previous screen
          },
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
          Container(
            width: 260,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2C),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showUpcoming = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 260,
                          height: 100,
                          decoration: BoxDecoration(
                            color: showUpcoming ? Colors.transparent : const Color(0xFF39FF14),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Previous',
                              style: TextStyle(
                                color: showUpcoming ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showUpcoming = true;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 260,
                          height: 100,
                          decoration: BoxDecoration(
                            color: showUpcoming ? const Color(0xFF39FF14) : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Upcoming',
                              style: TextStyle(
                                color: showUpcoming ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
