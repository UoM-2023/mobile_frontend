import 'package:apartflow_mobile_app/global.dart';
import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/reservation.dart';
import '../../models/enum.dart';
import '../buttons/af_button.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final formatter = DateFormat.yMd();

class NewReservation extends StatefulWidget {
  const NewReservation({super.key});

  

  @override
  State<NewReservation> createState() => _NewReservationState();
}

class _NewReservationState extends State<NewReservation> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedAmenityType;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
   User? _user;


final List<String> _items =[
  'Gym',
  'Pool',
  'Event Hall'
];


@override
  void initState() {
    super.initState();
    _fetchUserDetails(); // Fetch user details when the widget initializes
  }

    Future<void> _fetchUserDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId != null) {
        print('Fetching details for userID: $userId');
        User user = await User.fetchUserDetails(userId); // Fetch user details using the user ID
        setState(() {
          _user = user;
        });
      } else {
        print('User ID not found.');
      }
    } catch (error) {
      print('Error fetching user details: $error');
    }
  }
  @override
  void dispose() {
    
    super.dispose();
  }

  void _startDatePicker() async {
    final now = DateTime.now();
    final pickedStartDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month + 1, now.day),
    );
    if (pickedStartDate != null) {
      setState(() {
        _selectedStartDate = pickedStartDate;
      });
    }
  }

  void _endDatePicker() async {
    final now = DateTime.now();
    final pickedEndDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month + 1, now.day),
    );
    if (pickedEndDate != null) {
      setState(() {
        _selectedEndDate = pickedEndDate;
      });
    }
  }

  void _startTimePicker() async {
    final pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime != null) {
      setState(() {
        _selectedStartTime = pickedStartTime;
      });
    }
  }

  void _endTimePicker() async {
    final pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedEndTime != null) {
      setState(() {
        _selectedEndTime = pickedEndTime;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
  final String hour = time.hour.toString().padLeft(2, '0');
  final String minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

 Future<void> _submitReservationData(String amenityType, DateTime startDate , DateTime endDate, TimeOfDay startTime, TimeOfDay endTime ) async {
    if (_formKey.currentState!.validate()) {
      try {
       final String formattedStartTime = formatTimeOfDay(startTime);
      final String formattedEndTime = formatTimeOfDay(endTime);

        final response = await http.post(
          Uri.parse('${baseurl}/Reservation/Reservations'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'Unit_id': _user!.unitId, // Include unit ID in the request body
            'facility_name': amenityType,
            'start_date': _selectedStartDate!.toIso8601String(),
            'end_date': _selectedEndDate!.toIso8601String(),
            'start_time': formattedStartTime,
            'end_time': formattedEndTime,
            'availability' : 'not yet', // Include description
          }),
        );

        if (response.statusCode == 200) {
          // Handle success response
          print('reservation request added successfully');
          // Show success dialog
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Your request has been added successfully.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          if(!context.mounted){
            return;
          }
          Navigator.of(context).pop(true);
        } else {
          // Handle error response
          print('Failed to add reservation request. Status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (error) {
        // Handle any exceptions
        print('Error: $error');
      }
    }
  }

   void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Are you sure you want to add this request?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _submitReservationData(
                  _selectedAmenityType ?? '',
                  _selectedStartDate!,
                  _selectedEndDate!,
                  _selectedStartTime!,
                  _selectedEndTime!,
                   // Pass the selected category or an empty string if it's null
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: true,
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Form(
          key: _formKey,
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
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Amenity Type',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedAmenityType,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedAmenityType = value;
                      });
                    },
                    items: _items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      hintText: 'Select an option',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                      ),
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    dropdownColor: Colors.white,
                    isExpanded: true,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Start Date',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: TextEditingController(
                      text: _selectedStartDate != null ? formatter.format(_selectedStartDate!) : '',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Select date',
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: _startDatePicker,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a start date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'End Date',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: TextEditingController(
                      text: _selectedEndDate != null ? formatter.format(_selectedEndDate!) : '',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Select date',
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: _endDatePicker,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an end date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Start Time',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: TextEditingController(
                      text: _selectedStartTime != null ? _selectedStartTime!.format(context) : '',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Select time',
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: _startTimePicker,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a start time';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'End Time',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: TextEditingController(
                      text: _selectedEndTime != null ? _selectedEndTime!.format(context) : '',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Select time',
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 230, 168, 114)),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: _endTimePicker,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an end time';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AFButton(
                    type: ButtonType.secondary,
                    fontSize: Constants.multiplier * 1.7,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: Strings.cancel,
                  ),
                  const SizedBox(width: 5),
                  AFButton(
                    type: ButtonType.primary,
                    fontSize: Constants.multiplier * 1.7,
                    onPressed: _showConfirmationDialog,
                    text: Strings.save,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
