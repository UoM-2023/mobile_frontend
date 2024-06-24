import 'package:apartflow_mobile_app/Screens/dashboard.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:flutter/material.dart';

import 'package:apartflow_mobile_app/Screens/community_chat/community.dart';

import '../Screens/Bills.dart';

class NavigationMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavigationMenu({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment_rounded),
          label: 'Bills',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_rounded),
          label: 'Community',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Constants.primaryColor,
      onTap: (index) {
        onItemTapped(index); // Call the provided callback function

        // Add your navigation logic here based on the selected index
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
            break;
          case 1:
            // Navigate to Bills page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinancePage()),
            );
            break;
          case 2:
            // Navigate to Community page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Community()),
            );
            break;
          default:
            break;
        }
      },
    );
  }
}
