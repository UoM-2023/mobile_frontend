import 'package:apartflow_mobile_app/models/amenity.dart';
import 'package:apartflow_mobile_app/widgets/amenity_widget/amenity_item.dart';
import 'package:flutter/material.dart';
import 'package:apartflow_mobile_app/widgets/bottomnavigationbar.dart';


class Amenities extends StatefulWidget {
  const Amenities({super.key});
  @override
  State<Amenities> createState() => _AmenitiesState();
}

//dummy data
class _AmenitiesState extends State<Amenities> {
   int _selectedIndex = 0;
   List<Amenity> _registeredAmenities = [];
  bool _isLoading = true;
  String? _errorMessage;
   

 @override
  void initState() {
    super.initState();
    _fetchAmenityData();
  }

  

  Future<void> _fetchAmenityData() async {
    
    try {
      List<Amenity> amenities = await Amenity.fetchAmenityList();
      print('Fetched amenities: $Amenities');
      setState(() {
        _registeredAmenities = amenities;
        _isLoading = false;
      });
    } catch (error) {
      print('Error in _fetchAmenityData: $error');
      setState(() {
        _errorMessage = 'Failed to load data: $error';
        _isLoading = false;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 114, 70),
        
        body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _registeredAmenities.isEmpty
                  ? const Center(child: Text('no amenities yet'))
              : ListView.builder(
                  itemCount: _registeredAmenities.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = _registeredAmenities.length - 1 - index;
                    return AmenityItem(_registeredAmenities[reversedIndex]);
                  },
                ),
        bottomNavigationBar: NavigationMenu(selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });} ),
        );
  }
}
