import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 114, 70),
      appBar: AppBar(
        title: const Text(
          "Maintenance",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text(
          'Notifications Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
       bottomNavigationBar: NavigationMenu(selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });} ),
    );
  }
}
