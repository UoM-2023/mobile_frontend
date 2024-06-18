import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/support.dart';
import 'package:apartflow_mobile_app/models/enum.dart';
import '../buttons/af_button.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';

class NewSupport extends StatefulWidget {
  const NewSupport({Key? key, required this.onAddSupport});

  final void Function(Support support) onAddSupport;

  @override
  State<NewSupport> createState() => _NewSupportState();
}

class _NewSupportState extends State<NewSupport> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  SupportCategory _selectedSupportCategory = SupportCategory.Suggestions;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitSupportData() {
    if (_formKey.currentState!.validate()) {
      widget.onAddSupport(Support(
        description: _descriptionController.text,
        date: DateTime.now(),
        Supportcategory: _selectedSupportCategory,
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
                    const SizedBox(height: 8),
                    DropdownButtonFormField<SupportCategory>(
                      value: _selectedSupportCategory,
                      decoration: InputDecoration(
                        hintText: 'Select the Type',
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
                        labelText: 'Type',
                        labelStyle: const TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedSupportCategory = value;
                          });
                        }
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLength: 50,
                      decoration: InputDecoration(
                        hintText: 'Type here',
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
                        labelText: 'Description',
                        labelStyle: const TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
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
                          onPressed: _submitSupportData,
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
