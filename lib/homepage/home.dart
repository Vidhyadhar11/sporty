import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sporty/drawer/drawerview.dart';
import 'package:sporty/models/controllerhome.dart';
import 'package:sporty/models/sports_feild.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:sporty/homepage/details.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SportsFieldController controller = Get.put(SportsFieldController());
  TextEditingController searchController = TextEditingController();
  List<SportsFieldApi> filteredSportsFields = [];
  ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    filteredSportsFields = controller.sportsFields;
    searchController.addListener(_filterSportsFields);
    _scrollController.addListener(_loadMoreFields);
    // BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    // BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   SystemNavigator.pop();
  //   return true;//prevent from default back button
  // }

  void _filterSportsFields() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredSportsFields = controller.sportsFields.where((field) {
        return field.turfName.toLowerCase().contains(query) ||
            field.location.toLowerCase().contains(query) ||
            field.category.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _loadMoreFields() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });

      // Show a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New turfs coming soon!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Prevent further scrolling by not adding more items
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          //filteredSportsFields.addAll(List.from(filteredSportsFields)); // Example to duplicate current items
          _isLoadingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            const Text('Play', style: TextStyle(color: Colors.white)),
            const Text('link', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
      drawer: Drawerview(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredSportsFields.length,
                  itemBuilder: (context, index) {
                    if (filteredSportsFields.isEmpty) {
                      print(filteredSportsFields.length);
                      return const Center(child: Text("No fields available"));
                    }
                    final field = filteredSportsFields.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DetailsPage(sportsField: field));
                      },
                      child: Card(
                        color: Colors.black,
                        margin: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                  child: Image.network(
                                    field.imageUrl,
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      field.category,
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    field.turfName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    field.location,
                                    style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        field.rating.toString(),
                                        style: const TextStyle(color: Colors.white, fontSize: 14.0),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '₹${field.slots[0]['price']}/hr',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                ),
              );
            }
          }),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
