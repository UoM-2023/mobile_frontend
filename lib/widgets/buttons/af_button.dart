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

