import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/maintenance.dart';
//import 'package:maintenance/widgets/maintenances_list/maintenances_list.dart';
import 'package:apartflow_mobile_app/models/enum.dart';


import '../buttons/af_button.dart';

class NewMaintenance extends StatefulWidget {
  const NewMaintenance({super.key, required this.onAddMaintenance});

  final void Function(Maintenance maintenance) onAddMaintenance;

  @override
  State<NewMaintenance> createState() {
    return _NewMaintenance();
  }
}

class _NewMaintenance extends State<NewMaintenance> {
  final _descriptionController = TextEditingController();
  MaintenanceCategory _selectedCategory = MaintenanceCategory.Appliances;

  //to tell flutter that delete the controller when it is not needed anymore
  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitMaintenanceData() {
    widget.onAddMaintenance(Maintenance(
        description: _descriptionController.text,
        date: DateTime.now(),
        category: _selectedCategory));
    Navigator.pop(context);
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
                'Type', // Label text
                style: TextStyle(color: Colors.grey), // Label text color
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<MaintenanceCategory>(
                value: _selectedCategory,
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
                items: MaintenanceCategory.values
                    .map(
                      (category) => DropdownMenuItem<MaintenanceCategory>(
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
                    _selectedCategory = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Description',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
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
                labelStyle: TextStyle(color: Colors.grey), // Label text color
              ),
            ),
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
                  onPressed: _submitMaintenanceData,
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
