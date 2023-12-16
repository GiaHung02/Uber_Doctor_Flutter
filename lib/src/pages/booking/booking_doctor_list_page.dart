import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:doctor_appointment_app/models/auth_model.dart';
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart';
import 'package:uber_doctor_flutter/src/pages/detail_page.dart';

class BookingDoctorListPage extends StatefulWidget {
  BookingDoctorListPage({Key? key}) : super(key: key);
  List<Doctor> doctors = [];

  @override
  State<BookingDoctorListPage> createState() => _BookingDoctorListPageState();
}

class _BookingDoctorListPageState extends State<BookingDoctorListPage> {
  FetchDoctorList _doctorApiService = FetchDoctorList();
  int visit = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);

  @override
  void initState() {
    super.initState();
  }

  void fetchDoctorList() async {
    try {
      List<Doctor> fetchedDoctors = await _doctorApiService.getDoctorList();
      setState(() {
        widget.doctors = fetchedDoctors; // Use widget.doctors here
      });
    } catch (error) {
      // Handle the error
      print('Error fetching doctors: $error');
    }
  }

  // void _navigateToDoctorDetail(DoctorModel doctorModel) {
  //   Navigator.pushNamed(
  //     context,
  //     "/pages/detail_page",
  //     arguments: doctorModel,
  //   );
  // }
 void _navigateToDoctorDetail(Doctor doctorModel, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailPage(doctors: [doctorModel], selectedIndex: 0),
      ),
    );
  }
  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: SizedBox(
            width: 50,
            child: Icon(Icons.search, color: Colors.purple),
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Category",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "See All",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _doctorsList() {
    return FutureBuilder<List<Doctor>>(
      future: _doctorApiService.getDoctorList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var data = snapshot.data;
          if (data == null || data.isEmpty) {
            return Center(child: Text('No doctors found'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: randomColor(),
                          child: data?[index].image != null &&
                                  data[index].image!.isNotEmpty
                              ? Image.network(data[index].image![0] as String)
                              : Container(),
                        ),
                        title: Text(
                          '${data?[index].fullName}',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          'Khoa: ${data?[index].spectiality}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          _navigateToDoctorDetail(data![index], index);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      Colors.orange,
      Colors.green,
      Colors.grey,
      Colors.orange,
      Colors.blue,
      Colors.black,
      Colors.red,
      Colors.brown,
      Colors.purple,
      Colors.blue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        // leading: Icon(
        //   Icons.short_text,
        //   size: 30,
        //   color: Colors.black,
        // ),
        actions: <Widget>[
          Icon(
            Icons.notifications_active,
            size: 30,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _header(),
          _searchField(),
          // _category(),
          Expanded(
            child: _doctorsList(),
          ),
        ],
      ),
    );
  }
}
