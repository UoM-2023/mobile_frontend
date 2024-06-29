// import 'package:flutter/material.dart';
// import 'package:apartflow_mobile_app/models/reservation.dart';

// import '../../service_item.dart';

// class ReservationItem extends StatelessWidget {
//   const ReservationItem(this.reservation, {Key? key}) : super(key: key);

//   final Reservation reservation;

//   @override
//   Widget build(BuildContext context) {
//     return ServiceItem(
//       key: key,
//       title: reservation.amenityName
//           .toString()
//           .split('.')
//           .last
//           .replaceAll('_', ' '),
//       description: reservation.formattedStartDate,
//       formattedDateOrStartDate: reservation.formattedEndDate!,
//       additionalText:
//           '${reservation.needForHours} ${reservation.time.hour}:${reservation.time.minute}',
//       formattedEndDate: '',
//     );
//   }
// }
