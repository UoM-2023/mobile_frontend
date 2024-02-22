import 'package:apartflow_mobile_app/models/guest.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/maintenance.dart';

import '../../service_item.dart';

class GuestItem extends StatelessWidget {
  const GuestItem(this.guest, {Key? key}) : super(key: key);

  final Guest guest;

  @override
  Widget build(BuildContext context) {
    return ServiceItem(
      key: key,
      title: guest.name,
      description: guest.vehicle_NO,
      formattedDateOrStartDate: guest.formattedDate, 
      additionalText: guest.nic, 
      formattedEndDate: '',
    );
  }
}