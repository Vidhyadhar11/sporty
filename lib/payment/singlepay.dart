// import 'package:flutter/material.dart';
// import 'package:sporty/booking/bookings1.dart';
// import 'package:sporty/booking/date.dart';
// import 'package:sporty/payment/razorpay.dart';


// // ignore: must_be_immutable
// abstract class SinglePaymentView extends StatefulWidget implements BookingScreen {
  
//   const SinglePaymentView({super.key, required this.turfRate});
//   //  required this.selectedDate, required this.selectedSlot, required this.selectedCourt, required this.playWithStrangers
  
//   final double turfRate;
//   // final Date selectedDate;
//   // final String selectedSlot;
//   // final String selectedCourt;
//   // final bool playWithStrangers;


//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Text(
//           'Payment Details',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text('Turf Rate: $turfRate'),
//         const Text('Service Fee: 3'),
//         Text("Offline payment: $RazorpayService().cashPayment"),
//         Text("Payment Amount: $RazorpayService().adjustedOnlinePayment"),
//         Text("Overall payment: $RazorpayService().singlePayment.totalAmount"),
//         ElevatedButton(
//           onPressed: () => RazorpayService().singlePayment(turfRate), // Example turf rate
//           child: const Text('Pay Now'),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:sporty/payment/razorpay.dart';

class SinglePaymentView extends StatefulWidget {
  const SinglePaymentView({super.key, required this.turfRate});
  
  final double turfRate;

  @override
  _SinglePaymentViewState createState() => _SinglePaymentViewState();
}

class _SinglePaymentViewState extends State<SinglePaymentView> {
  @override
  Widget build(BuildContext context) {
    final RazorpayService razorpayService = RazorpayService(); // Create a single instance
    double onlinePayment = (widget.turfRate * 0.3); // Calculate initial online payment amount
    double remainingAmount = widget.turfRate - onlinePayment; // Calculate remaining amount
    double cashPayment = (remainingAmount / 100).ceil() * 100; // Round up to nearest multiple of 100
    double adjustedOnlinePayment = widget.turfRate - cashPayment + 3; // Adjust online payment
    double totalAmount = widget.turfRate + 3;

    return SafeArea(
      child: Column(
        children: [
          const Text(
              'Payment Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Turf Rate: \$${widget.turfRate}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(221, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Service Fee: \$3',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(221, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Offline Payment: \$${cashPayment}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(221, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Payment Amount: \$${adjustedOnlinePayment}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(221, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Overall Payment: \$${totalAmount}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(221, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => razorpayService.singlePayment(widget.turfRate), // Use the instance
              child: const Text('Pay Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
