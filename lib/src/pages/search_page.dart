import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart';
import 'package:uber_doctor_flutter/src/model/pathologycal.dart';

class SearchPageWidget extends StatefulWidget {
  @override
  _SearchPageWidgetState createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  FetchSymptomList _symptomList = FetchSymptomList();
  // FetchRecommendList _recommendList = FetchRecommendList();
  TextEditingController _searchController = TextEditingController();
  List<Symptomslist> _symptomsList = [];
  List<Doctor> _recommendedDoctorsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Your Symptom',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            _getSymptomsList(query);
            // _getRecommendedDoctorsList(query);
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
            itemCount: _symptomsList.length,
            itemBuilder: (context, index) {
              var currentItem = _symptomsList[index];

              return ListTile(
                title: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '${currentItem.id ?? ""}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${currentItem.symptoms ?? ""}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${currentItem.reason ?? ""}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Recommended Doctors',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _buildRecommendedDoctorSlider(),
      ],
    );
  }

  Widget _buildRecommendedDoctorSlider() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _recommendedDoctorsList.length,
        itemBuilder: (context, index) {
          var currentItem = _recommendedDoctorsList[index];

          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${currentItem.spectiality ?? ""}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Add additional information as needed
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _getSymptomsList(String query) {
    _symptomList.getsymptomList(query: query).then((symptomsList) {
      setState(() {
        _symptomsList = symptomsList;
      });
    });
  }

  // void _getRecommendedDoctorsList(String query) {
  //   _recommendList.getRecommendList(query: query).then((doctorsList) {
  //     setState(() {
  //       _recommendedDoctorsList = doctorsList;
  //     });
  //   });
  // }

  void _clearLists() {
    setState(() {
      _symptomsList.clear();
      _recommendedDoctorsList.clear();
    });
  }
}
