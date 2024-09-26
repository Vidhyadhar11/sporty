import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/homepage/home.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool showUpcoming = true;
  bool isLoading = true;
  List<dynamic> upcomingBookings = [];
  List<dynamic> pastBookings = [];

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    setState(() {
      isLoading = true;
    });

    try {
      final upcomingResponse = await http
          .get(Uri.parse('http://65.1.5.180:3000/booking/upcomingBookings'));
      final pastResponse = await http
          .get(Uri.parse('http://65.1.5.180:3000/booking/pastBookings'));

      if (upcomingResponse.statusCode == 200 &&
          pastResponse.statusCode == 200) {
        setState(() {
          upcomingBookings = json.decode(upcomingResponse.body);
          pastBookings = json.decode(pastResponse.body);
          isLoading = false;
        });
        print('Upcoming bookings fetched successfully: $upcomingBookings');
        print('Past bookings fetched successfully: $pastBookings');
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () {
                          Get.to(() => const HomePage());
                        },
                      ),
                    ),
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: showUpcoming
                          ? upcomingBookings.length
                          : pastBookings.length,
                      itemBuilder: (context, index) {
                        var booking = showUpcoming
                            ? upcomingBookings[index]
                            : pastBookings[index];
                        return BookingCard(
                          showUpcoming: showUpcoming,
                          imageUrl: booking['imageUrl'] ??
                              'https://via.placeholder.com/150',
                          title: booking['turfName'] ?? 'Unknown Turf',
                          location: booking['location'] ?? 'Unknown Location',
                          time:
                              '${booking['date'] ?? 'Unknown Date'} - ${booking['slot'] ?? 'Unknown Time'}',
                        );
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
  final String imageUrl;
  final String title;
  final String location;
  final String time;

  const BookingCard({
    super.key,
    required this.showUpcoming,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    showUpcoming ? '$title (Upcoming)' : '$title (Previous)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(location, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 4),
                  Text(time, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
