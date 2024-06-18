import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData iconData;
  final String? Function(String?)? validator; // Validator function

  const LogInTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.iconData,
    this.validator, // Accept validator as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: SizedBox(
        width: 293,
        height: 50,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(10, 0, 0, 0),
            hintText: hintText,
            hintStyle: GoogleFonts.lato(
              color: const Color(0x5E000000),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 12),
                Icon(
                  iconData,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 12),
              ],
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
          validator: validator, // Set validator function
        ),
      ),
    );
  }
}
