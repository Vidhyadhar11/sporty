import 'package:flutter/material.dart';
import 'package:sporty/models/controllerhome.dart';
import 'package:sporty/models/sports_feild.dart';
import 'package:sporty/booking/date.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  final SportsFieldApi sportsField;

  const DetailsPage({super.key, required this.sportsField});

  

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final LikedFieldsController likedController = Get.find<LikedFieldsController>();
  // static String? ownerMobileNumber=widget.sportsField.ownerMobileNumber;

  @override
  void initState() {
    super.initState();
    // print(widget.sportsField.ownerMobileNumber.toString());
    // print(widget.sportsField.turfName.toString());
    // print(widget.sportsField.id.toString());
    // print(widget.sportsField.slots[0]['price'].toString());
    // print(widget.sportsField.slots[0]['time'].toString());
    // print(widget.sportsField.courts.toString());
    // print(widget.sportsField.discounts.toString());
    // print(widget.sportsField.imageUrl.toString());
    // print(widget.sportsField.location.toString());
    // print(widget.sportsField.description.toString());
    // print(widget.sportsField.amenities.toString());
    // print(widget.sportsField.rating.toString());
    // print(widget.sportsField.slots.toString());
    // print(widget.sportsField.isLiked.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        widget.sportsField.imageUrl,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            widget.sportsField.category,
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
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
                            '${widget.sportsField.discounts}% Off',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.sportsField.location,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.sportsField.rating}',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          widget.sportsField.turfName,
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.sportsField.description,
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Amenities',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            _buildAmenityItem(Icons.local_parking, 'Parking'),
                            _buildAmenityItem(Icons.wc, 'Rest Room'),
                            _buildAmenityItem(Icons.local_cafe, 'Cafeteria'),
                            _buildAmenityItem(Icons.medical_services, 'First Aid Kit'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              likedController.toggleLike(widget.sportsField);
                            },
                            child: Icon(
                              likedController.isLiked(widget.sportsField) ? Icons.favorite : Icons.favorite_border,
                              color: Colors.white,
                            ),
                          )),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              '₹${widget.sportsField.slots[0]['price']}/hr',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.green),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          Get.to(() => BookingPage(turfRate: widget.sportsField.slots[0]['price'].toDouble(), 
                          turfId: widget.sportsField.id, 
                          slots: widget.sportsField.slots, 
                          numberOfCourts: widget.sportsField.courts, 
                          turfName: widget.sportsField.turfName,
                          ownerMobileNumber: widget.sportsField.ownerMobileNumber.toString()
                          ));
                        },
                        child: const Text('Book Now', style: TextStyle(color: Colors.green, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenityItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}