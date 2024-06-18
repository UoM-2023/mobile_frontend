// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'group.dart';

// class Section2 extends StatelessWidget {
//   const Section2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('groups').snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }

//         final groups = snapshot.data!.docs
//             .map((doc) => Group.fromMap(doc.data() as Map<String, dynamic>, doc.id))
//             .toList();

//         return ListView.builder(
//           itemCount: groups.length,
//           itemBuilder: (context, index) {
//             final group = groups[index];
//             return ListTile(
//               title: Text(group.name),
//               subtitle: Text(group.description),
//               onTap: () {
//                 // Handle adding group to Section1 here
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
