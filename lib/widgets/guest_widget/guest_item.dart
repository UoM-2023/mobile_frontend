import 'package:apartflow_mobile_app/models/guest.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../service_item.dart';

class GuestItem extends StatelessWidget {
  const GuestItem(this.guest, {Key? key}) : super(key: key);

  final Guest guest;

 @override
  Widget build(BuildContext context) {
     
     final formattedDate = DateFormat.yMd().format(guest.date);
    return ServiceItem(
      key: key,
      title: guest.name.replaceAll('_', ' '),
      description: guest.nic,
      formattedDateOrStartDate: formattedDate, 
      additionalText: guest.vehicle_NO, 
      formattedEndDate: '',
    );
  }
}