import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print("Payment Successful: ${response.paymentId}");
    // You can add further logic here, such as updating the UI or notifying the server
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error
    print("Payment Error: ${response.code} - ${response.message}");
    // You can add further logic here, such as showing an error message to the user
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    print("External Wallet Selected: ${response.walletName}");
    // You can add further logic here, such as updating the UI or notifying the server
  }

  void singlePayment(double turfRate) async {
    double onlinePayment = (turfRate * 0.3) + 3; // Calculate initial online payment amount
    double remainingAmount = turfRate - onlinePayment; // Calculate remaining amount
    double cashPayment = (remainingAmount / 100).ceil() * 100; // Round up to nearest multiple of 100
    double adjustedOnlinePayment = turfRate - cashPayment; // Adjust online payment

    int onlinePaymentInPaise = (adjustedOnlinePayment * 100).toInt(); // Convert to paise

    var options = {
      'key': 'YOUR_KEY_ID',
      'amount': onlinePaymentInPaise,
      'name': 'Turf Booking',
      'description': 'Payment for standard turf booking',
      'prefill': {
        'contact': '9000090000',
        'email': 'gaurav.kumar@example.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
      print("Cash Payment to be made: $cashPayment");
    } catch (e) {
      print(e.toString());
    }
  }

  void joinPayment(double turfRate, int people) async {
    double totalAmount = (turfRate / people) + 10;
    double remainingAmount = turfRate - totalAmount;
    double remainingAmountPerPerson = remainingAmount / people;
    int amountInPaise = (totalAmount * 100).toInt();

    var options = {
      'key': 'YOUR_KEY_ID',
      'amount': amountInPaise,
      'name': 'Turf Booking',
      'remainingAmountPerPerson': remainingAmountPerPerson,
      'description': 'Payment for premium turf booking',
      'prefill': {
        'contact': '9000090000',
        'email': 'gaurav.kumar@example.com'
      },
      'external': {
        'wallets': ['paytm', 'gpay', 'phonepe']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }
}