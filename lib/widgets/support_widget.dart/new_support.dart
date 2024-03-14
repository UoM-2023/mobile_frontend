import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/support.dart';
//import 'package:maintenance/widgets/maintenances_list/maintenances_list.dart';
import 'package:apartflow_mobile_app/models/enum.dart';

import '../buttons/af_button.dart';

class NewSupport extends StatefulWidget {
  const NewSupport({super.key, required this.onAddSupport});

  final void Function(Support support) onAddSupport;

  @override
  State<NewSupport> createState() {
    return _NewSupport();
  }
}

class _NewSupport extends State<NewSupport> {
  final _descriptionController = TextEditingController();
  SupportCategory _selectedSupportCategory = SupportCategory.Suggestions;

  //to tell flutter that delete the controller when it is not needed anymore
  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitSupportData() {
    widget.onAddSupport(Support(
        description: _descriptionController.text,
        date: DateTime.now(),
        Supportcategory: _selectedSupportCategory));
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
              const SizedBox(height: 8),
              DropdownButtonFormField<SupportCategory>(
                value: _selectedSupportCategory,
                decoration: InputDecoration(
                  hintText: 'Select the Type', // Hint text
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 230, 168, 114)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Type', // Label text
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
                isExpanded: false,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedSupportCategory = value;
                  });
                },
                items: SupportCategory.values.map((category) {
                  return DropdownMenuItem<SupportCategory>(
                    value: category,
                    child: Text(
                      category.name.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLength: 50,
              decoration: InputDecoration(
                hintText: 'Type here', // Hint text
                border: const OutlineInputBorder(), // Border
                enabledBorder: OutlineInputBorder(
                  // Border when enabled
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      8.0), // Rounded corners for the border
                ),
                focusedBorder: OutlineInputBorder(
                  // Border when focused
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 230, 168, 114)),
                  borderRadius: BorderRadius.circular(
                      8.0), // Rounded corners for the border
                ),
                labelText: 'Description', // Label text
                labelStyle:
                    const TextStyle(color: Colors.grey), // Label text color
              ),
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
                    onPressed: _submitSupportData,
                    text: Strings.save),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
