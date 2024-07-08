import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoicePage extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedSlot;
  final int selectedCourt;
  final bool playWithStrangers;

  InvoicePage({
    required this.selectedDate,
    required this.selectedSlot,
    required this.selectedCourt,
    required this.playWithStrangers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text("Invoice", style: TextStyle(color: Colors.green, fontSize: 24)),
            ),
            const SizedBox(height: 20),
            _buildInvoiceDetail("Date", DateFormat('d EEEE').format(selectedDate)),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Slot", selectedSlot),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Court", selectedCourt.toString()),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Play with Strangers", playWithStrangers ? "Yes" : "No"),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Booking ID", "XXXXXXXXXX"),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Court Name", "Star Strikers"),
            const SizedBox(height: 10),
            _buildInvoiceDetail("Location", "KPHB, Hyderabad"),
            const SizedBox(height: 20),
            const Center(child: Text("Booked", style: TextStyle(color: Colors.green, fontSize: 24))),
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