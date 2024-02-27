import 'package:apartflow_mobile_app/models/guest.dart';
import 'package:apartflow_mobile_app/widgets/guest_widget/guest_list/guest_list.dart';
import 'package:apartflow_mobile_app/widgets/guest_widget/new_guest.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';

class Guests extends StatefulWidget {
  const Guests({super.key});
  @override
  State<Guests> createState() {
    return _GuestsState();
  }
}

//dummy data
class _GuestsState extends State<Guests> {
   int _selectedIndex = 0;
  final List<Guest> _registeredGuests = [
    Guest(
        name: 'Noyel Fernando',
        vehicle_NO: 'NH7645',
        date: DateTime.now(),
        nic: '8789448v'),
    Guest(
        name: 'Nimal Perera',
        vehicle_NO: 'NH7645',
        date: DateTime.now(),
        nic: '8789448v')
  ];

//open the form after pressing plus button
  _openAddMaintenanceOverlay() {
//build in function for forms
    showModalBottomSheet(
      //to make sure that the keyboard doesn't overlap over input fields
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewGuest(
        onAddGuest: (guest) {
          // Add a new item to the list
          setState(() {
            _registeredGuests.add(guest);
          });
        },
      ),
    );
  }

  void _addGuest(Guest guest) {
    //add a new item to the list
    setState(() {
      _registeredGuests.add(guest);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        appBar: AppBar(
            title: const Text(
              "Guests",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 234, 114, 70),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                  onPressed: _openAddMaintenanceOverlay,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ]),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),

              const Row(children: [
                SizedBox(width: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 20,
              ),
              Expanded(

                  //new maintenance list
                  child: GuestsList(guests: _registeredGuests)),

              const Text('Earlier'),
              //earlier maintenance list
              const Expanded(child: Text('Earlier guests requests')),
            ],
          ),
        ),
        bottomNavigationBar: NavigationMenu(selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });} ),
        );

        
  }
}
