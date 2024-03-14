import 'package:apartflow_mobile_app/Screens/barrell.dart';
import 'package:apartflow_mobile_app/Screens/payment_history.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/widgets/bills/payable.dart';
import 'package:apartflow_mobile_app/widgets/bills/total_payable.dart';
import '../util/enums.dart';
import '../util/strings.dart';
import '../widgets/bottomnavigationbar.dart';
import '../widgets/buttons/af_button.dart'; // Import your user profile widget

class Bills extends StatefulWidget {
  const Bills({Key? key}) : super(key: key);

  @override
  _BillsState createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  int _selectedIndex = 1; // Assuming this is the index for the search page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //centerTitle: true,
        title: const Text(
          "Payments",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DashboardScreen()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PaymentCard(
                title: 'Management Fund',
                amount: 'Rs. 2400.00',
                onPressed: () {
                  //payment logic
                },
              ),
              PaymentCard(
                title: 'Sinking Fund',
                amount: 'Rs. 2400.00',
                onPressed: () {
                  //payment logic
                },
              ),
              PaymentCard(
                title: 'Utility Fund',
                amount: 'Rs. 2400.00',
                onPressed: () {
                  //payment logic
                },
              ),
              TotalPaymentCard(
                amount: "7200.00",
                onPressed: () {},
              ),
              const SizedBox(
                height: 50,
              ),
              AFButton(
                  type: ButtonType.primary,
                  shadow: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentHistory()),
                    );
                  },
                  text: Strings.viewHistory,
                  paddingX: (MediaQuery.of(context).size.width / 10)),
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
