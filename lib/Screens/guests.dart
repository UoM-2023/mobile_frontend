import 'package:apartflow_mobile_app/models/guest.dart';
import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:apartflow_mobile_app/widgets/guest_widget/guest_item.dart';
import 'package:apartflow_mobile_app/widgets/guest_widget/new_guest.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guests extends StatefulWidget {
  const Guests({super.key});
  @override
  State<Guests> createState() => _GuestsState();
}

//dummy data
class _GuestsState extends State<Guests> {
   int _selectedIndex = 0;
   List<Guest> _registeredGuests = [];
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
      _fetchGuestData(user.unitId);
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

  Future<void> _fetchGuestData(String unitID) async {
    
    try {
      List<Guest> guests = await Guest.fetchGuestList(unitID);
      print('Fetched guests: $Guests');
      setState(() {
        _registeredGuests = guests;
        _isLoading = false;
      });
    } catch (error) {
      print('Error in _fetchGuestData: $error');
      setState(() {
        _errorMessage = 'Failed to load data: $error';
        _isLoading = false;
      });
    }
  }
Future<void> _openAddGuestOverlay() async {
    // Await the result from the NewMaintenance screen
    final result = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewGuest(),
    );

  // If the result is true, refresh the list of maintenance requests
    if (result == true) {
      _fetchGuestData(_user!.unitId);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        appBar: AppBar(
            title: const Text(
              "Visitors",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 234, 114, 70),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                  onPressed: _openAddGuestOverlay,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ]),
        body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _registeredGuests.isEmpty
                  ? const Center(child: Text('You have no visitors yet'))
              : ListView.builder(
                  itemCount: _registeredGuests.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = _registeredGuests.length - 1 - index;
                    return GuestItem(_registeredGuests[reversedIndex]);
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
