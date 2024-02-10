import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        foregroundColor: MaterialStateProperty.all<Color>(textColor),
      ),
      child: Text(text),
    );
  }
}
