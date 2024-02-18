import 'package:apartflow_mobile_app/widgets/reservations_widget.dart/new_reservation.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/models/reservation.dart';
import 'package:apartflow_mobile_app/widgets/reservations_widget.dart/reservations_list/reservation_list.dart';
import 'package:apartflow_mobile_app/models/enum.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  // Using dummy data
  final List<Reservation> _registeredReservations = [
    Reservation(
      amenityName: AmenityType.EventSpace,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(hours: 2)),
      needForHours: '2',
      time: TimeOfDay.now(),
    ),
    Reservation(
      amenityName: AmenityType.FitnessCenter,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(hours: 2)),
      needForHours: '2',
      time: TimeOfDay.now(),
    )
  ];

  void _openAddReservationsOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewReservation(
        onAddReservation: (reservation) {
          // Add a new item to the list
          setState(() {
            _registeredReservations.add(reservation);
          });
        },
      ),
    );
  }

  void _addReservation(Reservation reservation) {
    //add a new item to the list
    setState(() {
      _registeredReservations.add(reservation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        appBar: AppBar(
            title: const Text(
              "Reservations",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 234, 114, 70),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                  onPressed: _openAddReservationsOverlay,
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
                child: ReservationsList(reservations: _registeredReservations),
              ),
              const Text('Earlier'),
            ],
          ),
        ));
  }
}
