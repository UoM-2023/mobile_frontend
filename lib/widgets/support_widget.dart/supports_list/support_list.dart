import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/support.dart';
import 'package:apartflow_mobile_app/widgets/support_widget.dart/supports_list/support_item.dart';

class SupportsList extends StatelessWidget {
const SupportsList({super.key, required this.supports});

final List<Support> supports;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: supports.length,
      //itemBuilder:(ctx, index) =>MaintenanceItem(maintenances[index]),);
      itemBuilder:(ctx, index) =>SupportItem(supports[index]),);
  }
}