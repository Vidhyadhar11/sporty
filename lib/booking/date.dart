// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'invoice.dart';
import 'package:sporty/payment/singlepay.dart';
import 'package:sporty/payment/joinpay.dart';
import 'package:get/get.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.turfRate});

  final double turfRate;

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  int? selectedSlotIndex;
  int? selectedCourtIndex;
  bool playWithStrangers = false;
  final TextEditingController _numberOfPeopleController = TextEditingController(); // Controller for TextField

  DateTime _focusedDay = DateTime.now();
  final DateTime _firstDay = DateTime(DateTime.now().year - 1);
  final DateTime _lastDay = DateTime(DateTime.now().year + 1);

  String get selectedMonth {
    if (selectedDate != null) {
      return "${selectedDate!.month}-${selectedDate!.year}";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Date", style: TextStyle(color: Colors.green, fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateSelection(),
                    if (selectedDate != null) ...[
                      const SizedBox(height: 20),
                      _buildAvailableSlots(),
                    ],
                    if (selectedSlotIndex != null) ...[
                      const SizedBox(height: 20),
                      _buildCourtSelection(),
                    ],
                    if (selectedCourtIndex != null) ...[
                      const SizedBox(height: 20),
                      _buildPlayWithStrangers(),
                      if (playWithStrangers) // Show TextField if checked
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: _numberOfPeopleController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Number of People',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
            if (selectedCourtIndex != null) _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return TableCalendar(
      firstDay: _firstDay,
      lastDay: _lastDay,
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.week,
      availableCalendarFormats: const {CalendarFormat.week: ''},
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleTextStyle: TextStyle(color: Colors.white),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Colors.white),
      ),
      daysOfWeekHeight: 0,
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          selectedDate = selectedDay;
          _focusedDay = focusedDay;
          selectedSlotIndex = null;
          selectedCourtIndex = null;
        });
      },
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, _) {
          return _buildDateBox(date, false);
        },
        selectedBuilder: (context, date, _) {
          return _buildDateBox(date, true);
        },
        todayBuilder: (context, date, _) {
          return _buildDateBox(date, false);
        },
      ),
    );
  }

  Widget _buildDateBox(DateTime date, bool isSelected) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 35,
        minHeight: 40,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${date.day}',
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            _getWeekdayAbbreviation(date.weekday),
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getWeekdayAbbreviation(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  Widget _buildAvailableSlots() {
    List<String> slots = ["8am-10am", "10am-12pm", "12pm-2pm", "6pm-7pm"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Available Slots", style: TextStyle(color: Colors.green, fontSize: 18)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(slots.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSlotIndex = index;
                  selectedCourtIndex = null;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedSlotIndex == index ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  slots[index],
                  style: TextStyle(
                    color: selectedSlotIndex == index ? Colors.black : Colors.white,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCourtSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Court", style: TextStyle(color: Colors.green, fontSize: 18)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCourtIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedCourtIndex == index ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: selectedCourtIndex == index ? Colors.black : Colors.white,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPlayWithStrangers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Play with Strangers", style: TextStyle(color: Colors.green, fontSize: 18)),
        Switch(
          value: playWithStrangers,
          onChanged: (value) {
            setState(() {
              playWithStrangers = value;
            });
          },
          activeColor: Colors.white,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey,
        ),
      ],
    );
  }

  // Widget _buildNextButton() {
  //   return Align(
  //     alignment: Alignment.bottomRight,
  //     child: GestureDetector(
  //       onTap: () {
  //         if (selectedDate != null && selectedSlotIndex != null && selectedCourtIndex != null) {
  //           if (playWithStrangers) {
  //             // Navigate to JoinPaymentView
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => JoinPaymentView(
  //                   turfRate: widget.turfRate,
  //                   numberOfPeople: int.tryParse(_numberOfPeopleController.text) ?? 1, // Default to 1 if parsing fails
  //                 ),
  //               ),
  //             );
  //           } else {
  //             // Navigate to SinglePaymentView
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => SinglePaymentView(
  //                   turfRate: widget.turfRate,
  //                 ),
  //               ),
  //             );
  //           }
  //         }
  //       },
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //         child: const Icon(Icons.arrow_forward, color: Colors.green),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNextButton() {
  return Align(
    alignment: Alignment.bottomRight,
    child: GestureDetector(
      onTap: () {
        if (selectedDate != null && selectedSlotIndex != null && selectedCourtIndex != null) {
          if (playWithStrangers) {
            Get.to(() => JoinPaymentView(
              turfRate: widget.turfRate,
              numberOfPeople: int.parse(_numberOfPeopleController.text),
            ));
          } else {
            Get.to(() => SinglePaymentView(
              turfRate: widget.turfRate,
            ));
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: const Icon(Icons.arrow_forward, color: Colors.green),
      ),
    ),
  );
}

  String _getSlotString(int index) {
    List<String> slots = ["8am-10am", "10am-12pm", "12pm-2pm", "6pm-7pm"];
    return slots[index];
  }
}
