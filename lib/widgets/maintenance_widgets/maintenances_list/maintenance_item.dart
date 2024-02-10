import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/maintenance.dart';

class MaintenanceItem extends StatelessWidget {
  const MaintenanceItem(this.maintenance, {super.key});

  final Maintenance maintenance;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Row
            Row(
              children: [
                Text(
                  maintenance.category
                      .toString()
                      .split('.')
                      .last
                      .replaceAll('_', ' '),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
           const  SizedBox(height: 4),
            // Description and Date Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(maintenance.description),
                Text(maintenance.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
