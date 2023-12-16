import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:uber_doctor_flutter/src/model/AuthProvider.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart';

import 'package:uber_doctor_flutter/src/model/pathologycal.dart';

class SearchUser extends SearchDelegate {
  FetchSymptomList _symptomList = FetchSymptomList();
  FetchRecommendList _recommendList = FetchRecommendList();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print("Query: $query");
    return FutureBuilder<List<Symptomslist>>(
      future: _symptomList.getsymptomList(query: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Symptomslist>? data = snapshot.data;

        if (data == null || data.isEmpty) {
          return Center(child: Text('No results found'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var currentItem = data[index];

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
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
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
            buildRecommendedDoctorSlider(query),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Your Symptom'),
    );
  }

  Widget buildRecommendedDoctorSlider(String query) {
    return FutureBuilder<List<Doctor>>(
      future: _recommendList.getRecommendList(query: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Doctor>? data = snapshot.data;

        if (data == null || data.isEmpty) {
          return Center(child: Text('No results found'));
        }

        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var currentItem = data[index];

              {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${currentItem.spectiality ?? ""}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
