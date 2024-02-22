import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/maintenance.dart';

import '../../service_item.dart';



class MaintenanceItem extends StatelessWidget {
  const MaintenanceItem(this.maintenance, {Key? key}) : super(key: key);

  final Maintenance maintenance;

  @override
  Widget build(BuildContext context) {
    return ServiceItem(
      key: key,
      title: maintenance.category.toString().split('.').last.replaceAll('_', ' '),
      description: maintenance.description,
      formattedDateOrStartDate: maintenance.formattedDate, 
      additionalText: '', 
      formattedEndDate: '',
    );
  }
}