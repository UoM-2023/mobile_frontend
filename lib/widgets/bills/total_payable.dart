import 'package:flutter/material.dart';

class TotalPaymentCard extends StatelessWidget {
  final String amount;

  final VoidCallback? onPressed; // Callback function for button press

  const TotalPaymentCard({
    Key? key,
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
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 30),
        color: const Color.fromARGB(255, 253, 222, 201),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Total Payable Amount",
                      style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
