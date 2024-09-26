// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:sporty/models/sports_feild.dart';
// import 'package:sporty/payment/singlepay.dart';
// import 'package:flutter/foundation.dart';

// class RazorpayService {
//   late Razorpay _razorpay;

//   RazorpayService({}) {
//     init();
//   }

//   void init() {
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   void dispose() {
//     _razorpay.clear();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     print("Payment Successful: ${response.paymentId}");
//     final paymentId = response.paymentId;

//     final ownermobileNumber = SportsFieldApi.ownerMobileNumber;
//     final requestData = <String, dynamic>{
//       'paymentId': paymentId,
//       'ownerMobileNumber': ownermobileNumber,
//       'amount': (SinglePaymentView.turfrate).toInt().toString(),
//     };

//     // Log the data before sending it to the server
//     print("Sending payment details: $requestData");

//     compute(_sendPaymentDetailsToServer, requestData);
//     print(response.toString());
//   }

//   Future<void> _sendPaymentDetailsToServer(Map<String, dynamic> requestData) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://65.1.5.180:3000/payments/turf'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(requestData),
//       );

//       print("Response from server: ${response.body}");

//       if (response.statusCode == 201) {
//         print('Payment details successfully sent to the server.');
//       } else {
//         print('Failed to send payment details. Status code: ${response.statusCode}');
//         // Log the error message from the server
//         print('Error message from server: ${response.body}');
//       }
//     } catch (e) {
//       print('Error sending payment details: $e');
//     }
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     print("Payment Error: ${response.code} - ${response.message}");
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print("External Wallet Selected: ${response.walletName}");
//   }

//   String colorToHex(Color color) {
//     return '#${color.value}';
//   }

//   void singlePayment(double turfRate) async {
//     int onlinePaymentInPaise = (turfRate * 100).toInt(); // Convert to paise

//     var options = {
//       'key': 'rzp_test_ISAc4Anh1IdROT',
//       'amount': onlinePaymentInPaise,
//       'name': 'Turf Booking',
//       'description': 'Payment for standard turf booking',
//       'prefill': {
//         'contact': '9000090000',
//         'email': 'gaurav.kumar@example.com'
//       },
//       'wallets': ['paytm', 'gpay', 'phonepe'],
//       'theme': {
//         'color': colorToHex(Colors.green) // Ensure this is a string
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print("Error opening Razorpay: ${e.toString()}");
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sporty/booking/bookings1.dart';
import 'package:sporty/payment/singlepay.dart';
import 'package:flutter/foundation.dart';
import 'package:sporty/models/sports_feild.dart';

class RazorpayService {
  late Razorpay _razorpay;
  late String ownerMobileNumber;
  late double turfRate; // Add this variable to store the turf rate

  RazorpayService() {
    init();
  }

  void init() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Successful: ${response.paymentId}");
    final paymentId = response.paymentId;
    print(ownerMobileNumber);

    final requestData = <String, dynamic>{
      'paymentId': paymentId,
      'ownerMobileNo': ownerMobileNumber,
      'amount': turfRate.toInt().toString(), // Use the stored turf rate
    };

    print("Sending payment details: $requestData");

    compute(_sendPaymentDetailsToServer, requestData);
    print(response.toString());
    Get.offAll(() => BookingScreen());
  }

  Future<void> _sendPaymentDetailsToServer(
      Map<String, dynamic> requestData) async {
    try {
      final response = await http.post(
        Uri.parse('http://65.1.5.180:3000/payments/turf'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      print("Response from server: ${response.body}");

      if (response.statusCode == 201) {
        print('Payment details successfully sent to the server.');
      } else {
        print(
            'Failed to send payment details. Status code: ${response.statusCode}');
        print('Error message from server: ${response.body}');
      }
    } catch (e) {
      print('Error sending payment details: $e');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  String colorToHex(Color color) {
    return '#${color.value}';
  }

  void singlePayment(
      double turfRate, String ownerMobileNumber, String turfName) async {
    this.ownerMobileNumber = ownerMobileNumber;
    this.turfRate = turfRate;

    int onlinePaymentInPaise = (turfRate * 100).toInt();

    var options = {
      'key': 'rzp_test_ISAc4Anh1IdROT',
      'amount': onlinePaymentInPaise,
      'name': turfName,
      'description': 'Payment for standard turf booking',
      'prefill': {'contact': ownerMobileNumber, 'email': 'example@domain.com'},
      'wallets': ['paytm', 'gpay', 'phonepe'],
      'theme': {'color': colorToHex(Colors.green)}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay: ${e.toString()}");
    }
  }
}
