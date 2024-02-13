import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;

  const DashboardButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          backgroundColor: const Color.fromARGB(250, 252, 239, 230),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: iconColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(180, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}

class IconColor {}
