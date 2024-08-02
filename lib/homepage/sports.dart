import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/models/controllerhome.dart';
import 'package:sporty/models/sports_feild.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:sporty/homepage/details.dart';

class SportsListScreen extends StatefulWidget {
  final String sportName;

  const SportsListScreen({Key? key, required this.sportName}) : super(key: key);

  @override
  _SportsListScreenState createState() => _SportsListScreenState();
}

class _SportsListScreenState extends State<SportsListScreen> {
  final SportsFieldController controller = Get.put(SportsFieldController());
  TextEditingController searchController = TextEditingController();
  List<SportsFieldApi> filteredSportsFields = [];

  @override
  void initState() {
    super.initState();
    _filterSportFields();
    searchController.addListener(_filterSportsFields);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
        title: Text(widget.sportName, style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Expanded(
                child: TextField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (filteredSportsFields.isEmpty) {
                  return Center(child: Text('No ${widget.sportName} fields available', style: TextStyle(color: Colors.white)));
                } else {
                  return ListView.builder(
                    itemCount: filteredSportsFields.length,
                    itemBuilder: (context, index) {
                      final field = filteredSportsFields[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => DetailsPage(sportsField: field));
                        },
                        child: Card(
                          color: Colors.black,
                          margin: EdgeInsets.all(8),
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
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        '${field.discounts}% Off',
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${field.turfName}, ${field.location}',
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.yellow, size: 16),
                                        SizedBox(width: 4),
                                        Text(
                                          '${field.rating}',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                        Spacer(),
                                        Text(
                                          '₹${field.courts}/hr',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
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
      bottomNavigationBar: CustomNavBar(currentIndex: 1),
    );
  }
}