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
          buildDetail('Tel No:', phoneNumber),
          buildDetail('Unit No:', houseNumber),
          buildDetail('Block No:', blockNumber),
          buildDetail('Building No:', buildingName),
        ],
      ),
    );
  }

  Widget buildDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label $value',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 1),
      ],
    );
  }
}
