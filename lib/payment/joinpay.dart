
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:sporty/booking/bookings1.dart';
// import 'package:sporty/booking/date.dart';
// import 'package:sporty/payment/razorpay.dart';

// // ignore: must_be_immutable
// class JoinPaymentView extends StatelessWidget implements BookingScreen {
  
//   const JoinPaymentView({super.key, required this.turfRate, required this.numberOfPeople});
  
//   final double turfRate;
//   final int numberOfPeople;

//   Widget build(BuildContext context) {
//     final RazorpayService razorpayService = RazorpayService(); // Create a single instance
//     double totalAmount = (turfRate / numberOfPeople) ;
//     double remainingAmount = turfRate - totalAmount;
//     double remainingAmountPerPerson = (remainingAmount / numberOfPeople);
//     double amounttopay = remainingAmountPerPerson + 10;

//     return Column(
//       children: [
//         const Text(
//           'Payment Details',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text('Turf Rate: $remainingAmountPerPerson'),
//         const Text('Service Fee: 10'),
//         Text("Payment Amount: $amounttopay"),

//         ElevatedButton(
//           onPressed: () => razorpayService.singlePayment(amounttopay), // Use the instance
//           child: const Text('Pay Now'),

//         ),
//       ],
//     );
//   }
  
  
// }

import 'package:flutter/material.dart';
import 'package:sporty/payment/razorpay.dart';


class JoinPaymentView extends StatefulWidget{
  const JoinPaymentView({super.key, required this.turfRate, required this.numberOfPeople});

  final double turfRate;
  final int numberOfPeople;

  @override
  JoinPaymentViewState createState() => JoinPaymentViewState();

  @override
  Widget build(BuildContext context) {
    // You can return a placeholder or an empty widget if needed.
    return Container();
  }
}

class JoinPaymentViewState extends State<JoinPaymentView> {
  @override
  Widget build(BuildContext context) {
    final RazorpayService razorpayService = RazorpayService(); // Create a single instance
    double totalAmount = (widget.turfRate / widget.numberOfPeople);
    double remainingAmount = widget.turfRate - totalAmount;
    double remainingAmountPerPerson = (remainingAmount / widget.numberOfPeople);
    double amountToPay = remainingAmountPerPerson + 10;

    return Column(
      children: [
        const Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('Turf Rate: $remainingAmountPerPerson'),
        const Text('Service Fee: 10'),
        Text("Payment Amount: $amountToPay"),
        ElevatedButton(
          onPressed: () => razorpayService.singlePayment(amountToPay), // Use the instance
          child: const Text('Pay Now'),
        ),
      ],
    );
  }
}
