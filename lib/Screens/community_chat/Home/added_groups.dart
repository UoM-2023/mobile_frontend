// import 'package:apartflow_mobile_app/Screens/community_chat/group/group_page.dart';
// import 'package:flutter/material.dart';


// import '../../../widgets/bottomnavigationbar.dart';

// class Community extends StatefulWidget {
//   const Community({Key? key}) : super(key: key);

//   @override
//   _CommunityState createState() => _CommunityState();
// }

// class _CommunityState extends State<Community> {
//   int _selectedIndex = 2; // Assuming this is the index for the search page

//   TextEditingController nameController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           elevation: 0,
//           centerTitle: true,
//           title: const Text(
//             "Communities",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 234, 114, 70),
//           iconTheme: const IconThemeData(color: Colors.white),
//           actions: [
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.add,
//                   color: Colors.white,
//                 )),
//           ]),
//       body: Center(
//         child: TextButton(
//           onPressed: () => showDialog(
//               context: context,
//               builder: (BuildContext context) => AlertDialog(
//                     title: const Text("Please enter your name"),
//                     content: Form(
//                       key: formKey,
//                       child: TextFormField(
//                         controller: nameController,
//                         validator: (Value) {
//                           if (Value == null || Value.length < 3) {
//                             return "User must have proper name";
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     actions: [
//                       TextButton(
//                           onPressed: () {
//                             nameController.clear();
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             "cancel",
//                             style: TextStyle(fontSize: 16, color: Colors.red),
//                           )),
//                       TextButton(
//                           onPressed: () {
                            
//                             if (formKey.currentState!.validate()) {
//                               String name=nameController.text;
//                               nameController.clear();
//                               Navigator.pop(context);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => GroupPage(name:name),
//                                 ),
//                               );
//                             }
//                           },
//                           child: const Text(
//                             "Enter",
//                             style:
//                                 TextStyle(fontSize: 16, color: Colors.orange),
//                           )),
//                     ],
//                   )),
//           child: const Text("Initiate group chat"),
//         ),
//       ),
//       bottomNavigationBar: NavigationMenu(
//         selectedIndex: _selectedIndex,
//         onItemTapped: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
