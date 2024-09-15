import 'package:flutter/material.dart';
import 'package:sporty/models/phncontroller.dart';
import 'package:sporty/models/sports_feild.dart';
import 'package:sporty/payment/razorpay.dart';

class SinglePaymentView extends StatefulWidget {
  const SinglePaymentView({
    super.key, 
    required this.turfRate, 
    required this.turfId, 
    required this.date, 
    required this.slot,
    required this.court,
    this.turfName,
    required this.ownerMobileNumber,
  });

  static double turfrate = 0.0;

  final double turfRate;
  final String turfId;
  final String date;
  final String slot;
  final String court;
  final String? turfName;
  final String ownerMobileNumber;

  @override
  _SinglePaymentViewState createState() => _SinglePaymentViewState();
}

class _SinglePaymentViewState extends State<SinglePaymentView> {
  @override
  Widget build(BuildContext context) {
    final RazorpayService razorpayService = RazorpayService();
    double totalAmount = widget.turfRate;
    String ownerMobileNumber = widget.ownerMobileNumber;

    return SafeArea(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24,),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Your hosted game',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://imgs.search.brave.com/zN2JDwLs9UxC0UGzY3mIqh_C1SxfAo6Vt5EUPwwRnMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Ry/b3R1cmYuY29tL3N0/YXRpYy85NDMxNTZm/YmQ1ODg3NWEyMDZl/ZjdkMGMxMmJlY2Yz/NS8xM2U0My9VVFNB/LmpwZw',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.turfName ?? 'Unknown Turf', // Provide a default value if null
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        '${widget.date} · ${widget.slot}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        'Court ${widget.court}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bill Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Slot Cost',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white54,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        '₹ ${widget.turfRate.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white54,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white54),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        '₹ ${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  razorpayService.singlePayment(totalAmount,
                  ownerMobileNumber,
                  widget.turfName ?? 'Unknown Turf',
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                ),
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}