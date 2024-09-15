// import 'package:flutter/material.dart';
// import 'package:sporty/payment/razorpay.dart';

// class JoinPaymentView extends StatefulWidget {
//   const JoinPaymentView({super.key, required this.turfRate, required this.numberOfPeople});

//   final double turfRate;
//   final int numberOfPeople;

//   @override
//   JoinPaymentViewState createState() => JoinPaymentViewState();

//   Widget build(BuildContext context) {
//     // You can return a placeholder or an empty widget if needed.
//     return Container();
//   }
// }

// class JoinPaymentViewState extends State<JoinPaymentView> {
//   @override
//   Widget build(BuildContext context) {
//     final RazorpayService razorpayService = RazorpayService(); // Create a single instance
//     double totalAmount = (widget.turfRate / widget.numberOfPeople);
//     double remainingAmount = widget.turfRate - totalAmount;
//     double remainingAmountPerPerson = (remainingAmount / widget.numberOfPeople);
//     double amountToPay = remainingAmountPerPerson + 10;

//     return SafeArea(
//       child: Container(
//         color: Colors.black,
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24,),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 const Text('Join Game Payment', style: TextStyle(color: Colors.white, 
//                 fontSize: 24,
//                 decoration: TextDecoration.none,)),
//               ],
//             ),
//             const Divider(),
//             const SizedBox(height: 20,),
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 0, 0, 0),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.network(
//                       'https://imgs.search.brave.com/zN2JDwLs9UxC0UGzY3mIqh_C1SxfAo6Vt5EUPwwRnMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Ry/b3R1cmYuY29tL3N0/YXRpYy85NDMxNTZm/YmQ1ODg3NWEyMDZl/ZjdkMGMxMmJlY2Yz/NS8xM2U0My9VVFNB/LmpwZw',
//                       width: 60,
//                       height: 60,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Shuffle Sports, Chetpet',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                       Text(
//                         'Jul 20 · 08:00 pm - 09:00 pm',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white54,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                       Text(
//                         '1 Court',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white54,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20,),
//             const Divider(),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Bill Details',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       decoration: TextDecoration.none,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Turf Rate (per person)',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white54,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                       Text(
//                         '₹ ${remainingAmountPerPerson.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.white54,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Service Fee',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white54,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                       Text(
//                         '₹ 10',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white54,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(color: Colors.white54),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Total',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                       Text(
//                         '₹ ${amountToPay.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: TextButton(
//                     onPressed: () => razorpayService.singlePayment(amountToPay), // Use the instance
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Set text color to green
//                     ),
//                     child: const Text(
//                       "Pay Now",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
