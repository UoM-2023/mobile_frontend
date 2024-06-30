import 'package:apartflow_mobile_app/global.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:apartflow_mobile_app/models/maintenance.dart';
import 'package:apartflow_mobile_app/widgets/maintenance_widgets/new_maintenance.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottomnavigationbar.dart';
import '../widgets/maintenance_widgets/maintenance_item.dart';
import 'dart:convert';

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
  User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId != null) {
        User user = await User.fetchUserDetails(userId);
        setState(() {
          _user = user;
        });
        _fetchMaintenanceData(user.unitId);
      } else {
        print('User ID not found.');
        setState(() {
          _errorMessage = 'User ID not found.';
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error in _fetchUserDetails: $error');
      setState(() {
        _errorMessage = 'Failed to load user details: $error';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchMaintenanceData(String unitID) async {
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
    final result = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewMaintenance(),
    );

    if (result == true) {
      _fetchMaintenanceData(_user!.unitId);
    }
  }

  Future<void> _updateMaintenanceStatus(String id, String unitId, String mType, String mDescription) async {
    final url = '${baseurl}/maintenance/Update_cancelled_Req/$id';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'Unit_id': unitId,
          'MType': mType,
          'M_Description': mDescription,
          'Mnt_Status': 'Cancelled',
        }),
      );

      if (response.statusCode == 200) {
        print('Maintenance request updated successfully.');
        _fetchMaintenanceData(_user!.unitId);
      } else {
        print('Failed to update maintenance request. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating maintenance request: $error');
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
            ),
          ),
        ],
      ),
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
                        final maintenance = _registeredMaintenances[reversedIndex];
                        return Dismissible(
                          key: Key(maintenance.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _updateMaintenanceStatus(maintenance.id, _user!.unitId, maintenance.category, maintenance.description);
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: MaintenanceItem(maintenance),
                        );
                      },
                    ),
      bottomNavigationBar: NavigationMenu(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
