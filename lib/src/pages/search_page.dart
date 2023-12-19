import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:uber_doctor_flutter/src/pages/detail_page.dart';

import '../model/booking.dart';

class SearchPageWidget extends StatefulWidget {
  @override
  _SearchPageWidgetState createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  FetchDoctorList _doctorList = FetchDoctorList();
  TextEditingController _searchController = TextEditingController();
  List<Doctor> _doctorSearchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for Doctors',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            _getDoctorList(query);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _searchController.clear();
              _clearLists();
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: _doctorSearchList.length,
          itemBuilder: (context, index) {
            var currentDoctor = _doctorSearchList[index];

            return GestureDetector(
              onTap: () {
                _navigateToDoctorDetail(currentDoctor);
              },
              child: ListTile(
                title: Row(
                  children: [
                    // Display doctor information as needed
                    Text(
                      '${currentDoctor.fullName ?? ""}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 20),
                    // Add additional information as needed
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

void _navigateToDoctorDetail(Doctor doctorModel) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailPage(doctors: [doctorModel], selectedIndex: 0),
    ),
  );
}


  void _getDoctorList(String query) {
    _doctorList.getDoctorList(query: query).then((doctorList) {
      setState(() {
        _doctorSearchList = doctorList;
      });
    });
  }

  void _clearLists() {
    setState(() {
      _doctorSearchList.clear();
    });
  }
}

