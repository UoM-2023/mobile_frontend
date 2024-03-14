import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/guest.dart';
import '../buttons/af_button.dart';

final formatter = DateFormat.yMd();

class NewGuest extends StatefulWidget {
  const NewGuest({super.key, required this.onAddGuest});

  final void Function(dynamic guest) onAddGuest;

  @override
  State<NewGuest> createState() {
    return _NewGuest();
  }
}

class _NewGuest extends State<NewGuest> {
  DateTime? _selectedArrivalDate;
  final _nameController = TextEditingController();
  final _nicController = TextEditingController();
  final _vehicleNOController = TextEditingController();

  //to tell flutter that delete the controller when it is not needed anymore
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
        lastDate: lastDate);
    if (pickedArrivalDate != null) {
      setState(() {
        _selectedArrivalDate = pickedArrivalDate;
      });
    }

    //this line only execute once the value is available
    setState(() {
      _selectedArrivalDate = pickedArrivalDate;
    });
  }

  void _submitGuestData() {
    // Check if any of the DateTime or TimeOfDay variables are null before using them
    if (_selectedArrivalDate != null) {
      widget.onAddGuest(Guest(
        name: _nameController.text,
        vehicle_NO: _vehicleNOController.text,
        nic: _nicController.text,
        date: _selectedArrivalDate!,
      ));

      Navigator.pop(context);
    } else {
      print("Error: One or more required dates/times are null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: Column(children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //      Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ma),
                    // );
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name', // Label text
                  style: TextStyle(color: Colors.grey), // Label text color
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
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
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'NIC', // Label text
                  style: TextStyle(color: Colors.grey), // Label text color
                ),
                TextField(
                  controller: _nicController,
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
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Vehicle No', // Label text
                  style: TextStyle(color: Colors.grey), // Label text color
                ),
                TextField(
                  controller: _vehicleNOController,
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
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Arrival Date', // Label text
                  style: TextStyle(color: Colors.grey), // Label text color
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: TextEditingController(
                    text: _selectedArrivalDate != null
                        ? formatter.format(_selectedArrivalDate!)
                        : '',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Date', // Hint text
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
                      onPressed: _arrivalDatePicker,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AFButton(
                    type: ButtonType.secondary,
                    fontSize: Constants.multiplier * 1.7,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: Strings.cancel),
                const SizedBox(
                  width: 5,
                ),
                AFButton(
                    type: ButtonType.primary,
                    fontSize: Constants.multiplier * 1.7,
                    onPressed: _submitGuestData,
                    text: Strings.save),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
