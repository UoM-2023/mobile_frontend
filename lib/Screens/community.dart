import 'package:flutter/material.dart';

import '../widgets/bottomnavigationbar.dart'; // Import your user profile widget

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  int _selectedIndex = 2; // Assuming this is the index for the search page

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