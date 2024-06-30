import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:apartflow_mobile_app/widgets/reservations_widget.dart/new_reservation.dart';
import 'package:apartflow_mobile_app/widgets/reservations_widget.dart/reservation_item.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/reservation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottomnavigationbar.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  int _selectedIndex = 0;
  
   List<Reservation> _registeredReservations = [];
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
      _fetchReservationData(user.unitId);
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

 Future<void> _fetchReservationData(String unitID) async {
    
    try {
      List<Reservation> reservations = await Reservation.fetchReservationList(unitID);
      print('Fetched Reservations: $Reservations');
      setState(() {
        _registeredReservations = reservations;
        _isLoading = false;
      });
    } catch (error) {
      print('Error in _fetchReservationData: $error');
      setState(() {
        _errorMessage = 'Failed to load data: $error';
        _isLoading = false;
      });
    }
  }
  
  Future<void> _openAddReservationOverlay() async {
    // Await the result from the NewMaintenance screen
    final result = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewReservation(),
    );

  // If the result is true, refresh the list of maintenance requests
    if (result == true) {
      _fetchReservationData(_user!.unitId);
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 234, 114, 70),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                  onPressed: _openAddReservationOverlay,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ]),
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        
        body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _registeredReservations.isEmpty
                  ? const Center(child: Text('You have no reservations yet'))
              : ListView.builder(
                  itemCount: _registeredReservations.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = _registeredReservations.length - 1 - index;
                    return ReservationItem(_registeredReservations[reversedIndex]);
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
