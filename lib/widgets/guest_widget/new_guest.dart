import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/guest.dart';
import '../buttons/af_button.dart';

final formatter = DateFormat.yMd();

class NewGuest extends StatefulWidget {
  const NewGuest({Key? key, required this.onAddGuest}) : super(key: key);

  final void Function(dynamic guest) onAddGuest;

  @override
  State<NewGuest> createState() => _NewGuestState();
}

class _NewGuestState extends State<NewGuest> {
  DateTime? _selectedArrivalDate;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nicController = TextEditingController();
  final _vehicleNOController = TextEditingController();

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

  void _submitGuestData() {
    if (_formKey.currentState!.validate()) {
      widget.onAddGuest(Guest(
        name: _nameController.text,
        vehicle_NO: _vehicleNOController.text,
        nic: _nicController.text,
        date: _selectedArrivalDate!,
      ));
      Navigator.pop(context);
    }
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
                      onPressed: _submitGuestData,
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
