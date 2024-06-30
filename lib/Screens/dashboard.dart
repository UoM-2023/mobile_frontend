import 'package:apartflow_mobile_app/Screens/Reserve_amenities.dart';
import 'package:apartflow_mobile_app/Screens/barrell.dart';
import 'package:apartflow_mobile_app/auth_service.dart';
import 'package:apartflow_mobile_app/components/userProfile.dart';
import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:apartflow_mobile_app/widgets/buttons/barrell.dart';
import 'package:apartflow_mobile_app/Screens/supports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  User? _user;
  final AuthService _authService = AuthService();
 bool _isLoading = true;
  String? _errorMessage;

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
          _isLoading = false;
        });
      } else {
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

  Future<void> _logout() async {
    try {
      await _authService.logout();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error during logout: $e');
      // Optionally, show an error message to the user
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: Text('Logout'),
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                //top container
                Container(
                  decoration: const BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                  height: 250,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'ApartFlow',
                            style: GoogleFonts.lato(
                              color: Constants.shadedTextColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          
                          IconButton(
                              color: Constants.shadedTextColor,
                              onPressed: _showLogoutDialog,
                              icon: const Icon(Icons.logout))
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Constants.primaryBackgroundColor,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          DashboardButton(
                            title: 'Maintenance',
                            icon: Icons.build,
                            iconColor: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Maintenances(),
                                ),
                              );
                            },
                            fontSize: null,
                          ),
                          const SizedBox(height: 10),
                         DashboardButton(
                            title: 'Guests',
                            icon: Icons.person,
                            iconColor: Colors.green,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Guests(),
                                ),
                              );
                            },
                            fontSize: null,
                          ),
                          const SizedBox(height: 10),
                          DashboardButton(
                            title: 'Reservations',
                            icon: Icons.calendar_today,
                            iconColor: Colors.yellow,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  ReserveAmenities(),
                                ),
                              );
                            },
                            fontSize: null,
                          ),
                          const SizedBox(height: 10),
                          DashboardButton(
                            title: 'Support',
                            icon: Icons.thumb_up,
                            iconColor: Colors.red,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Supports(),
                                ),
                              );
                            },
                            fontSize: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Constants.multiplier * 17,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: Constants.multiplier * 20,
                width: Constants.multiplier * 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1, // Spread radius
                      blurRadius: 2, // Blur radius
                      offset: const Offset(0, 2), // Shadow offset
                    ),
                  ],
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.5),
                    width: 0.1,
                  ),
                ),
                child: _user != null
                    ? Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 0,
                              left: 20,
                              bottom: 20,
                              right: 20,
                            ),
                            height: Constants.multiplier * 10,
                            width: Constants.multiplier * 10,
                            child: const CircleAvatar(
                              radius: 50,
                              child: Icon(
                                Icons.person, // You can choose a different icon if needed
                                size: 50,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: Constants.multiplier * 23,
                            child: Userprofile(
                              name: _user!.nameWithInitials,
                              phoneNumber: _user!.mobileNo,
                              houseNumber: _user!.unitId,
                              residentID: _user!.residentId,
                            ),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()), // Loading indicator while user data is being fetched
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigationMenu(
              selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}