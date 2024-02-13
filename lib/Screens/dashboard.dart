import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/widgets/dashboard_buttons.dart';
import 'maintenances.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 114, 70),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 130,
            color: const Color.fromARGB(255, 234, 114, 70),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DashboardButton(
                          title: 'Maintenance',
                          icon: Icons.build,
                          iconColor: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Maintenances(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 30),
                        DashboardButton(
                          title: 'Guests',
                          icon: Icons.people,
                          iconColor: Colors.green,
                          onPressed: () {
                            // Add your guests button logic here
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DashboardButton(
                          title: 'Reservations',
                          icon: Icons.calendar_today,
                          iconColor: Colors.yellow,
                          onPressed: () {
                            // Add your reservations button logic here
                          },
                        ),
                        const SizedBox(width: 30),
                        DashboardButton(
                          title: 'Support',
                          icon: Icons.thumb_up,
                          iconColor: Colors.red,
                          onPressed: () {
                            // Add your support button logic here
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
