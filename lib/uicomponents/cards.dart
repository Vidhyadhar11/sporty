import 'package:flutter/material.dart';

// Define the SportsField class to handle both types of cards
class SportsField {
  final String name;
  final String location;
  final double rating;
  final double price;
  final String imageUrl;
  final String discount;
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
    this.slot,
    this.players,
    this.maxPlayers,
  });
}

// Define the first type of sports field card
class SportsFieldCard extends StatelessWidget {
  final SportsField sportsField;
  final VoidCallback onTap;

  const SportsFieldCard({Key? key, required this.sportsField, required this.onTap}) : super(key: key);

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
                    child: const Text('Football', style: TextStyle(color: Colors.white)),
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

  const SportsFieldCardV2({Key? key, required this.sportsField, required this.onTap}) : super(key: key);

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
                    child: const Text('Football', style: TextStyle(color: Colors.white)),
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

  const SportsFieldCardV3({Key? key, required this.sportsField, required this.onTap}) : super(key: key);

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
                    child: const Text('Football', style: TextStyle(color: Colors.white)),
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





//this is how you call card1
// final List<SportsField> sportsFields = [
//     SportsField(
//       name: 'KPHB',
//       location: 'Hyderabad',
//       rating: 4.4,
//       price: 120,
//       imageUrl: 'https://via.placeholder.com/150', // Replace with your image URL
//       discount: '15% Off',
//     ),

//this is how you call cardv2
// Create a SportsField object
// final sportsField = SportsField(
//   name: 'KPHB, Hyderabad',
//   location: '', // Add location if needed
//   rating: 4.5,
//   price: 100,
//   imageUrl: 'https://picsum.photos/200/300', // Replace with your image URL
//   discount: '', // Add discount if needed
//   slot: '29-09-24 At 6pm-7pm',
//   players: 5, // Add players count
//   maxPlayers: 10, // Add max players count
// );

// // Build the SportsFieldCardV2 widget
// SportsFieldCardV2(
//   sportsField: sportsField,
//   onTap: () {
//   },
// )


//this is how you call the cardv3
// // Create a SportsField object
// final sportsField = SportsField(
//   name: 'KPHB, Hyderabad',
//   location: '', // Add location if needed
//   rating: 4.5,
//   price: 100,
//   imageUrl: 'https://picsum.photos/200/300', // Replace with your image URL
//   discount: '', // Add discount if needed
//   slot: '29-09-24 At 6pm-7pm',
// );

// // Build the SportsFieldCardV3 widget
// SportsFieldCardV3(
//   sportsField: sportsField,
//   onTap: () {
//     // Handle the tap event here
//   },
// )