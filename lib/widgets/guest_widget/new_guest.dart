import 'package:apartflow_mobile_app/global.dart';
import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../buttons/af_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final formatter = DateFormat.yMd();

class NewGuest extends StatefulWidget {
  const NewGuest({super.key});

  

  @override
  State<NewGuest> createState() => _NewGuestState();
}

class _NewGuestState extends State<NewGuest> {
  DateTime? _selectedArrivalDate;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nicController = TextEditingController();
  final _vehicleNOController = TextEditingController();
User? _user;

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
    _nameController.dispose();
    _nicController.dispose();
    _vehicleNOController.dispose();
    super.dispose();
  }

  void _arrivalDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month + 1, now.day);
    final pickedArrivalDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedArrivalDate != null) {
      setState(() {
        _selectedArrivalDate = pickedArrivalDate;
      });
    }
  }

 Future<void> _submitGuestData(String name,  String nic,String vehicleNo,DateTime arrivalDate ) async {
    if (_formKey.currentState!.validate()) {
      try {
       
        final response = await http.post(
          Uri.parse('${baseurl}/GuestDetail/GuestDetails'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'unit_ID': _user!.unitId, // Include unit ID in the request body
            'guest_name': name, 
            'guest_NIC': nic,
            'vehicle_number': vehicleNo,
            'arrival_date': _selectedArrivalDate!.toIso8601String(),
          }),
        );

        if (response.statusCode == 200) {
          // Handle success response
          print('Guest information added successfully');
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
          print('Failed to add guest information. Status code: ${response.statusCode}');
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
                _submitGuestData(
                  _nameController.text,
                  _nicController.text,
                  _vehicleNOController.text,
                _selectedArrivalDate!,
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
                      'Name',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        hintText: 'Type here',
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'NIC',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextFormField(
                      controller: _nicController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        hintText: 'Type here',
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter a NIC';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Vehicle No',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextFormField(
                      controller: _vehicleNOController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        hintText: 'Type here',
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter a vehicle number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Arrival Date',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: TextEditingController(
                        text: _selectedArrivalDate != null ? formatter.format(_selectedArrivalDate!) : '',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Date',
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
                          onPressed: _arrivalDatePicker,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an arrival date';
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
