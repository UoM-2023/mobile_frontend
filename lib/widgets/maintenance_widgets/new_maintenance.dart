import 'dart:convert';
import 'package:apartflow_mobile_app/global.dart';
import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:flutter/material.dart';
import '../buttons/af_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewMaintenance extends StatefulWidget {
  const NewMaintenance({super.key});

  

  @override
  State<NewMaintenance> createState() => _NewMaintenanceState();
}

class _NewMaintenanceState extends State<NewMaintenance> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  User? _user;
   

  final List<String> _items = [
    'Plumbing',
    'Electrical',
    'HVAC',
    'Appliances',
    'General Maintenance',
    'Pest Control',
    'Safety and Security',
    'Grounds keeping',
    'Structural Repairs'
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
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitMaintenanceData(String description, String category) async {
    if (_formKey.currentState!.validate()) {
      try {
       
        final response = await http.post(
          Uri.parse('${baseurl}/maintenance/New_Mnt_Req'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'Unit_id': _user!.unitId, // Include unit ID in the request body
            'MType': category,
            'M_Description': description,
            'Mnt_Status' : 'Pending', // Include description
          }),
        );

        if (response.statusCode == 200) {
          // Handle success response
          print('Maintenance request added successfully');
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
          print('Failed to add maintenance request. Status code: ${response.statusCode}');
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
                _submitMaintenanceData(
                  _descriptionController.text,
                  _selectedCategory ?? '',
                  
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Type',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    items: _items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Select an option',
                      border: OutlineInputBorder(),
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
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      hintText: 'Type here',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 230, 168, 114)),
                      ),
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
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
          ],
        ),
      ),
    );
  }
}