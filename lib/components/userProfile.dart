import 'package:flutter/material.dart';

class Userprofile extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String houseNumber;
  final String residentID;

  Userprofile({
    required this.name,
    required this.phoneNumber,
    required this.houseNumber,
    required this.residentID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical:8.0 ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Phone Number: $phoneNumber',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700], 
                fontWeight: FontWeight.bold,// Use a slightly darker color for less emphasis
              ),
            ),
            SizedBox(height: 4),
            Text(
              'House Number: $houseNumber',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Resident Id: $residentID',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
