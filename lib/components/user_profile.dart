import 'package:flutter/material.dart';

class UserProfileWidget extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String houseNumber;
  final String blockNumber;
  final String buildingName;

  const UserProfileWidget({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.houseNumber,
    required this.blockNumber,
    required this.buildingName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 15),
          buildDetailRow('Tel No:', phoneNumber),
          buildDetailRow('Unit No:', houseNumber),
          buildDetailRow('Block No:', blockNumber),
          buildDetailRow('Building No:', buildingName),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
