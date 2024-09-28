//import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sporty/uicomponents/elements.dart';
// import 'package:sporty/homepage/testpage.dart';
// import 'package:get/get.dart';
// import 'package:sporty/models/sports_feild.dart';
// import 'package:sporty/uicomponents/cards.dart';
// import 'package:sporty/homepage/details.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool isJoinSelected = true;
  String selectedFilter = 'Filter';
  List<dynamic> joinEvents = [];
  List<dynamic> filteredEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJoinEvents();
    //BackButtonInterceptor.add(myInterceptor);
  }

  // @override
  // void dispose() {
  //   //BackButtonInterceptor.remove(myInterceptor);
  //   super.dispose();
  // }

  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   Get.toNamed('/home'); // Navigate to home screen
  //   return true; // Prevent the default back button behavior
  // }

  Future<void> fetchJoinEvents() async {
    try {
      final response = await http
          .get(Uri.parse('http://65.1.5.180:3000/booking/playWithStrangers'));
      if (response.statusCode == 200) {
        setState(() {
          joinEvents = json.decode(response.body);
          applyFilter();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load join events');
      }
    } catch (e) {
      print('Error fetching join events: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void applyFilter() {
    setState(() {
      if (selectedFilter == 'Filter') {
        filteredEvents = joinEvents;
      } else {
        filteredEvents = joinEvents.where((event) {
          return event['sport'] == selectedFilter;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Center(
              child: ToggleButton(
                leftLabel: 'Join',
                rightLabel: 'Competition',
                onToggle: (isLeftSelected) {
                  setState(() {
                    isJoinSelected = isLeftSelected;
                  });
                },
              ),
            ),
            if (isJoinSelected)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        popupMenuTheme: const PopupMenuThemeData(
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            selectedFilter = value;
                            applyFilter();
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            'football',
                            'tennis',
                            'badminton',
                            'golf',
                            'cricket',
                            'swimming',
                            'basketball',
                          ].map((String value) {
                            return PopupMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(color: Colors.white)),
                            );
                          }).toList();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(selectedFilter,
                                  style: const TextStyle(color: Colors.white)),
                              const Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: isJoinSelected
                  ? JoinEvents(joinEvents: filteredEvents, isLoading: isLoading)
                  : CompeteEvents(),
            ),
          ],
        ),
        bottomNavigationBar: const CustomNavBar(currentIndex: 2),
      ),
    );
  }
}

class JoinEvents extends StatelessWidget {
  final List<dynamic> joinEvents;
  final bool isLoading;

  const JoinEvents(
      {Key? key, required this.joinEvents, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: joinEvents.length,
        itemBuilder: (context, index) {
          var event = joinEvents[index];
          return Card(
            color: Colors.black,
            child: ListTile(
              title: Text(
                event['turfName'] ?? 'Unknown Turf',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Date: ${event['date']} | Slot: ${event['slot']}',
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: Text(
                'Remaining: ${event['remainingMembers']}',
                style: const TextStyle(color: Colors.green),
              ),
              onTap: () {
                // Navigate to details page or join page
                // You can use Get.to() here
              },
            ),
          );
        },
      );
    }
  }
}

class CompeteEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Coming Soon',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
