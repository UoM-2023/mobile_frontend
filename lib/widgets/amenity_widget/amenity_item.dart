import 'package:apartflow_mobile_app/models/amenity.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../service_item.dart';

class AmenityItem extends StatelessWidget {
  const AmenityItem(this.amenity, {Key? key}) : super(key: key);

  final Amenity amenity;

 @override
  Widget build(BuildContext context) {
     
    return ServiceItem(
      key: key,
      title: amenity.name.replaceAll('_', ' '),
      description: amenity.amount,
      formattedDateOrStartDate: '', 
      additionalText: amenity.chargePer, 
      formattedEndDate: '',
    );
  }
}