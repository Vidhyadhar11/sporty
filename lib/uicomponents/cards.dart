import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:sporty/uicomponents/mycontroller.dart';
// Define the SportsField class to handle both types of cards
class SportsField {
  final String name;
  final String location;
  final double rating;
  final double price;
  final String imageUrl;
  final String discount;
  final String sportType; // Add sportType property
  final String? slot;
  final int? players;
  final int? maxPlayers;

  SportsField({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.discount,
    required this.sportType, // Initialize sportType
    this.slot,
    this.players,
    this.maxPlayers,
  });
}

// Define the first type of sports field card
class SportsFieldCard extends StatefulWidget {
  final SportsField sportsField;
  final VoidCallback onTap;

  const SportsFieldCard({super.key, required this.sportsField, required this.onTap});

  @override
  // ignore: library_private_types_in_public_api
  _SportsFieldCardState createState() => _SportsFieldCardState();
}

class _SportsFieldCardState extends State<SportsFieldCard> {
  final SportsFieldController controller = Get.put(SportsFieldController());
  final Mycontroller myController = Mycontroller();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.network(widget.sportsField.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: Text(widget.sportsField.sportType, style: const TextStyle(color: Colors.white)), // Use sportType
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Obx(() => IconButton(
                    icon: Icon(
                      myController.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller.toggleFavorite(widget.sportsField);
                    },
                  )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.sportsField.name}, ${widget.sportsField.location}', style: const TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                      const SizedBox(width: 5),
                      Text('${widget.sportsField.rating}', style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      Text('₹${widget.sportsField.price}/hr', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: Text(widget.sportsField.discount, style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Define the second type of sports field card
class SportsFieldCardV2 extends StatelessWidget {
  final SportsField sportsField;
  final VoidCallback onTap;
  const SportsFieldCardV2({super.key, required this.sportsField, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.network(sportsField.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: Text(sportsField.sportType, style: const TextStyle(color: Colors.white)), // Use sportType
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: Text(sportsField.discount, style: const TextStyle(color: Colors.white)),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: sportsField.players! < sportsField.maxPlayers! ? Colors.green : Colors.red, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${sportsField.players}/${sportsField.maxPlayers}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${sportsField.name}, ${sportsField.location}', style: const TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                      const SizedBox(width: 5),
                      Text('${sportsField.rating}', style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      Text('₹${sportsField.price}/hr', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text('Slot ${sportsField.slot}', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: sportsField.players! < sportsField.maxPlayers! ? onTap : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                    child: const Text('Join'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Define the third type of sports field card
class SportsFieldCardV3 extends StatelessWidget {
  final SportsField sportsField;
  final VoidCallback onTap;

  const SportsFieldCardV3({super.key, required this.sportsField, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.network(sportsField.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: Text(sportsField.sportType, style: const TextStyle(color: Colors.white)), // Use sportType
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${sportsField.name}, ${sportsField.location}', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 5),
                  Text('On ${sportsField.slot}', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                    child: const Text('Paid'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Controller for managing the favorite state
class SportsFieldController extends GetxController {
  

  void toggleFavorite(SportsField sportsField) {
  final Mycontroller myController = Mycontroller();
    myController.isFavorite.value = !myController.isFavorite.value;
    if (myController.isFavorite.value) {
      addToFavorites(sportsField);
    } else {
      removeFromFavorites(sportsField);
    }
  }

  void addToFavorites(SportsField sportsField) {
    // Implement your logic to add to favorites
  }

  void removeFromFavorites(SportsField sportsField) {
    // Implement your logic to remove from favorites
  }
}