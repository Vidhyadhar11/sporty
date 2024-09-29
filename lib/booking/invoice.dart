import 'package:flutter/material.dart';
import 'package:sporty/booking/bookings1.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:sporty/booking/pushnotification.dart';

class InvoicePage extends StatelessWidget {
  final String selectedDate;
  final String selectedSlot;
  final String selectedCourt;
  final String BookingId;
  final int amount;

  const InvoicePage(
      {super.key,
      required this.selectedDate,
      required this.selectedSlot,
      required this.selectedCourt,
      required this.BookingId,
      required this.amount
      });

  @override
  Widget build(BuildContext context) {
    // Initialize the notification plugin
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();

    // // Initialize the NotificationService
    // final NotificationService notificationService =
    //     NotificationService(flutterLocalNotificationsPlugin);

    // // Schedule notifications
    // notificationService.scheduleNotifications(selectedDate);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookingScreen()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text("Invoice",
                  style: TextStyle(color: Colors.green, fontSize: 24)),
            ),
            const SizedBox(height: 20),
            _buildInvoiceDetail("Date", selectedDate),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Slot", selectedSlot),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Court", selectedCourt.toString()),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Booking ID", BookingId.toString()),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Amount", amount.toString()),
            const SizedBox(height: 20),
            const Center(
                child: Text("Booked",
                    style: TextStyle(color: Colors.green, fontSize: 24))),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceDetail(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}
