import 'package:apartflow_mobile_app/Screens/barrell.dart';
import 'package:flutter/material.dart';
import '../widgets/bills/previous_payments.dart';
import '../widgets/bottomnavigationbar.dart'; // Import your user profile widget

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 2;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Bills()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            PreviousPaymentCard(
              amount: 'Rs.2400.00',
              title: "Management Fund",
              date: DateTime.now(),
            ),
            PreviousPaymentCard(
              amount: 'Rs.2400.00',
              title: "Sinking Fund",
              date: DateTime.now(),
            ),
            PreviousPaymentCard(
              amount: 'Rs.2400.00',
              title: "Utility Fund",
              date: DateTime.now(),
            ),
            PreviousPaymentCard(
              amount: 'Rs.2400.00',
              title: "Management Fund",
              date: DateTime.now(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationMenu(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          // Implement the onItemTapped action here
        },
      ),
    );
  }
}
