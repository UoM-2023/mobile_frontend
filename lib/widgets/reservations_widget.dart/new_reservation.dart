import 'package:apartflow_mobile_app/models/reservation.dart';
import 'package:apartflow_mobile_app/models/enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../buttons/af_button.dart';

final formatter = DateFormat.yMd();

class NewReservation extends StatefulWidget {
  const NewReservation({Key? key, required this.onAddReservation});

  final void Function(dynamic reservation) onAddReservation;

  @override
  State<NewReservation> createState() {
    return _NewReservation();
  }
}

class _NewReservation extends State<NewReservation> {
  AmenityType _selectedAmenityType = AmenityType.CommunityRoom;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedStartTime;

  final _needTimeController = TextEditingController();

//to tell flutter that delete the controller when it is not needed anymore
  @override
  void dispose() {
    _needTimeController.dispose();
    super.dispose();
  }

  void _startDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month + 1, now.day);
    final pickedStartDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    if (pickedStartDate != null) {
      setState(() {
        _selectedStartDate = pickedStartDate;
      });
    }

    //this line only execute once the value is available
    setState(() {
      _selectedStartDate = pickedStartDate;
    });
  }

  void _endDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month + 1, now.day);
    final pickedEndDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    if (pickedEndDate != null) {
      setState(() {
        _selectedEndDate = pickedEndDate;
      });
    }

    //this line only execute once the value is available
    setState(() {
      _selectedEndDate = pickedEndDate;
    });
  }

  void _startTimePicker() async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedStartTime != null) {
      setState(() {
        _selectedStartTime = pickedStartTime;
      });
    }
  }

  void _submitReservationData() {
    // Check if any of the DateTime or TimeOfDay variables are null before using them
    if (_selectedStartDate != null &&
        _selectedEndDate != null &&
        _selectedStartTime != null) {
      widget.onAddReservation(Reservation(
        amenityName: _selectedAmenityType,
        startDate: _selectedStartDate!,
        endDate: _selectedEndDate!,
        time: _selectedStartTime!,
        needForHours: _needTimeController.text,
      ));

      Navigator.pop(context);
    } else {
      print("Error: One or more required dates/times are null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Amenity Name', // Label text
              style: TextStyle(color: Colors.grey), // Label text color
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField<AmenityType>(
              value: _selectedAmenityType,
              decoration: const InputDecoration(
                hintText: 'Select the Type', // Hint text
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                ),
                labelStyle: TextStyle(color: Colors.grey), // Label text color
              ),
              items: AmenityType.values
                  .map(
                    (category) => DropdownMenuItem<AmenityType>(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedAmenityType = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Reservation Start Date', // Label text
              style: TextStyle(color: Colors.grey), // Label text color
            ),
            const SizedBox(height: 5),
            TextField(
              controller: TextEditingController(
                text: _selectedStartDate != null
                    ? formatter.format(_selectedStartDate!)
                    : '',
              ),
              decoration: InputDecoration(
                hintText: 'Selected Date', // Hint text
                border: const OutlineInputBorder(), // Border
                enabledBorder: const OutlineInputBorder(
                  // Border when enabled
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  // Border when focused
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                ),
                labelStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _startDatePicker,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Reservation End Date', // Label text
              style: TextStyle(color: Colors.grey), // Label text color
            ),
            const SizedBox(height: 5),
            TextField(
              controller: TextEditingController(
                text: _selectedEndDate != null
                    ? formatter.format(_selectedEndDate!)
                    : '',
              ),
              decoration: InputDecoration(
                hintText: 'Selected Date', // Hint text
                border: const OutlineInputBorder(), // Border
                enabledBorder: const OutlineInputBorder(
                  // Border when enabled
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  // Border when focused
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                ),
                labelStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _endDatePicker,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Reservation End Time', // Label text
              style: TextStyle(color: Colors.grey), // Label text color
            ),
            const SizedBox(height: 5),
            TextField(
              controller: TextEditingController(
                text: _selectedStartTime != null
                    ? _selectedStartTime!.format(context)
                    : '',
              ),
              decoration: InputDecoration(
                hintText: 'Selected Time', // Hint text
                border: const OutlineInputBorder(), // Border
                enabledBorder: const OutlineInputBorder(
                  // Border when enabled
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  // Border when focused
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                ),
                labelStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: _startTimePicker,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Need for (Hours)',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _needTimeController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    hintText: 'Type here', // Hint text
                    border: OutlineInputBorder(), // Border
                    enabledBorder: OutlineInputBorder(
                      // Border when enabled
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Border when focused
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                    ),
                    labelStyle:
                        TextStyle(color: Colors.grey), // Label text color
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton_2(
                    text: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    buttonColor: Colors.grey[300]!,
                    textColor: Colors.black),
                const SizedBox(
                  width: 5,
                ),
                CustomButton_2(
                  text: 'Save',
                  onPressed: _submitReservationData,
                  buttonColor: Colors.orange[700]!,
                  textColor: Colors.white,
                )
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
