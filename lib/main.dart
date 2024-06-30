import 'package:flutter/material.dart';
import './Screens/barrell.dart'; // Import your screens here
import 'package:google_fonts/google_fonts.dart';
import 'package:apartflow_mobile_app/Screens/login.dart'; // Make sure to import your LoginPage
import 'package:apartflow_mobile_app/Screens/dashboard.dart'; // Import your DashboardScreen

final theme = ThemeData(
  textTheme: GoogleFonts.latoTextTheme(),
  useMaterial3: true,
);

void main() {
  runApp(const ApartFlow());
}

class ApartFlow extends StatelessWidget {
  const ApartFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', 
      routes: {
        '/login': (context) => const LoginPage(), 
        '/dashboard': (context) => const DashboardScreen(), 
      },
    );
  }
}
