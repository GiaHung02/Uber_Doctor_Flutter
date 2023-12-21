import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:uber_doctor_flutter/src/pages/detail_page.dart';
import 'package:uber_doctor_flutter/src/pages/search_page.dart';

import '../model/booking.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  List<Doctor> doctors = [];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchDoctorList _doctorApiService = FetchDoctorList();

  @override
  void initState() {
    super.initState();
    fetchDoctorList();
  }

  void fetchDoctorList() async {
    try {
      List<Doctor> fetchedDoctors = await _doctorApiService.getDoctorList();

      // Lọc danh sách bác sĩ với điều kiện status = true
      List<Doctor> activeDoctors =
          fetchedDoctors.where((doctor) => doctor.status ?? false).toList();

      // Sắp xếp danh sách bác sĩ theo rate giảm dần và exp giảm dần
      activeDoctors.sort((a, b) {
        int result = (b.rate ?? 0).compareTo(a.rate ?? 0);
        if (result == 0) {
          // Nếu rate bằng nhau, sắp xếp theo exp giảm dần
          result = (b.exp ?? 0).compareTo(a.exp ?? 0);
        }
        return result;
      });

      setState(() {
        widget.doctors = activeDoctors;
      });
    } catch (error) {
      print('Error fetching and sorting doctors: $error');
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

  void _navigateToSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPageWidget(),
      ),
    );
  }

  Widget _searchField() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPageWidget(),
          ),
        );
      },
      child: Container(
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
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                width: 50,
                child: Icon(Icons.search, color: Colors.purple),
              ),
            ],
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _categoryCard("Chemist ", "350 + Stores",
                  color: Colors.green, lightColor: Colors.lightGreen),
              _categoryCard("Covid - 19 ", "899 Doctors",
                  color: Colors.blue, lightColor: Colors.lightBlue),
              _categoryCard("Cardiologists", "500 + Doctors",
                  color: Colors.orange, lightColor: Colors.lightBlueAccent),
              _categoryCard("Dermatologist", "300 + Doctors",
                  color: Colors.green, lightColor: Colors.lightGreen),
              _categoryCard("General Surgeon", "500 + Doctors",
                  color: Colors.blue, lightColor: Colors.lightBlue)
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(String title, String subtitle,
      {Color? color, Color? lightColor}) {
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: MediaQuery.of(context).size.width * 0.3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor!.withOpacity(0.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _doctorCard(Doctor doctor, int index) {
    // print('doctor image: ${doctor.imagePath}');
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
    return widget.doctors.isEmpty
        ? Center(child: Text('No Doctor'))
        : ListView.builder(
            itemCount: widget.doctors.length,
            itemBuilder: (context, index) {
              return _doctorCard(widget.doctors[index], index);
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
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.grey,
            ),
            onPressed: _navigateToSearchPage,
          ),
          Icon(
            Icons.notifications_active,
            size: 30,
            color: Colors.grey,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child:
                      Image.asset("assets/images/harry.jpg", fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _header(),
          _searchField(),
          _category(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Top Doctors",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _doctorsList(),
          ),
        ],
      ),
    );
  }
}
