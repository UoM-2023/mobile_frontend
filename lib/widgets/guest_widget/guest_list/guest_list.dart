

import 'package:apartflow_mobile_app/models/guest.dart';
import 'package:flutter/material.dart';


import 'guest_item.dart';

class GuestsList extends StatelessWidget {
const GuestsList({super.key, required this.guests});

final List<Guest> guests;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: guests.length,
      //itemBuilder:(ctx, index) =>MaintenanceItem(maintenances[index]),);
      itemBuilder:(ctx, index) =>GuestItem(guests[index]),);
  }
}