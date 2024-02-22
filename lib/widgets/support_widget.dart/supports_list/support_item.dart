import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/support.dart';

import '../../service_item.dart';



class SupportItem extends StatelessWidget {
  const SupportItem(this.support, {Key? key}) : super(key: key);

  final Support support;

  @override
  Widget build(BuildContext context) {
    return ServiceItem(
      key: key,
      title: support.Supportcategory.toString().split('.').last.replaceAll('_', ' '),
      description: support.description,
      formattedDateOrStartDate: support.formattedDate, 
      additionalText: '', 
      formattedEndDate: '',
    );
  }
}