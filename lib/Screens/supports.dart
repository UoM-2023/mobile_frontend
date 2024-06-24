// import 'package:flutter/material.dart';

// import 'package:apartflow_mobile_app/models/support.dart';
// import 'package:apartflow_mobile_app/models/enum.dart';
// import '../widgets/bottomnavigationbar.dart';
// import '../widgets/support_widget.dart/new_support.dart';
// import '../widgets/support_widget.dart/supports_list/support_list.dart';

// class Supports extends StatefulWidget {
//   const Supports({super.key});
//   @override
//   State<Supports> createState() {
//     return _SupportsState();
//   }
// }

// //dummy data
// class _SupportsState extends State<Supports> {
//   int _selectedIndex = 0;
//   final List<Support> _registeredSupports = [
//     Support(
//       description: 'Requested maintenance did not do yet',
//       date: DateTime.now(),
//       Supportcategory: SupportCategory.Complains,
//     ),
//     Support(
//       description: 'Handrails',
//       date: DateTime.now(),
//       Supportcategory: SupportCategory.Suggestions,
//     )
//   ];

// //open the form after pressing plus button
//   _openAddSupportOverlay() {
// //build in function for forms
//     showModalBottomSheet(
//       //to make sure that the keyboard doesn't overlap over input fields
//       isScrollControlled: true,
//       context: context,
//       builder: (ctx) => NewSupport(onAddSupport: _addSupport),
//     );
//   }

//   void _addSupport(Support support) {
//     //add a new item to the list
//     setState(() {
//       _registeredSupports.add(support);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 234, 114, 70),
//         appBar: AppBar(
//             title: const Text(
//               "Support",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             backgroundColor: const Color.fromARGB(255, 234, 114, 70),
//             iconTheme: const IconThemeData(color: Colors.white),
//             actions: [
//               IconButton(
//                   onPressed: _openAddSupportOverlay,
//                   icon: const Icon(
//                     Icons.add,
//                     color: Colors.white,
//                   )),
//             ]),
//         body: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 30,
//               ),

//               const Row(children: [
//                 SizedBox(width: 10),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'New',
//                     style: TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                 )
//               ]),
//               const SizedBox(
//                 height: 20,
//               ),
//               Expanded(

//                   //new maintenance list
//                   child: SupportsList(supports: _registeredSupports)),

//               const Text('Earlier'),
//               //earlier maintenance list
//               const Expanded(child: Text('Earlier support requests')),
//             ],
//           ),
//         ),
//         bottomNavigationBar: NavigationMenu(selectedIndex: _selectedIndex,
//               onItemTapped: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });} ),
//         );
//   }
// }
