import 'package:apartflow_mobile_app/global.dart';
import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/maintenance.dart';
import 'package:intl/intl.dart';
import '../service_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MaintenanceItem extends StatefulWidget {
  const MaintenanceItem(this.maintenance, {Key? key}) : super(key: key);

  final Maintenance maintenance;

  @override
  State<MaintenanceItem> createState() => _MaintenanceItemState();
}

class _MaintenanceItemState extends State<MaintenanceItem> {
  User? _user;

  Future<void> _cancelMaintenanceRequest(BuildContext context) async {
    final url = '${baseurl}/maintenance/Update_cancelled_Req/${widget.maintenance.id}';
    
    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode({
          'Unit_id': _user!.unitId, // Ensure unitId is part of Maintenance model
          'MType': widget.maintenance.category,
          'Mnt_Status': 'Cancelled',
          'M_Description': widget.maintenance.description,
          
        }),

        headers: {'Content-Type': 'application/json'},
      );

 

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Maintenance request cancelled successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to cancel maintenance request')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  Future<void> _fetchUserDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId != null) {
        print('Fetching details for userID: $userId');
        User user = await User.fetchUserDetails(userId); // Fetch user details using the user ID
        setState(() {
          _user = user;
        });
      } else {
        print('User ID not found.');
      }
    } catch (error) {
      print('Error fetching user details: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(widget.maintenance.date);
    final formattedDate = DateFormat.yMd().format(dateTime);

    return Dismissible(
      key: Key(widget.maintenance.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _cancelMaintenanceRequest(context);
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.cancel,
          color: Colors.white,
        ),
      ),
      child: ServiceItem(
        title: widget.maintenance.category.replaceAll('_', ' '),
        description: widget.maintenance.description,
        formattedDateOrStartDate: formattedDate,
        additionalText: widget.maintenance.status,
        formattedEndDate: '',
      ),
    );
  }
}
