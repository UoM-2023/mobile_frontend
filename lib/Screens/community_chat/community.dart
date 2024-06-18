//import 'package:apartflow_mobile_app/Screens/community_chat/group/group_page.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
// 'package:apartflow_mobile_app/widgets/community_widgets';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  int _selectedIndex = 2; // Assuming this is the index for the search page

  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Communities",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 234, 114, 70),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Section 1'),
              Tab(text: 'Section 2'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Section1(),
            Section2(),
          ],
        ),
      ),
    );
  }
}

class Section1 extends StatelessWidget {
  const Section1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Content for Section 1'),
    );
  }
}

class Section2 extends StatelessWidget {
  const Section2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Content for Section 2'),
    );
  }
}
