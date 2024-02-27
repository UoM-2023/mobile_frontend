import 'package:flutter/material.dart';

import '../widgets/bottomnavigationbar.dart'; // Import your user profile widget

class Bills extends StatefulWidget {
  const Bills({Key? key}) : super(key: key);

  @override
  _BillsState createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  int _selectedIndex = 1; // Assuming this is the index for the search page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Bills'),
      ),
      body: const Center(
        child: Text('Search Page Content'),
      ),
      bottomNavigationBar: NavigationMenu(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
