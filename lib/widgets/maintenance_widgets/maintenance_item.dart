import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/maintenance.dart';
import 'package:intl/intl.dart';
import '../service_item.dart';



class MaintenanceItem extends StatelessWidget {
  const MaintenanceItem(this.maintenance, {Key? key}) : super(key: key);

  final Maintenance maintenance;

  @override
  Widget build(BuildContext context) {
     final dateTime = DateTime.parse(maintenance.date);
     final formattedDate = DateFormat.yMd().format(dateTime);
    return ServiceItem(
      key: key,
      title: maintenance.category.replaceAll('_', ' '),
      description: maintenance.description,
      formattedDateOrStartDate: formattedDate, 
      additionalText: maintenance.status, 
      formattedEndDate: '',
    );
  }
}