import 'dart:math';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    fetchDoctorList();
  }

  void fetchDoctorList() async {
    try {
      List<Doctor> fetchedDoctors = await _doctorApiService.getDoctorList();
      setState(() {
        widget.doctors = fetchedDoctors; // Use widget.doctors here
      });
    } catch (error) {
      print('Error fetching doctors: $error');
    }
  }

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

  Widget _doctorCard(Doctor doctor, int index) {
    print('doctor image: ${doctor.imagePath}');
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(2),
        leading: Container(
          width: 80.0,
          child: Column(
            children: [
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 152, 151, 151).withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 34.0,
                  backgroundColor: randomColor(),
                  child: ClipOval(
                    child: SizedBox(
                      width: 52.0,
                      height: 52.0,
                      child: doctor.imagePath != null &&
                              doctor.imagePath!.isNotEmpty
                          ? Image.network(
                              "$domain/${doctor.imagePath!}",
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: Text(
          '${doctor.fullName}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2),
              height: 24,
              width: 150,
              decoration: BoxDecoration(
                color: Color.fromRGBO(222, 221, 221, 1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'Special: ${doctor.spectiality}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                ),
              ),
            ),
            Text(
              'Exp: ${doctor.exp}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
            ),
            Container(
              height: 18,
              width: 50,
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 227, 124, 15),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  Text(
                    '${doctor.rate}',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 2.0),
                  Icon(Icons.star, color: Colors.white, size: 14.0),
                ],
              ),
            ),
          ],
        ),
        trailing: Container(
          margin: EdgeInsets.only(right: 8),
          child: ElevatedButton(
            onPressed: () {
              _navigateToDoctorDetail(doctor, index);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            child: Text(
              "Đặt hẹn",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        onTap: () {
          _navigateToDoctorDetail(doctor, index);
        },
      ),
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
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return _doctorCard(data![index], index);
              },
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          Expanded(
            child: _doctorsList(),
          ),
        ],
      ),
    );
  }
}
