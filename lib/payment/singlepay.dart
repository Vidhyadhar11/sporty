import 'package:flutter/material.dart';
import 'package:sporty/booking/date.dart';
import 'package:sporty/payment/razorpay.dart';


// ignore: must_be_immutable
abstract class SinglePaymentView extends StatefulWidget implements RazorpayService, BookingPage{
  
  const SinglePaymentView({super.key, required this.turfRate});
  //  required this.selectedDate, required this.selectedSlot, required this.selectedCourt, required this.playWithStrangers
  
  final double turfRate;
  // final Date selectedDate;
  // final String selectedSlot;
  // final String selectedCourt;
  // final bool playWithStrangers;


  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('Turf Rate: $turfRate'),
        const Text('Service Fee: 3'),
        Text("Offline payment: $singlePayment.cashPayment"),
        Text("Payment Amount: $singlePayment.adjustedOnlinePayment"),
        Text("Overall payment: $singlePayment.totalAmount"),
        ElevatedButton(
          onPressed: () => singlePayment(1000), // Example turf rate
          child: const Text('Pay Now'),
        ),
      ],
    );
  }
}