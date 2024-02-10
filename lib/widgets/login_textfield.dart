// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData iconData;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),

        // ignore: prefer_const_constructors
        child: SizedBox(
            width: 293,
            height: 50,
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(10, 0, 0, 0),
                hintText: hintText,
                hintStyle: GoogleFonts.lato(
                  color: Color(0x5E000000),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Ensure the row takes minimum space
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Icon(
                      iconData,
                      color: Colors.grey[500],
                    ),
                    SizedBox(width: 12), // Add space between icon and text
                  ],
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            )));
  }
}
