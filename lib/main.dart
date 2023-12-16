import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_doctor_flutter/firebase_options.dart';
import 'package:uber_doctor_flutter/src/model/doctor_model.dart';
import 'package:uber_doctor_flutter/src/pages/booking/appointment_page.dart';
import 'package:uber_doctor_flutter/src/pages/booking/booking_detail_page.dart';
import 'package:uber_doctor_flutter/src/pages/booking/booking_doctor_list_page.dart';
import 'package:uber_doctor_flutter/src/pages/booking/booking_list_page.dart';
import 'package:uber_doctor_flutter/src/pages/booking/booking_page.dart';
import 'package:uber_doctor_flutter/src/pages/detail_page.dart';
import 'package:uber_doctor_flutter/src/pages/doctor_register_page.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';
import 'package:uber_doctor_flutter/src/pages/login_page.dart';
import 'package:uber_doctor_flutter/src/pages/patient_register_page.dart';
import 'package:uber_doctor_flutter/src/pages/phone_page.dart';
import 'package:uber_doctor_flutter/src/pages/profile_page.dart';
import 'package:uber_doctor_flutter/src/pages/search_page.dart';
import 'package:uber_doctor_flutter/src/pages/splash_page.dart';
import 'package:uber_doctor_flutter/src/pages/booking/success_booked.dart';
import 'package:uber_doctor_flutter/src/pages/symptom_page.dart';
import 'package:uber_doctor_flutter/src/pages/verify.dart';
import 'package:uber_doctor_flutter/src/pages/verify_register.dart';
import 'package:uber_doctor_flutter/src/theme/theme.dart';
import 'package:uber_doctor_flutter/src/widgets/BottomNavHexagon.dart';

import 'src/model/AuthProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp()
      // MaterialApp(
      //   initialRoute: 'home',
      //   debugShowCheckedModeBanner: false,
      //   routes: {

      //   },
      // )

      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //this is for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    DoctorModel model;

    final authProvider = MyAuthProvider();
    authProvider.loadTokenAndRole();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        // Add other providers if needed
      ],
      child: MaterialApp(
        title: 'UberDoctor',
        theme: AppTheme.lightTheme,
        initialRoute: 'home',
        navigatorKey: navigatorKey,
        routes: {
          'home': (context) => SplashPage(),
          '/home_page': (context) => MyHomePage(title: 'home', "home"),
          'phone': (context) => LoginPage(),
          'verify': (context) => MyVerify(),
          'verify_register': (context) => MyVerifyRegister(),
          'doctor/register': (context) => DoctorRegisterPage(),
          'patient/register': (context) => PatientRegisterPage(),
           'pages/detail_page': (context) =>
            DetailPage(doctors: [], selectedIndex: 0,),
          '/success_booking': (context) => AppointmentBooked(),
          '/booking_page': (context) => BookingPage(),
          '/booking_list_page': (context) => BookingDoctorListPage(),
          '/booking_detail_page': (context) => BookingDetailPage(),
          'login': (context) => LoginPage(),
            '/pages/search_page': (context) => SearchPageWidget(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(String s, {Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// khai bao cac trang de dieu huong den
class _MyHomePageState extends State<MyHomePage> {
  var _page = 0;
  final pages = [
    HomePage(),
    Call(navigatorKey: GlobalKey()),
    SymptomPage(),
    BookingDoctorListPage(),
    ProfilePage(),
    // LoginPage(),
    //  DetailPage(doctors: [], selectedIndex: 0,),
    BookingListPage(),
    AppointmentPage()
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
