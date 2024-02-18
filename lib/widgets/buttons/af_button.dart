import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AFButton extends StatelessWidget {
  final ButtonType type;
  final VoidCallback onPressed;
  final double? paddingX;
  final double? paddingY;
  final double? fontSize;
  final IconData? icon;
  final String text;
  final bool shadow;

  const AFButton(
      {super.key,
      required this.type,
      required this.onPressed,
      required this.text,
      this.paddingX,
      this.paddingY,
      this.icon,
      this.fontSize,
      this.shadow = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(type == ButtonType.primary
            ? Constants.primaryColor
            : type == ButtonType.secondary
                ? Constants.secondaryColor
                : type == ButtonType.faded
                    ? Constants.fadedColor
                    : const Color(0xFFFFFFFF)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: paddingX ?? Constants.multiplier * 2,
            vertical: paddingY ?? Constants.multiplier * 1,
          ),
        ),
        shadowColor: shadow
            ? MaterialStateProperty.all<Color>(Constants.shadowColor)
            : null,
        elevation: shadow ? MaterialStateProperty.all<double>(2) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) // Conditionally include icon if it's not null
            Icon(
              icon!,
              size: Constants.multiplier * 2.5,
              color: type == ButtonType.primary
                  ? Constants.primaryIconColor
                  : type == ButtonType.faded
                      ? Constants.fadedIconColor
                      : const Color.fromARGB(92, 20, 1, 1),
            ),
          if (icon != null)
            const SizedBox(
                width: Constants.multiplier *
                    1.5), // Adjust as needed for spacing between icon and text
          Text(
            text,
            style: GoogleFonts.lato(
              color: type == ButtonType.primary
                  ? Constants.primaryTextColor
                  : type == ButtonType.secondary
                      ? Constants.secondaryTextColor
                      : Constants.fadedTextColor,
              fontSize: fontSize ?? Constants.multiplier * 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton_1 extends StatelessWidget {
  final Color color;
  final IconData? icon; // Making icon nullable

  final double size;
  final double horizontalPadding;
  // final double verticalPadding;
  final VoidCallback onPressed;
  final String text;

  const CustomButton_1({
    Key? key,
    required this.color,
    this.icon, // Making icon nullable

    required this.size,
    required this.horizontalPadding,
    //required this.verticalPadding,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            // Replace Constants.multiplier * 1 with your desired value or Constants.multiplier itself
            vertical: Constants.multiplier * 1, // Adjust vertical padding here
          ),
        ),
        shadowColor:
            MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.3)),
        elevation: MaterialStateProperty.all<double>(2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) // Conditionally include icon if it's not null
            Icon(
              icon!,
              size: 20,
              color: const Color.fromARGB(92, 20, 1, 1),
            ),
          if (icon != null)
            const SizedBox(
                width: 8), // Adjust as needed for spacing between icon and text
          Text(
            text,
            style: GoogleFonts.lato(
              color: const Color.fromARGB(151, 255, 255, 255),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton_2 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;

  const CustomButton_2({
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

class ResetPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ResetPasswordButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
        'Reset Password',
        style: TextStyle(
          color: Color.fromARGB(120, 0, 0, 0),
        ),
      ),
    );
  }
}

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
      height: 80,
      width: 350,
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
                fontSize: 20,
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
