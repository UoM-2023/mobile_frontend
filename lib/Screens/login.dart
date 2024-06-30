import 'package:apartflow_mobile_app/auth_service.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:apartflow_mobile_app/widgets/buttons/barrell.dart';
import 'package:apartflow_mobile_app/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apartflow_mobile_app/Screens/barrell.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers
  final userIDController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService(); // Initialize AuthService

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void> _submitForm() async {
  if (_formKey.currentState!.validate()) {
    String userID = userIDController.text.trim();
    String password = passwordController.text.trim();

    try {
      print('Logging in with UserID: $userID');
      await _authService.login(userID, password);
      print('Login successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } catch (e) {
      print('Error during login: $e');
      String errorMessage = 'Login failed. Please try again.';

      if (e.toString().contains('Invalid username')) {
        errorMessage = 'Invalid username. Please try again.';
      } else if (e.toString().contains('Invalid password')) {
        errorMessage = 'Invalid password. Please try again.';
      }

      if (context != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Error'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}








  void contactUs() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const SizedBox(
          width: 100, 
          height: 50, 
          child: Row(
            children: [
              Icon(Icons.call),
              SizedBox(width: 20),
              Text('011 XXXXXXX'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Constants.primaryBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 70),
              // login text
              Text(
                Strings.login,
                style: GoogleFonts.lato(
                  color: Constants.secondaryTextColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 70,
                child: LogInTextField(
                  controller: userIDController,
                  hintText: 'Username',
                  obscureText: false,
                  iconData: Icons.person,
                  validator: _validateUsername,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 70,
                child: LogInTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  iconData: Icons.lock,
                  validator: _validatePassword,
                ),
              ),
              const SizedBox(height: 25),
              AFButton(
                type: ButtonType.primary,
                shadow: true,
                onPressed: _submitForm,
                text: Strings.login,
                paddingX: (MediaQuery.of(context).size.width / 3),
              ),
              
              const SizedBox(height: 25),
              const LineWidget(),
              const SizedBox(height: 80),
              Text(
                'Need any help?',
                style: GoogleFonts.lato(
                  color: Constants.shadowColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              AFButton(
                type: ButtonType.faded,
                shadow: true,
                onPressed: contactUs,
                text: Strings.contactUs,
                icon: Icons.call,
                paddingX: (MediaQuery.of(context).size.width / 12),
              ),
              const SizedBox(height: 39),
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Expanded(
      child: SizedBox(
        height: 10,
        child: ClipPath(
          clipper: MyClipper(), // Custom clipper for the shape
          child: Container(
            color: Constants.primaryColor,
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.8,
      size.width,
      0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LineWidget extends StatelessWidget {
  const LineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      color: Constants.shadowColor, // Change the color of the line
      margin: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
