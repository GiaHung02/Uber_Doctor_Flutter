import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_doctor_flutter/firebase_options.dart';
import 'package:uber_doctor_flutter/src/model/doctor_model.dart';
import 'package:uber_doctor_flutter/src/pages/booking/appointment_page.dart';
import 'package:uber_doctor_flutter/src/pages/booking/booking_detail_page.dart';
import 'package:uber_doctor_flutter/src/pages/booking/booking_doctor_list_page.dart';
import 'package:uber_doctor_flutter/src/pages/booking/booking_page.dart';
import 'package:uber_doctor_flutter/src/pages/detail_page.dart';
import 'package:uber_doctor_flutter/src/pages/doctorApp/call_doctor.dart';
import 'package:uber_doctor_flutter/src/pages/doctorApp/doctor_appointment_page.dart';
import 'package:uber_doctor_flutter/src/pages/doctorApp/doctor_home_page.dart';
import 'package:uber_doctor_flutter/src/pages/doctorApp/doctor_phone_page.dart';
import 'package:uber_doctor_flutter/src/pages/doctorApp/doctor_profile_page.dart';
import 'package:uber_doctor_flutter/src/pages/doctor_register_page.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';
import 'package:uber_doctor_flutter/src/pages/login_page.dart';
import 'package:uber_doctor_flutter/src/pages/patient_register_page.dart';
import 'package:uber_doctor_flutter/src/pages/phone_page.dart';
import 'package:uber_doctor_flutter/src/pages/profile_page.dart';
import 'package:uber_doctor_flutter/src/pages/search_page.dart';
import 'package:uber_doctor_flutter/src/pages/splash_page.dart';
import 'package:uber_doctor_flutter/src/pages/booking/success_booked.dart';
import 'package:uber_doctor_flutter/src/pages/verify.dart';
import 'package:uber_doctor_flutter/src/pages/verify_register.dart';
import 'package:uber_doctor_flutter/src/theme/theme.dart';
import 'package:uber_doctor_flutter/src/widgets/BottomNavHexagon.dart';
import 'src/model/AuthProvider.dart';

void setupNotifications() {
  AwesomeNotifications().initialize(
    'resource://drawable/app_icon',
    [
      NotificationChannel(
        channelKey: 'key_channel_booking',
        channelName: 'Bookings',
        channelDescription: 'Thông báo về các cuộc hẹn',
        defaultColor: Color.fromARGB(255, 1, 78, 141),
        ledColor: Colors.amber,
      ),
    ],
  );
}
// void handleReceivedNotification() {
//   AwesomeNotifications().actionStream.listen((receivedNotification) {
//     // Xử lý thông báo khi nhận được
//     print('Received notification: $receivedNotification');
//     // Thực hiện các hành động cần thiết dựa trên thông báo nhận được
//   });
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // setupNotifications();
  // handleReceivedNotification();

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
          'pages/detail_page': (context) => DetailPage(
                doctors: [],
                selectedIndex: 0,
              ),
          '/success_booking': (context) => AppointmentBooked(),
          '/booking_page': (context) => BookingPage(),
          '/booking_list_page': (context) => BookingDoctorListPage(),
          '/booking_detail_page': (context) => BookingDetailPage(),
          'login': (context) => LoginPage(),
          '/pages/search_page': (context) => SearchPageWidget(),
          'call_doctor': (context) => CallPageDoctor(),

          //Bs navigate
          '/bs_home_page': (context) => MyBsPage(title: 'bs home', 'bs home'),
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
    // SymptomPage(),
    BookingDoctorListPage(),
    // LoginPage(),
    //  DetailPage(doctors: [], selectedIndex: 0,),
    AppointmentPage(),
    // BookingListPage(),
    ProfilePage(),
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

////////////////////////////////////////////////////////////////////////
/// Bac si Route
class MyBsPage extends StatefulWidget {
  const MyBsPage(String s, {Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyBsPage> createState() => _MyBsPageState();
}

// khai bao cac trang de dieu huong den
class _MyBsPageState extends State<MyBsPage> {
  var _page = 0;
  final pages = [
    DoctorHomePage(),
    CallDoctor(navigatorKey: GlobalKey()),
    DoctorAppointmentPage(),
    DoctorProfilePage(),
  ];
  int visit = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarInspiredOutside(
        items: doctoritems,
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
