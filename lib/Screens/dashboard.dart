import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/widgets/dashboard_buttons.dart';

import 'maintenances.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DashboardButton(
              title: 'Maintenance',
              icon: Icons.build,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>const Maintenances()),
                );
              },
            ),
            const SizedBox(height: 20),
            DashboardButton(
              title: 'Guests',
              icon: Icons.people,
              onPressed: () {
                // Add your guests button logic here
              },
            ),
            const SizedBox(height: 20),
            DashboardButton(
              title: 'Reservations',
              icon: Icons.calendar_today,
              onPressed: () {
                // Add your reservations button logic here
              },
            ),
            const SizedBox(height: 20),
            DashboardButton(
              title: 'Support',
              icon: Icons.thumb_up,
              onPressed: () {
                // Add your support button logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
