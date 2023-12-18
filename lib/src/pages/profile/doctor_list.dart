import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/api/doctor_api/doctor_api_service.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart';
import 'package:uber_doctor_flutter/src/pages/profile/doctor_detail_page.dart';

class DoctorListPage extends StatefulWidget {
  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  final DoctorService doctorApi = DoctorService();
  late Future<List<Doctor>> doctors;

  @override
  void initState() {
    super.initState();
    doctors = doctorApi.getDoctors();
  }

  void _navigateToDoctorDetail(Doctor doctorModel, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DoctorDetailPage(doctors: [doctorModel], selectedIndex: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor List'),
      ),
      body: FutureBuilder(
        future: doctors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var data = snapshot.data;
            if (data == null || data.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(child: Text('No doctors found')),
              );
            } else {
              List<Doctor> doctorList = snapshot.data as List<Doctor>;
              return ListView.builder(
                itemCount: doctorList.length,
                itemBuilder: (context, index) {
                  Doctor doctor = doctorList[index];
                  return ListTile(
                    title: Text(doctor.fullName ?? ''),
                    subtitle: Text(doctor.spectiality ?? ''),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        // _navigateToDoctorDetailPage(context, doctor);
                        _navigateToDoctorDetail(doctorList[index], index);
                      },
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
