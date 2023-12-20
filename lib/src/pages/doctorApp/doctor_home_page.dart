import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:uber_doctor_flutter/src/pages/detail_page.dart';
import 'package:uber_doctor_flutter/src/pages/search_page.dart';

import '../../model/booking.dart';
class DoctorHomePage extends StatefulWidget {
  DoctorHomePage({Key? key}) : super(key: key);
  List<Doctor> doctors = [];

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  FetchDoctorList _doctorApiService = FetchDoctorList();
BookingApiService _upcomingApiService = BookingApiService();
  @override
  void initState() {
    super.initState();
  }
void fetchUpcomingList() async {
  try {
    List<Booking> fetchedUpcomingList = await _upcomingApiService.getBookingsWithPatientName();
    setState(() {
      widget.doctors = fetchedUpcomingList.map((booking) => booking.doctors!).cast<Doctor>().toList();
    });
  } catch (error) {
    // Handle the error
    print('Error fetching upcoming list: $error');
  }
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

  // Widget _header() {
  //   return Padding(
  //     padding: EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text("Heil", style: TextStyle(fontSize: 24)),
  //         Text("Hitler",
  //             style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
  //       ],
  //     ),
  //   );
  // }

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

 
Widget _upcomingList() {
  return CustomScrollView(
    slivers: [
      SliverPadding(
        padding: EdgeInsets.all(16),
        sliver: SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Upcoming Bookings",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      FutureBuilder<List<Booking>>(
        future: _upcomingApiService.getBookingsWithPatientName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: Center(child: Text('Error: ${snapshot.error}')),
            );
          } else {
            var data = snapshot.data;
            if (data == null || data.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(child: Text('No bookings found')),
              );
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var booking = data[index];
                    var patientName = booking.patients?.fullName ?? 'N/A';
                    var patientPhone = booking.patients?.phoneNumber ?? 0;
                    return GestureDetector(
                      onTap: () {
                        // _navigateToBookingDetail(booking, index);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 10,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            BoxShadow(
                              offset: Offset(-3, 0),
                              blurRadius: 15,
                              color: Colors.grey.withOpacity(0.1),
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            // _navigateToDoctorDetail(booking, index);
                          },
                          borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                          child: Container(
padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(15),
                                    color: Colors
                                        .blue, // Update with your color logic
                                  ),
                                  child: booking.doctors?.imagePath != null &&
                                          booking.doctors!.imagePath!.isNotEmpty
                                      ? Image.network(
                                          "$domain/${booking.doctors!.imagePath!}",
                                          fit: BoxFit.cover,
                                        )
                                      : Container(),
                                ),
                              ),
                              title: Text(
                                ' ${booking.patients?.fullName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                '$patientPhone',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: data.length,
                ),
              );
            }
          }
        },
      ),
    ],
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
      
          Expanded(
            child: _upcomingList(),
          ),
        ],
      ),
    );
  }
}
