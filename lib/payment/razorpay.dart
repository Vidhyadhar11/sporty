
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  RazorpayService() {
    init(); // Initialize Razorpay in the constructor
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.paymentId}");
    // Additional logic can be added here
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
    // Additional error handling can be added here
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
    // Additional logic can be added here
  }

  void singlePayment(double turfRate) async {
    int onlinePaymentInPaise = (turfRate * 100).toInt(); // Convert to paise

    var options = {
      'key': 'rzp_test_ISAc4Anh1IdROT',
      'amount': onlinePaymentInPaise,
      'name': 'Turf Booking',
      'description': 'Payment for standard turf booking',
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
      print("Error opening Razorpay: ${e.toString()}");
    }
  }
}