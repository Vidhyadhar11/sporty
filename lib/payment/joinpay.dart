import 'package:flutter/material.dart';
import 'razorpay.dart';

class JoinPaymentView extends StatefulWidget {
  @override
  _JoinPaymentViewState createState() => _JoinPaymentViewState();
}

class _JoinPaymentViewState extends State<JoinPaymentView> {
  late RazorpayService _razorpayService;

  @override
  void initState() {
    super.initState();
    _razorpayService = RazorpayService();
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _razorpayService.joinPayment(1000, 5), // Example turf rate and people count
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}