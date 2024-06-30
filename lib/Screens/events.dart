import 'dart:convert';
import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apartflow_mobile_app/util/barrell.dart';
import 'package:intl/intl.dart';
import 'dart:async';  // Import for Timer
import 'package:apartflow_mobile_app/global.dart';
class EventItem extends StatelessWidget {
  const EventItem({
    Key? key,
    required this.title,
    required this.description,
    required this.place,
    required this.date1,
    required this.date2,
  }) : super(key: key);

  final String title;
  final String description;
  final String place;
  final String date1;
  final String date2;

  @override
  Widget build(BuildContext context) {
    // Format the date
    DateTime parsedDate = DateTime.parse(date1);
    String formattedDate1 = DateFormat('yyyy-MM-dd').format(parsedDate);
    parsedDate = DateTime.parse(date2);
    String formattedDate2 = DateFormat('yyyy-MM-dd').format(parsedDate);

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
                  Expanded(child: Text(place)),
                ],
              ),
              const SizedBox(height: 4),
              // Dates Row
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(formattedDate1),
                  const SizedBox(width: 16),
                  Text(formattedDate2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int _selectedIndex = 0;
  List<dynamic> _events = [];
  bool _isLoading = true;
  String _errorMessage = '';
  Timer? _timer;


  @override
  void initState() {
    super.initState();
    fetchEvents();
    _startPolling();
  }

  // void _startPolling() {
  //   _timer = Timer.periodic(Duration(seconds: 5), (timer) {
  //     fetchEvents();
  //   });
  // }

  bool _isNewDataSubmitted = false;

void _startPolling() {
  _timer = Timer.periodic(Duration(seconds: 5), (timer) {
    if (_isNewDataSubmitted) {
      fetchEvents();
      _isNewDataSubmitted = false; // Reset flag after refreshing
    }
  });
}

// Function to be called when new data is submitted
void newDataSubmitted() {
  _isNewDataSubmitted = true;
}

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchEvents() async {
     String url = '${baseurl}/newsNotices/newEvent'; // Replace with your actual backend URL

    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('result')) {
          setState(() {
            _events = jsonResponse['result'];
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
          _errorMessage = 'Failed to load events';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load events: $error';
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
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    final event = _events[index];
                    final title = event['E_Name'] ?? 'No name';
                    final description = event['E_Description'] ?? 'No description';
                    final place = event['E_Place'] ?? 'No place';
                    final date1 = event['S_Date'] ?? 'No date';
                    final date2 = event['E_Date'] ?? 'No date';

                    return EventItem(
                      title: title,
                      description: description,
                      place: place,
                      date1: date1,
                      date2: date2,
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
