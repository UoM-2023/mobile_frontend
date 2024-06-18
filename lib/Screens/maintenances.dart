import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/maintenance.dart';
import 'package:apartflow_mobile_app/widgets/maintenance_widgets/new_maintenance.dart';


import '../widgets/bottomnavigationbar.dart';
import '../widgets/maintenance_widgets/maintenances_list/maintenance_item.dart';

class Maintenances extends StatefulWidget {
  
  const Maintenances({super.key});
  @override
  State<Maintenances> createState() => _MaintenancesState();
}


class _MaintenancesState extends State<Maintenances> {
  int _selectedIndex = 0;
  List<Maintenance> _registeredMaintenances = [];
  bool _isLoading = true;
  String? _errorMessage;

   @override
  void initState() {
    super.initState();
    _fetchMaintenanceData();
  }

  Future<void> _fetchMaintenanceData() async {
    String unitID = 'A-101';
    try {
      List<Maintenance> maintenances = await Maintenance.fetchMaintenanceList(unitID);
      print('Fetched maintenances: $maintenances');
      setState(() {
        _registeredMaintenances = maintenances;
        _isLoading = false;
      });
    } catch (error) {
      print('Error in _fetchMaintenanceData: $error');
      setState(() {
        _errorMessage = 'Failed to load data: $error';
        _isLoading = false;
      });
    }
  }

  Future<void> _openAddMaintenanceOverlay() async {
    // Await the result from the NewMaintenance screen
    final result = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewMaintenance(),
    );

  // If the result is true, refresh the list of maintenance requests
    if (result == true) {
      _fetchMaintenanceData();
    }
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
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                  onPressed: _openAddMaintenanceOverlay,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ]),
        body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _registeredMaintenances.isEmpty
                  ? const Center(child: Text('You have no maintenance requests yet'))
              : ListView.builder(
                  itemCount: _registeredMaintenances.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = _registeredMaintenances.length - 1 - index;
                    return MaintenanceItem(_registeredMaintenances[reversedIndex]);
                  },
                ),
        bottomNavigationBar: NavigationMenu(selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });} ),
        );
  }
}
