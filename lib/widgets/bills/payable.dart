import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String title;
  final String amount;

  final VoidCallback? onPressed; // Callback function for button press

  const PaymentCard({
    Key? key,
    required this.title,
    required this.amount,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Set width to fill the screen
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        color: const Color.fromARGB(255, 255, 247, 241),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              if (onPressed != null)
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.grey.withOpacity(0.8),
                    elevation: 4.0, // Shadow elevation
                  ),
                  child: const Text(
                    'Pay',
                    style: TextStyle(
                        color: Color.fromARGB(
                            150, 0, 0, 0)), // Text color set to black
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
