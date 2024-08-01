import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/homepage/testpage.dart';
import 'package:sporty/models/controllerevent.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:sporty/uicomponents/cards.dart';
import 'package:sporty/homepage/details.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final EventController controller = Get.put(EventController());
  bool isJoinSelected = true;
  String selectedFilter = 'Filter';

  @override
  void initState() {
    super.initState();
    controller.fetchSportsFields();
  }

  @override
  Widget build(BuildContext context) {
    print('Building EventScreen...');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // Toggle Button
            Center(
              child: ToggleButton(
                leftLabel: 'Join',
                rightLabel: 'Competition',
                onToggle: (isLeftSelected) {
                  setState(() {
                    isJoinSelected = isLeftSelected;
                    print('Toggled to ${isJoinSelected ? 'Join' : 'Competition'}');
                  });
                },
              ),
            ),
            // Filter and Location Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                          print('Selected filter: $selectedFilter');
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<String>(
                            value: 'football',
                            child: Text('football', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'tennis',
                            child: Text('tennis', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'badminton',
                            child: Text('badminton', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'golf',
                            child: Text('golf', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'cricket',
                            child: Text('cricket', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'swimming',
                            child: Text('swimming', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'basketball',
                            child: Text('basketball', style: TextStyle(color: Colors.white)),
                          ),
                        ];
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(selectedFilter, style: const TextStyle(color: Colors.white)),
                            const Icon(Icons.arrow_drop_down, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Get.to(() => const TestPage());
                    },
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    label: const Text('Location', style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Use your existing event cards or other widgets here
            Obx(() {
              print('Rebuilding UI based on controller state...');
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: isJoinSelected
                      ? JoinEvents(sportsFields: controller.sportsFields)
                      : CompeteEvents(sportsFields: controller.sportsFields),
                );
              }
            }),
          ],
        ),
        bottomNavigationBar: const CustomNavBar(currentIndex: 2),
      ),
    );
  }
}

class JoinEvents extends StatelessWidget {
  final List<EventSportsField> sportsFields;

  const JoinEvents({super.key, required this.sportsFields});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sportsFields.length,
      itemBuilder: (context, index) {
        return SportsFieldCardV2(
          sportsField: sportsFields[index] as SportsField,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  sportsField: sportsFields[index] as SportsField,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CompeteEvents extends StatelessWidget {
  final List<EventSportsField> sportsFields;

  const CompeteEvents({super.key, required this.sportsFields});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sportsFields.length,
      itemBuilder: (context, index) {
        return SportsFieldCardV3(
          sportsField: sportsFields[index] as SportsField, // Cast to SportsField
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  sportsField: sportsFields[index] as SportsField, // Cast to SportsField
          ),
              ),
            );
          },
        );
      },
    );
  }
}