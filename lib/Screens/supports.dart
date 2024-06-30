import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:apartflow_mobile_app/widgets/support_widget.dart/support_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:apartflow_mobile_app/models/support.dart';

import '../widgets/bottomnavigationbar.dart';
import '../widgets/support_widget.dart/new_support.dart';


class Supports extends StatefulWidget {
  const Supports({super.key});
  @override
  State<Supports> createState() {
    return _SupportsState();
  }
}

//dummy data
class _SupportsState extends State<Supports> {
  int _selectedIndex = 0;
   List<Support> _registeredSupports = [];
bool _isLoading = true;
  String? _errorMessage;
   User? _user;

@override
  void initState() {
    super.initState();
    _fetchUserData();
  }

Future<void> _fetchUserData() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      User user = await User.fetchUserDetails(userId);
      setState(() {
        _user = user;
      });
      _fetchSupportData(user.unitId);
    } else {
      print('User ID not found.');
      setState(() {
        _errorMessage = 'User ID not found.';
        _isLoading = false;
      });
    }
  } catch (error) {
    print('Error in _fetchUserDetails: $error');
    setState(() {
      _errorMessage = 'Failed to load user details: $error';
      _isLoading = false;
    });
  }
}

Future<void> _fetchSupportData(String unitID) async {
    
    try {
      List<Support> supports = await Support.fetchSupportList(unitID);
      print('Fetched supports: $supports');
      setState(() {
        _registeredSupports = supports;
        _isLoading = false;
      });
    } catch (error) {
      print('Error in _fetchSupportData: $error');
      setState(() {
        _errorMessage = 'Failed to load data: $error';
        _isLoading = false;
      });
    }
  }

 Future<void> _openAddSupportOverlay() async {
    // Await the result from the NewMaintenance screen
    final result = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewSupport(),
    );

  
    if (result == true) {
      _fetchSupportData(_user!.unitId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        appBar: AppBar(
            title: const Text(
              "Support",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 234, 114, 70),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                  onPressed: _openAddSupportOverlay,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ]),
        body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _registeredSupports.isEmpty
                  ? const Center(child: Text('You have no maintenance requests yet'))
              : ListView.builder(
                  itemCount: _registeredSupports.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = _registeredSupports.length - 1 - index;
                    return SupportItem(_registeredSupports[reversedIndex]);
                  },
                ),
        bottomNavigationBar: NavigationMenu(selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });} ),
        );
  }
}
