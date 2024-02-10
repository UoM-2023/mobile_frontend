import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/widgets/maintenance_widgets/maintenances_list/maintenance_list.dart';
import 'package:apartflow_mobile_app/models/maintenance.dart';
import 'package:apartflow_mobile_app/widgets/maintenance_widgets/new_maintenance.dart';

class Maintenances extends StatefulWidget {
  const Maintenances({super.key});
  @override
  State<Maintenances> createState() {
    return _MaintenancesState();
  }
}

//dummy data
class _MaintenancesState extends State<Maintenances> {
  final List<Maintenance> _registeredMaintenances = [
    Maintenance(
      description: 'Dimming Lights',
      date: DateTime.now(),
      category: Category.Electrical,
    ),
    Maintenance(
      description: 'Gurgling Sound from Drain',
      date: DateTime.now(),
      category: Category.Plumbing,
    )
  ];

//open the form after pressing plus button
  _openAddMaintenanceOverlay() {
//build in function for forms
    showModalBottomSheet(
      //to make sure that the keyboard doesn't overlap over input fields
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewMaintenance(onAddMaintenance: _addMaintenance),
    );
  }

  void _addMaintenance(Maintenance maintenance) {
    //add a new item to the list
    setState(() {
      _registeredMaintenances.add(maintenance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        appBar: AppBar(
            title: const Text(
              "Maintenance",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 234, 114, 70),
            actions: [
              IconButton(
                  color: Colors.white,
                  onPressed: _openAddMaintenanceOverlay,
                  icon: const Icon(Icons.add)),
            ]),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),

              const Row(children: [
                SizedBox(width: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  //new maintenance list
                  child:
                      MaintenancesList(maintenances: _registeredMaintenances)),

              const Text('Earlier'),
              //earlier maintenance list
              const Expanded(child: Text('Earlier maintenance requests')),
            ],
          ),
        ));
  }
}
