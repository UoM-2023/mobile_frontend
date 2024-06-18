// ignore_for_file: library_private_types_in_public_api

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

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;

      // Implement your login logic here
      print('Logging in with username: $username, password: $password');
    }
  }

  void logUserIn() {}

  void resetPassword() {}

  void contactUs() {}

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
              //login text
              Text(
                Strings.login,
                style: GoogleFonts.lato(
                  color: Constants.secondaryTextColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              LogInTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
                iconData: Icons.person,
                validator: _validateUsername,
              ),
              const SizedBox(height: 20),
              //password textfield
              LogInTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                iconData: Icons.lock,
                validator: _validatePassword,
              ),
              const SizedBox(height: 25),

              AFButton(
                type: ButtonType.primary,
                shadow: true,
                onPressed: () {
                  _submitForm();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardScreen()),
                  );
                },
                text: Strings.login,
                paddingX: (MediaQuery.of(context).size.width / 3),
              ),

              const SizedBox(height: 12),
              //reset password
              ResetPasswordButton(
                onPressed: resetPassword,
              ),

              const SizedBox(height: 5),
              const LineWidget(),
              const SizedBox(height: 80),
              //contact us
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

              const SizedBox(
                height: 39,
              ),

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
