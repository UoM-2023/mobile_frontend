
import 'dart:convert';
import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:intl/intl.dart';
import 'dart:async';  // Import for Timer
import 'package:apartflow_mobile_app/global.dart';

class NoticeItem extends StatelessWidget {
  const NoticeItem({
    Key? key,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
  }) : super(key: key);

  final String title;
  final String description;
  final String type;
  final String date;

  @override
  Widget build(BuildContext context) {
    // Format the date
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);

    return Card(
      margin: const EdgeInsets.only(
          left: Constants.multiplier * 1.5,
          right: Constants.multiplier * 1.5,
          top: Constants.multiplier * 1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15), // rounded corners, same as Card shape
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Row
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Description and Date Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(description)),
                  Expanded(child: Text(type)),
                ],
              ),
              const SizedBox(height: 4),
              // Type
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text(type),
                  Text(formattedDate),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoticesPage extends StatefulWidget {
  const NoticesPage({Key? key}) : super(key: key);

  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  int _selectedIndex = 0;
  List<dynamic> _notices = [];
  bool _isLoading = true;
  String _errorMessage = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchNotices();
    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchNotices();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchNotices() async {
     String url = '${baseurl}/newsNotices/newNotice'; // Replace with your actual backend URL

    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('result')) {
          setState(() {
            _notices = jsonResponse['result'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'Unexpected response structure';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to load notifications';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load notifications: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 114, 70),
      appBar: AppBar(
        title: const Text(
          "News & Notices",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : ListView.builder(
                  itemCount: _notices.length,
                  itemBuilder: (context, index) {
                    final notice = _notices[index];
                    final title = notice['N_Title'] ?? 'No title';
                    final description = notice['N_Description'] ?? 'No description';
                    final type = notice['N_Type'] ?? 'No type';
                    final date = notice['N_Date'] ?? 'No date';

                    return NoticeItem(
                      title: title,
                      description: description,
                      type: type,
                      date: date,
                    );
                  },
                ),
      bottomNavigationBar: NavigationMenu(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}










// import 'dart:convert';
// import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:apartflow_mobile_app/util/barrell.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';  // Import for Timer

// class NoticeItem extends StatelessWidget {
//   const NoticeItem({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.type,
//     required this.date,
//   }) : super(key: key);

//   final String title;
//   final String description;
//   final String type;
//   final String date;

//   @override
//   Widget build(BuildContext context) {
//     // Format the date
//     DateTime parsedDate = DateTime.parse(date);
//     String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);

//     return Card(
//       margin: const EdgeInsets.only(
//           left: Constants.multiplier * 1.5,
//           right: Constants.multiplier * 1.5,
//           top: Constants.multiplier * 1),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15), // rounded corners, same as Card shape
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset: Offset(0, 1), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Title Row
//               Row(
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               // Description and Date Row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(child: Text(description)),
//                   Expanded(child: Text(type)),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               // Type
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // Text(type),
//                   Text(formattedDate),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NoticesPage extends StatefulWidget {
//   const NoticesPage({Key? key}) : super(key: key);

//   @override
//   _NoticesPageState createState() => _NoticesPageState();
// }

// class _NoticesPageState extends State<NoticesPage> {
//   int _selectedIndex = 0;
//   List<dynamic> _notices = [];
//   bool _isLoading = true;
//   String _errorMessage = '';
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     fetchNotices();
//     _startPolling();
//   }

//   void _startPolling() {
//     _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       fetchNotices();
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   Future<void> fetchNotices() async {
//     const String url = 'http://192.168.1.102:3001/newsNotices/newNotice'; // Replace with your actual backend URL

//     try {
//       final response = await http.get(Uri.parse(url));
      
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('result')) {
//           final newNotices = jsonResponse['result'];
//           if (_notices.length != newNotices.length) {
//             setState(() {
//               _notices = newNotices;
//               _isLoading = false;
//             });
//             _timer?.cancel(); // Stop polling after updating with new data
//           }
//         } else {
//           setState(() {
//             _errorMessage = 'Unexpected response structure';
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = 'Failed to load notifications';
//           _isLoading = false;
//         });
//       }
//     } catch (error) {
//       setState(() {
//         _errorMessage = 'Failed to load notifications: $error';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 234, 114, 70),
//       appBar: AppBar(
//         title: const Text(
//           "News & Notices",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color.fromARGB(255, 234, 114, 70),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//               ? Center(child: Text(_errorMessage))
//               : ListView.builder(
//                   itemCount: _notices.length,
//                   itemBuilder: (context, index) {
//                     final notice = _notices[index];
//                     final title = notice['N_Title'] ?? 'No title';
//                     final description = notice['N_Description'] ?? 'No description';
//                     final type = notice['N_Type'] ?? 'No type';
//                     final date = notice['N_Date'] ?? 'No date';

//                     return NoticeItem(
//                       title: title,
//                       description: description,
//                       type: type,
//                       date: date,
//                     );
//                   },
//                 ),
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

