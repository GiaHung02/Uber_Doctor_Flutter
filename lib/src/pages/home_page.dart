import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/model/data.dart';
import 'package:uber_doctor_flutter/src/model/doctor_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Widget _header() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Heil", style: TextStyle(fontSize: 24)),
          Text("Hitler",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ],
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.28,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _categoryCard("Chemist & Drugist", "350 + Stores",
                  color: Colors.green, lightColor: Colors.lightGreen),
              _categoryCard("Covid - 19 Specialist", "899 Doctors",
                  color: Colors.blue, lightColor: Colors.lightBlue),
              _categoryCard("Cardiologists Specialist", "500 + Doctors",
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
                                fontSize: 24, fontWeight: FontWeight.bold)),
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
                  "Top Doctors",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // IconButton(
                //   icon: Icon(
                //     Icons.sort,
                //     color: Theme.of(context).primaryColor,
                //   ),
                //   onPressed: () {
                //     // Xử lý sự kiện khi nhấn vào nút sắp xếp (nếu cần).
                //   },
                // ),
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
                  // Navigator.pushNamed(
                  //   context,
                  //   "/pages/detail_page",
                  //   arguments: doctorModel,
                  // );
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
                    onTap: () {
                      // Navigator.pushNamed(context, "/pages/detail_page",
                      //     arguments: doctorModel);
                        _navigateToDoctorDetail(doctorModel);
                    },
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
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                // decoration: BoxDecoration(
                //   color: Theme.of(context).backgroundColor,
                // ),
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _header(),
                _searchField(),
                _category(),
              ],
            ),
          ),
          _doctorsList(),
        ],
      ),
    );
  }
}
