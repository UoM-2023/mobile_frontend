import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    Key? key,
    required this.title,
    required this.description,
    required this.formattedDateOrStartDate,
    required this.formattedEndDate,
    required this.additionalText,
  }) : super(key: key);

  final String title;
  final String description;
  final String formattedDateOrStartDate;
  final String? formattedEndDate;
  final String? additionalText;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
          left: Constants.multiplier * 1.5,
          right: Constants.multiplier * 1.5,
          top: Constants.multiplier * 1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(15), // rounded corners, same as Card shape
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title Row
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Description and Date Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(description),
                  Text(formattedDateOrStartDate),
                  if (formattedEndDate != null) Text(formattedEndDate!),
                  if (additionalText != null) Text(additionalText!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
