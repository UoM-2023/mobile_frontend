//import 'package:apartflow_mobile_app/Screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/Screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.latoTextTheme(),
  useMaterial3: true,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
