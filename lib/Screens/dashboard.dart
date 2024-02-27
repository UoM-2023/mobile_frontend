import 'package:apartflow_mobile_app/Screens/barrell.dart';
import 'package:apartflow_mobile_app/util/constants.dart';
import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apartflow_mobile_app/widgets/components/user_profile.dart';
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:apartflow_mobile_app/widgets/buttons/barrell.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 234, 114, 70),
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
                              color: const Color.fromARGB(201, 255, 255, 255),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          IconButton(
                              color: const Color.fromARGB(201, 255, 255, 255),
                              onPressed: () {},
                              icon: const Icon(Icons.notifications)),
                          IconButton(
                              color: const Color.fromARGB(201, 255, 255, 255),
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
                      color: Colors.white,
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
                            icon: Icons.people,
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
                                  builder: (context) => const Reservations(),
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
                      color: Colors.black
                          .withOpacity(0.2), // Transparent black color
                      spreadRadius: 1, // Spread radius
                      blurRadius: 2, // Blur radius
                      offset: const Offset(0, 2), // Shadow offset
                    ),
                  ],
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  border: Border.all(
                    color: Colors.black
                        .withOpacity(0.5), // Transparent black color
                    width: 0.1, // Border width
                  ),
                ),

                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      //color: Colors.red,
                      child: const CircleAvatar(
                        radius: 50, // Adjust the size as needed
                        backgroundImage: AssetImage('assets/images/person.jpg'),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const SizedBox(
                      width: Constants.multiplier * 21,
                      //color: Colors.green,
                      child: UserProfileWidget(
                        name: 'John Doe',
                        phoneNumber: '123-456-7890',
                        houseNumber: '1234',
                        blockNumber: 'Block A',
                        buildingName: 'ABC Towers',
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
