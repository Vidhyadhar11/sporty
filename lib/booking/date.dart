import 'package:flutter/material.dart';

import 'package:sporty/payment/singlepay.dart';
// import 'package:sporty/payment/joinpay.dart';
import 'package:sporty/models/phncontroller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:table_calendar/table_calendar.dart';

class BookingPage extends StatefulWidget {
  BookingPage({
    super.key,
    required this.turfRate,
    required this.turfId,
    this.slots = const [],
    required this.numberOfCourts,
    this.turfName, // Make this optional
    required this.ownerMobileNumber,
  }) {
    print('BookingPage constructor called with turfName: $turfName');
  }

  final double turfRate;
  final String turfId;
  final List<Map<String, dynamic>> slots;
  final int numberOfCourts;
  final String? turfName; // Make this nullable
  final String ownerMobileNumber;
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  int? selectedSlotIndex;
  int? selectedCourtIndex;
  bool playWithStrangers = false;
  TextEditingController _totalMembersController = TextEditingController();
  TextEditingController _remainingMembersController = TextEditingController();

  List<Map<String, dynamic>> get slots => widget.slots;
  int get numberOfCourts => widget.numberOfCourts;

  @override
  void initState() {
    super.initState();
    selectedDate =
        DateTime.now(); // Set the current date as selected by default
    _totalMembersController = TextEditingController(text: '1');
    _remainingMembersController = TextEditingController(text: '0');
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Date",
            style: TextStyle(color: Colors.green, fontSize: 18)),
        const SizedBox(height: 10),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected =
                  selectedDate != null && isSameDay(date, selectedDate!);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = date;
                    selectedSlotIndex = null;
                    selectedCourtIndex = null;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getWeekdayAbbreviation(date.weekday),
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getWeekdayAbbreviation(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  Widget _buildAvailableSlots() {
    if (slots.isEmpty) {
      return const Text("No available slots",
          style: TextStyle(color: Colors.white));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Available Slots",
            style: TextStyle(color: Colors.green, fontSize: 18)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(slots.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSlotIndex = index;
                  selectedCourtIndex = null;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      selectedSlotIndex == index ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  "${slots[index]['time']}",
                  style: TextStyle(
                    color: selectedSlotIndex == index
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCourtSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Court",
            style: TextStyle(color: Colors.green, fontSize: 18)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(numberOfCourts, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCourtIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      selectedCourtIndex == index ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: selectedCourtIndex == index
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPlayWithStrangers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Play with Strangers",
            style: TextStyle(color: Colors.green, fontSize: 18)),
        Switch(
          value: playWithStrangers,
          onChanged: (value) {
            setState(() {
              playWithStrangers = value;
            });
          },
          activeColor: Colors.white,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () async {
          if (selectedDate != null &&
              selectedSlotIndex != null &&
              selectedCourtIndex != null) {
            final bookingDetails = {
              'userId': getUserId(),
              'turfId': widget.turfId,
              'court': (selectedCourtIndex! + 1).toString(),
              'playWithStranger': playWithStrangers,
              'totalMembers': _totalMembersController.text.isNotEmpty
                  ? _totalMembersController.text
                  : '1',
              'remainingMembers': _remainingMembersController.text.isNotEmpty
                  ? _remainingMembersController.text
                  : '0',
              'slot': "${slots[selectedSlotIndex!]['time']}",
              'date':
                  "${selectedDate!.month}-${selectedDate!.day}-${selectedDate!.year}",
              'ownerMobileNumber': widget.ownerMobileNumber,
            };
            try {
              Get.to(() => SinglePaymentView(
                    turfId: widget.turfId,
                    date:
                        "${selectedDate!.month}-${selectedDate!.day}-${selectedDate!.year}",
                    slot: slots[selectedSlotIndex!]['time'],
                    turfRate: double.parse(
                        slots[selectedSlotIndex!]['price'].toString()),
                    court: (selectedCourtIndex! + 1).toString(),
                    turfName: widget.turfName ?? 'Unknown Turf',
                    ownerMobileNumber: widget.ownerMobileNumber,
                  ));
              await sendBookingDetails(bookingDetails);
            } catch (e) {
              print('Error sending booking details: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to book: $e')),
              );
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: const Icon(Icons.arrow_forward, color: Colors.green),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Date",
                style: TextStyle(color: Colors.green, fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateSelection(),
                    if (selectedDate != null) ...[
                      const SizedBox(height: 20),
                      _buildAvailableSlots(),
                    ],
                    if (selectedSlotIndex != null) ...[
                      const SizedBox(height: 20),
                      _buildCourtSelection(),
                    ],
                    if (selectedCourtIndex != null) ...[
                      const SizedBox(height: 20),
                      _buildPlayWithStrangers(),
                      if (playWithStrangers)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _totalMembersController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Total Members',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      10), // Add some space between the fields
                              Expanded(
                                child: TextField(
                                  controller: _remainingMembersController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Remaining Members',
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
            if (selectedCourtIndex != null) _buildNextButton(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _totalMembersController.dispose();
    _remainingMembersController.dispose();
    super.dispose();
  }
}

Future<void> sendBookingDetails(Map<String, dynamic> bookingDetails) async {
  try {
    print('Sending booking details: ${json.encode(bookingDetails)}');
    final response = await http.post(
      Uri.parse('http://65.1.5.180:3000/booking'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookingDetails),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Booking details sent successfully');
    } else {
      var errorMessage = 'Failed to send booking details';
      try {
        var responseBody = json.decode(response.body);
        errorMessage = responseBody['message'] ?? errorMessage;
      } catch (_) {}
      throw Exception('$errorMessage. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error in sendBookingDetails: $e');
    throw Exception('Failed to send booking details: $e');
  }
}
