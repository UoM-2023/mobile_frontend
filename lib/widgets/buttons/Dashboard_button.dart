import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;
  final double? fontSize;

  const DashboardButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.multiplier * 10,
      width: Constants.multiplier * 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          backgroundColor: const Color.fromARGB(250, 252, 239, 230),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(icon, size: 30, color: iconColor),
                  )),
            ),
            const SizedBox(width: 30),
            Text(
              title,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(182, 0, 0, 0),
                fontSize: fontSize ?? Constants.multiplier * 2.3,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 1),
            const Icon(
                color: Color.fromARGB(182, 0, 0, 0),
                Icons.keyboard_double_arrow_right_rounded),
          ],
        ),
      ),
    );
  }
}
