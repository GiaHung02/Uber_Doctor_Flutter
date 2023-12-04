import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:doctor_appointment_app/models/auth_model.dart';
import 'package:uber_doctor_flutter/src/model/data.dart';
import 'package:uber_doctor_flutter/src/model/doctor_model.dart';

class BookingDoctorListPage extends StatefulWidget {
  const BookingDoctorListPage({super.key});

  @override
  State<BookingDoctorListPage> createState() => _BookingDoctorListPageState();
}

class _BookingDoctorListPageState extends State<BookingDoctorListPage> {
  List<DoctorModel> doctorDataList = [];
  int visit = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);

  @override
  void initState() {
    doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
  }

  void _navigateToDoctorDetail(DoctorModel doctorModel) {
    Navigator.pushNamed(
      context,
      "/pages/detail_page",
      arguments: doctorModel,
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
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Please choose a Doctor",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: doctorDataList.length,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) {
              final doctorModel = doctorDataList[index];
              return GestureDetector(
                onTap: () {
                  _navigateToDoctorDetail(doctorModel);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => SliverDoctorDetail(),
                    //       ));
                    //   // _navigateToDoctorDetail(doctorModel);
                    // },
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: randomColor(),
                            ),
                            child: Image.asset(
                              doctorModel.image,
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        title: Text(
                          doctorModel.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          doctorModel.type,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
          ),
        ],
      ),
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
        SizedBox(width: 10,),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _searchField(),
                // _category(),
              ],
            ),
          ),
          _doctorsList(),
        ],
      ),
    );
  }
}
