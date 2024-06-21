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
import '../widgets/buttons/af_button.dart'; // Import your user profile widget

// class Bills extends StatefulWidget {
//   const Bills({Key? key}) : super(key: key);

//   @override
//   _BillsState createState() => _BillsState();
// }

// class _BillsState extends State<Bills> {
//   int _selectedIndex = 1; // Assuming this is the index for the search page
//   Future<Map<String, dynamic>>? _balancesFuture;

//   @override
//   void initState() {
//     super.initState();
//     _balancesFuture = fetchBalances();
//   }

//   Future<Map<String, dynamic>> fetchBalances(String _unitID) async {
//     final response = await http.get(Uri.parse('http://192.168.56.1:3001/userCharge/1')); 

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       return data['result']; 
//     } else {
//       throw Exception('Failed to load balances');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         //centerTitle: true,
//         title: const Text(
//           "Payments",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color.fromARGB(255, 234, 114, 70),
//         iconTheme: const IconThemeData(color: Colors.white),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => const DashboardScreen()));
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _balancesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final balances = snapshot.data!;
//             final managementBalance = balances['management_balance'] ?? 0;
//             final sinkingBalance = balances['sinking_balance'] ?? 0;
//             final utilityBalance = balances['utility_balance'] ?? 0;
//             final totalBalance = managementBalance + sinkingBalance + utilityBalance;
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 20, bottom: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               PaymentCard(
//                 title: 'Management Fund',
//                 amount: 'Rs. 2400.00',
//                 onPressed: () {
//                   //payment logic
//                 },
//               ),
//               PaymentCard(
//                 title: 'Sinking Fund',
//                 amount: 'Rs. 2400.00',
//                 onPressed: () {
//                   //payment logic
//                 },
//               ),
//               PaymentCard(
//                 title: 'Utility Fund',
//                 amount: 'Rs. 2400.00',
//                 onPressed: () {
//                   //payment logic
//                 },
//               ),
//               TotalPaymentCard(
//                 amount: "7200.00",
//                 onPressed: () {},
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               AFButton(
//                   type: ButtonType.primary,
//                   shadow: true,
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const PaymentHistory()),
//                     );
//                   },
//                   text: Strings.viewHistory,
//                   paddingX: (MediaQuery.of(context).size.width / 10)),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: NavigationMenu(
//         selectedIndex: _selectedIndex,
//         onItemTapped: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert'; // Import for JSON decoding

// import 'package:apartflow_mobile_app/Screens/dashboard_screen.dart';
// import 'package:apartflow_mobile_app/Screens/payment_history.dart';
// import 'package:apartflow_mobile_app/widgets/bills/payable.dart';
// import 'package:apartflow_mobile_app/widgets/bills/total_payable.dart';
// import '../util/enums.dart';
// import '../util/strings.dart';
// import '../widgets/bottomnavigationbar.dart';
// import '../widgets/buttons/af_button.dart';


import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/bills.dart';
// import 'package:apartflow_mobile_app/widgets/finance_widgets/payment_card.dart';
// import 'package:apartflow_mobile_app/widgets/finance_widgets/total_payment_card.dart';
import '../widgets/bottomnavigationbar.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchFinanceData();
  }

  Future<void> _fetchFinanceData() async {
    String unitID = 'A123'; // Replace with actual unit ID
    try {
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
              : _financeData == null
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
                                //payment logic
                              },
                            ),
                            PaymentCard(
                              title: 'Sinking Fund',
                              amount: 'Rs. ${_financeData!.sinkingBalance}',
                              onPressed: () {
                                //payment logic
                              },
                            ),
                            PaymentCard(
                              title: 'Utility Fund',
                              amount: 'Rs. ${_financeData!.utilityBalance}',
                              onPressed: () {
                                //payment logic
                              },
                            ),
                            TotalPaymentCard(
                              amount: 'Rs. ${_financeData!.managementBalance + _financeData!.sinkingBalance + _financeData!.utilityBalance}',
                              onPressed: () {},
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
