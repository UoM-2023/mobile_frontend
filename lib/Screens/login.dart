// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:apartflow_mobile_app/widgets/buttons/barrell.dart';
import 'package:apartflow_mobile_app/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:apartflow_mobile_app/Screens/barrell.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

//text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

//sign user in
  // ignore: non_constant_identifier_names
  void LogUserIn() {}
  void resetPassword() {}

  void contactUs() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 70),
              //login text

              Text(
                'Log in',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),

              //username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
                iconData: Icons.person,
                //iconImagePath: 'assets/User_light.png',
              ),
              SizedBox(height: 20),
              //password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                iconData: Icons.lock,
              ),
              SizedBox(height: 25),

              AFButton(
                  type: ButtonType.primary,
                  shadow: true,
                  onPressed: () {
                    // After successful login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()),
                    );
                  },
                  text: Strings.login,
                  paddingX: (MediaQuery.of(context).size.width / 3)),

              SizedBox(height: 12),
              //reset password
              ResetPasswordButton(
                onPressed: resetPassword,
              ),

              SizedBox(height: 5),
              LineWidget(),
              SizedBox(height: 80),
              //contact us
              Text(
                'Need any help?',
                style: GoogleFonts.lato(
                  color: Color.fromARGB(120, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),

              AFButton(
                  type: ButtonType.faded,
                  shadow: true,
                  onPressed: contactUs,
                  text: Strings.contactUs,
                  icon: Icons.call,
                  paddingX: (MediaQuery.of(context).size.width / 12)),

              SizedBox(
                height: 39,
              ),
              //or continue with
              _buildBottom(),
              //not a member?register now
            ]),
      ),
    );
  }
}

Widget _buildBottom() {
  return Expanded(
    child: SizedBox(
      height: 10,
      child: ClipPath(
        clipper: MyClipper(), // Custom clipper for the shape
        child: Container(
          color: const Color.fromARGB(242, 230, 95, 43),
        ),
      ),
    ),
  );
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      color: Color(0x5E000000), // Change the color of the line
      margin: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
