import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/reservation.dart';

import 'package:intl/intl.dart';
import '../service_item.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem(this.reservation, {Key? key}) : super(key: key);

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final formattedStartDate = DateFormat.yMd().format(reservation.startDate);
    final formattedEndDate = DateFormat.yMd().format(reservation.endDate);
    return ServiceItem(
      key: key,
      title: reservation.amenityName
          .replaceAll('_', ' '),
      
      formattedDateOrStartDate: formattedStartDate,
      additionalText:reservation.status,
      formattedEndDate: formattedEndDate,
      description: '',
    );
  }
}
