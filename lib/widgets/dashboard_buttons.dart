import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const DashboardButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
