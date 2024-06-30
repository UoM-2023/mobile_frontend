import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/Screens/amenities.dart';
import 'package:apartflow_mobile_app/Screens/reservations.dart';

class ReserveAmenities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
      appBar: AppBar(
        title: Text('Reservations'),
        
        bottom: TabBar(
          tabs: [
            Tab(text: 'reservations'),
            Tab(text: 'Amenities'),
          ],
        ),
      ),
       body: TabBarView(
          children: [
            Reservations(),
            Amenities(),
          ],
        ),
      ),
    );
  }
}
