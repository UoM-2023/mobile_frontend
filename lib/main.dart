//import 'package:apartflow_mobile_app/Screens/dashboard.dart';
import 'package:flutter/material.dart';
import './Screens/barrell.dart';
import 'package:google_fonts/google_fonts.dart';

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
      // home: LoginPage(),
      home: LoginPage(),
    );
  }
}
