import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/call/call.dart';
import 'package:uber_doctor_flutter/src/model/doctor_model.dart';
import 'package:uber_doctor_flutter/src/pages/booking_page.dart';
import 'package:uber_doctor_flutter/src/pages/detail_page.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';
import 'package:uber_doctor_flutter/src/pages/login_page.dart';
import 'package:uber_doctor_flutter/src/pages/payment_page.dart';
import 'package:uber_doctor_flutter/src/pages/phone_page.dart';
import 'package:uber_doctor_flutter/src/pages/profile_page.dart';
import 'package:uber_doctor_flutter/src/pages/symptom_page.dart';
import 'package:uber_doctor_flutter/src/theme/theme.dart';
import 'package:uber_doctor_flutter/src/widgets/BottomNavHexagon.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:permission_handler/permission_handler.dart';

import 'src/call/constants.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UberDoctor',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'nav'),
        '/pages/detail_page': (context) =>
            DetailPage(), // Thay thế DoctorModel() bằng đối tượng DoctorModel bạn muốn hiển thị chi tiết.
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// khai bao cac trang de dieu huong den
class _MyHomePageState extends State<MyHomePage> {
  var _page = 0;
  final pages = [
    HomePage(),
    Call(navigatorKey:GlobalKey()),
    SymptomPage(),
    BookingPage(),
    ProfilePage(),
    LoginPage(),
    DetailPage(),
    PaymentPage(),

  ];
  int visit = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);
  // dieu hướng từ HomePage den detail
  void _navigateToDoctorDetail(DoctorModel doctorModel) {
    Navigator.pushNamed(
      context,
      "/pages/detail_page",
      arguments: doctorModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CurvedNavigationBar(
      //     index: 0,
      //     color: Colors.blue,
      //     backgroundColor: Colors.white,
      //     buttonBackgroundColor: Colors.blue,
      //     animationCurve: Curves.easeInOut,
      //     animationDuration: Duration(milliseconds: 400),
      //     onTap: (index) {
      //       setState(() {
      //         _page = index;
      //       });
      //     },
      //     items: [
      //       Icon(Icons.home),
      //       Icon(Icons.phone),
      //       Icon(Icons.coronavirus),
      //       Icon(Icons.calendar_month),
      //       Icon(Icons.account_box),
      //     ]),
      // body: pages[_page],

      // drawer: CurrentPage(
      //   selectedIndex: _selectedIndex,
      //   onItemTapped: _onItemTapped,
      // ),
      bottomNavigationBar: BottomBarInspiredOutside(
        items: items,
        backgroundColor: bgColor,
        color: color2,
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (index) => setState(() {
          visit = index;
          _page = index;
        }),
        top: -28,
        animated: true,
        itemStyle: ItemStyle.hexagon,
        chipStyle: const ChipStyle(drawHexagon: true),
      ),
      body: pages[_page],
    );
  }
}

// class MyApp extends StatefulWidget {
//   final GlobalKey<NavigatorState> navigatorKey;

//   const MyApp({
//     required this.navigatorKey,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => MyAppState();
// }


