import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: const Text(
          'Rewards',
          style: TextStyle(color: Colors.green),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white, // Set arrow icon color to white
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when arrow button is pressed
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class RewardsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black, // Set background color to black
//       appBar: AppBar(
//         title: const Text(
//           'Rewards',
//           style: TextStyle(color: Colors.green),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white, // Set arrow icon color to white
//           ),
//           onPressed: () {
//             Navigator.pop(
//                 context); // Navigate back when arrow button is pressed
//           },
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10),
//         child: ListView(
//           children: <Widget>[
//             _buildRewardCard(
//               context,
//               icon: Icons.card_giftcard,
//               title: 'Brand Vouchers',
//               subtitle: 'Up to ₹300 cashback*',
//               category: 'Fashion & Clothing',
//               isNew: true,
//             ),
//             _buildRewardCard(
//               context,
//               icon: Icons.local_grocery_store,
//               title: 'Swiggy Instamart',
//               subtitle: 'Get Free Combo worth ₹150*',
//               category: 'Daily Needs',
//               isNew: true,
//             ),
//             _buildRewardCard(
//               context,
//               icon: Icons.shopping_bag,
//               title: 'Myntra',
//               subtitle: 'Get FLAT 15% Extra Off*',
//               category: 'Fashion & Clothing',
//             ),
//             _buildRewardCard(
//               context,
//               icon: Icons.movie,
//               title: 'AHA',
//               subtitle: 'Flat 25% Off*',
//               category: 'Entertainment',
//             ),
//             _buildRewardCard(
//               context,
//               icon: Icons.local_pizza,
//               title: 'Domino\'s',
//               subtitle: 'Get 33% Off* + Free Delivery',
//               category: 'Food',
//             ),
//             // Add more cards as needed
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _buildRewardCard(BuildContext context,
//     {required IconData icon,
//     required String title,
//     required String subtitle,
//     required String category,
//     bool isNew = false}) {
//   return Card(
//     color: const Color.fromARGB(
//         244, 42, 41, 41), // Set card background color to light grey
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             title,
//             style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white), // Set text color to white
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: <Widget>[
//               Icon(icon, color: Colors.green), // Set icon color to black
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       subtitle,
//                       style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.white), // Set text color to white
//                     ),
//                     Text(
//                       category,
//                       style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.white), // Set text color to white
//                     ),
//                   ],
//                 ),
//               ),
//               isNew
//                   ? const Chip(
//                       label: Text('New'),
//                       backgroundColor: Colors.black,
//                       labelStyle: TextStyle(color: Colors.white),
//                     )
//                   : Container(),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
