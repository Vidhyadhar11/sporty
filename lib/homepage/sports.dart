import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/models/controllerhome.dart';
import 'package:sporty/models/sports_feild.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:sporty/homepage/details.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class SportsListScreen extends StatefulWidget {
  final String sportName;

  const SportsListScreen({super.key, required this.sportName});

  @override
  _SportsListScreenState createState() => _SportsListScreenState();
}

class _SportsListScreenState extends State<SportsListScreen> {
  final SportsFieldController controller = Get.put(SportsFieldController());
  TextEditingController searchController = TextEditingController();
  List<SportsFieldApi> filteredSportsFields = [];
  ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    print('SportsListScreen initialized with sport: ${widget.sportName}'); // Debugging statement
    _filterSportFields();
    searchController.addListener(_filterSportsFields);
    //_scrollController.addListener(_loadMoreFields);
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Get.toNamed('/home'); // Navigate to home screen
    return true; // Prevent the default back button behavior
  }

  void _filterSportFields() {
    setState(() {
      filteredSportsFields = controller.sportsFields.where((field) {
        return field.category.toLowerCase() == widget.sportName.toLowerCase();
      }).toList();
    });
  }

  void _filterSportsFields() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredSportsFields = controller.sportsFields.where((field) {
        return field.category.toLowerCase() == widget.sportName.toLowerCase() &&
            (field.turfName.toLowerCase().contains(query) ||
            field.location.toLowerCase().contains(query));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.sportName, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false), // Navigate to home screen
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (filteredSportsFields.isEmpty) {
                  return Center(child: Text('No ${widget.sportName} fields available', style: const TextStyle(color: Colors.white)));
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredSportsFields.length,
                    itemBuilder: (context, index) {
                      final field = filteredSportsFields[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => DetailsPage(sportsField: field));
                        },
                        child: Card(
                          color: Colors.black,
                          margin: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    field.imageUrl,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        '${field.discounts}% Off',
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${field.turfName}, ${field.location}',
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.yellow, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${field.rating}',
                                          style: const TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '₹${field.courts}/hr',
                                          style: const TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 1),
    );
  }
}