import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/reservation.dart';

class ReservationItem extends StatelessWidget {
 const ReservationItem(this.reservation, {super.key});

final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Row
            Row(
              children: [
                Text(
                  reservation.amenityName
                      .toString()
                      .split('.')
                      .last
                      .replaceAll('_', ' '),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
           const  SizedBox(height: 4),
            // Description and Date Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reservation.formattedStartDate),
                Text(reservation.formattedEndDate),
                Text('${reservation.needForHours}'),
                Text('${reservation.time.hour}:${reservation.time.minute}'),

              ],
            ),
          ],
        ),
      ),
    );
  }
}