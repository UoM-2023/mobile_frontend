import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/reservation.dart';
import '../../models/enum.dart';
import '../buttons/af_button.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';

final formatter = DateFormat.yMd();

class NewReservation extends StatefulWidget {
  const NewReservation({Key? key, required this.onAddReservation});

  final void Function(dynamic reservation) onAddReservation;

  @override
  State<NewReservation> createState() => _NewReservationState();
}

class _NewReservationState extends State<NewReservation> {
  AmenityType _selectedAmenityType = AmenityType.CommunityRoom;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedStartTime;
  final _formKey = GlobalKey<FormState>();
  final _needTimeController = TextEditingController();

  @override
  void dispose() {
    _needTimeController.dispose();
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

  void _submitReservationData() {
    if (_formKey.currentState!.validate()) {
      widget.onAddReservation(Reservation(
        amenityName: _selectedAmenityType,
        startDate: _selectedStartDate!,
        endDate: _selectedEndDate!,
        time: _selectedStartTime!,
        needForHours: _needTimeController.text,
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
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amenity Name',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    DropdownButtonFormField<AmenityType>(
                      value: _selectedAmenityType,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedAmenityType = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Select the Type',
                        border: OutlineInputBorder(),
                      ),
                      items: AmenityType.values.map((type) {
                        return DropdownMenuItem<AmenityType>(
                          value: type,
                          child: Text(type.name.toUpperCase()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Reservation Start Date',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: _selectedStartDate != null
                            ? formatter.format(_selectedStartDate!)
                            : '',
                      ),
                      onTap: _startDatePicker,
                      decoration: const InputDecoration(
                        hintText: 'Selected Date',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (_selectedStartDate == null) {
                          return 'Please select a start date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Reservation End Date',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: _selectedEndDate != null
                            ? formatter.format(_selectedEndDate!)
                            : '',
                      ),
                      onTap: _endDatePicker,
                      decoration: const InputDecoration(
                        hintText: 'Selected Date',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (_selectedEndDate == null) {
                          return 'Please select an end date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Reservation End Time',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: _selectedStartTime != null
                            ? _selectedStartTime!.format(context)
                            : '',
                      ),
                      onTap: _startTimePicker,
                      decoration: const InputDecoration(
                        hintText: 'Selected Time',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (_selectedStartTime == null) {
                          return 'Please select a start time';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Need for (Hours)',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _needTimeController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        hintText: 'Type here',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the hours needed';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
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
                          onPressed: _submitReservationData,
                          text: Strings.save,
                        ),
                      ],
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
