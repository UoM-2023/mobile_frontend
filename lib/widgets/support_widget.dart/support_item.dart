import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/support.dart';
import 'package:intl/intl.dart';
import '../service_item.dart';



class SupportItem extends StatelessWidget {
  const SupportItem(this.support, {Key? key}) : super(key: key);

  final Support support;

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(support.date);
     final formattedDate = DateFormat.yMd().format(dateTime);
    return ServiceItem(
      key: key,
      title: support.title.replaceAll('_', ' '),
      description: support.description,
      formattedDateOrStartDate: formattedDate, 
      additionalText: support.status, 
      formattedEndDate: '',
    );
  }
}