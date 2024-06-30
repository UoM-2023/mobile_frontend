import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for JSON decoding
import 'package:apartflow_mobile_app/Screens/barrell.dart';
import 'package:apartflow_mobile_app/Screens/payment_history.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/widgets/bills/payable.dart';
import 'package:apartflow_mobile_app/widgets/bills/total_payable.dart';
import '../util/enums.dart';
import '../util/strings.dart';
import '../widgets/bottomnavigationbar.dart';
import '../widgets/buttons/af_button.dart'; 
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/bills.dart';
import '../widgets/bottomnavigationbar.dart';
import 'payhere_service.dart';
import '../models/userDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  int _selectedIndex = 0;
  Finance? _financeData;
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
      _fetchFinanceData(user.unitId);
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

  Future<void> _fetchFinanceData(String unitID) async {
    print('User ID2: $unitID');
    try {
      print('User ID: $unitID');
      Finance finance = await Finance.fetchFinanceData(unitID);
      print('Fetched finance data: $finance');
      setState(() {
        _financeData = finance;
        _isLoading = false;
      });
    } catch (error) {
      print('Error in _fetchFinanceData: $error');
      setState(() {
        _errorMessage = 'Failed to load data: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 114, 70),
      appBar: AppBar(
        title: const Text(
          "Finance",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _financeData == null || _user == null
                  ? const Center(child: Text('No finance data available'))
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PaymentCard(
                              title: 'Management Fund',
                              amount: 'Rs. ${_financeData!.managementBalance}',
                              onPressed: () {
                                PayHereService.initiatePayment(_user!,'Management', _financeData!.managementBalance);
                              },
                            ),
                            PaymentCard(
                              title: 'Sinking Fund',
                              amount: 'Rs. ${_financeData!.sinkingBalance}',
                              onPressed: () {
                                PayHereService.initiatePayment(_user!,'Sinking', _financeData!.sinkingBalance);
                              },
                            ),
                            PaymentCard(
                              title: 'Utility Fund',
                              amount: 'Rs. ${_financeData!.utilityBalance}',
                              onPressed: () {
                                PayHereService.initiatePayment(_user!,'Utility', _financeData!.utilityBalance);
                              },
                            ),
                            TotalPaymentCard(
                              amount: 'Rs. ${_financeData!.managementBalance + _financeData!.sinkingBalance + _financeData!.utilityBalance}',
                              onPressed: () {
                                PayHereService.initiatePayment(_user!,'All', _financeData!.managementBalance + _financeData!.sinkingBalance + _financeData!.utilityBalance);
                              },
                            ),
                          ],
                        ),
                      ),
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
