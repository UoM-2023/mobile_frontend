import 'package:flutter/material.dart';
import 'notices.dart'; // Ensure you have created notices.dart
import 'events.dart'; // Ensure you have created events.dart

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back arrow
        bottom: TabBar(
          tabs: [
            Tab(text: 'Notices'),
            Tab(text: 'Events'),
          ],
        ),
      ),
       body: TabBarView(
          children: [
            NoticesPage(),
            EventsPage(),
          ],
        ),
      ),
    );
  }
}
//           onTap: (index) {
//             // Handle tab selection
//             if (index == 0) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NoticesPage()),
//               );
//             } else if (index == 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => EventsPage()),
//               );
//             }
//           },
//         ),
//       ),
//       body: Center(
//         child: Text('Notifications Page Content Here'),
//       ),
//     );
//   }
// }
