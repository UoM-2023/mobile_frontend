import 'package:apartflow_mobile_app/Screens/barrell.dart';
import 'package:apartflow_mobile_app/components/userProfile.dart';
import 'package:apartflow_mobile_app/models/userDetails.dart';
import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:apartflow_mobile_app/widgets/buttons/barrell.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  User? _user;

 @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

    Future<void> _fetchProfileData() async {
    String userId = 'AP0001R';
    try {
      User user = await User.fetchUserDetails(userId);
      setState(() {
        _user = user;
      });
     
    } catch (error) {
      print('Error in _fetchUserDetails: $error');
    }
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
                              onPressed: () {},
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Reservations(),
                              //   ),
                              // );
                            },
                            fontSize: null,
                          ),
                          const SizedBox(height: 10),
                          DashboardButton(
                            title: 'Support',
                            icon: Icons.thumb_up,
                            iconColor: Colors.red,
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Supports(),
                              //   ),
                              // );
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
                      color: Colors.black
                          .withOpacity(0.2), 
                      spreadRadius: 1, // Spread radius
                      blurRadius: 2, // Blur radius
                      offset: const Offset(0, 2), // Shadow offset
                    ),
                  ],
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  border: Border.all(
                    color: Colors.black
                        .withOpacity(0.5), 
                    width: 0.1, 
                  ),
                ),

                child: Row(
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
          Icons.person,  // You can choose a different icon if needed
          size: 50,
        ),
      ),
    ),
    const SizedBox(
      width: 5,
    ),
    SizedBox(
      width: Constants.multiplier * 23,
      child: Container(
        
        child: Userprofile(
          name: _user!.nameWithInitials,
          phoneNumber: _user!.mobileNo,
          houseNumber: _user!.unitId,
          residentID: _user!.residentId,
        ),
      ),
    ),
  ],
),

                //
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