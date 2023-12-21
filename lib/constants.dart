// Flutter imports:
import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/main.dart';
import 'package:uber_doctor_flutter/src/model/booking.dart';
import 'package:uber_doctor_flutter/src/pages/doctorApp/call_doctor.dart';
import 'package:uber_doctor_flutter/src/pages/doctorApp/doctor_login.dart';
import 'package:uber_doctor_flutter/src/pages/doctorApp/doctor_phone_page.dart';
import 'package:uber_doctor_flutter/src/pages/doctor_register_page.dart';

// Project imports:
import 'src/call/call.dart';
import 'src/call/login_page.dart';

class PageRouteNames {
  static const String login = '/login';
  static const String loginDoctor = 'loginDoctor';
  static const String home = '/home_page1';
  static const String home2 = '/home_page';
  static const String register = 'doctor/register';
  static const String doctorCall = 'call_doctor';
}

const TextStyle textStyle = TextStyle(
  color: Colors.black,
  fontSize: 13.0,
  decoration: TextDecoration.none,
);

Map<String, WidgetBuilder> routes = {
  PageRouteNames.login: (context) => const LoginPage(),
  PageRouteNames.loginDoctor: (context) => const LoginPage(),
  PageRouteNames.home: (context) => const CallPage(),
  PageRouteNames.home2: (context) => const MyHomePage(title: 'home', "home"),
  PageRouteNames.register: (context) => const DoctorRegisterPage(),
  PageRouteNames.doctorCall: (context) => const CallPageDoctor(),
  PageRouteNames.loginDoctor: (context) => const LoginPageDoctor(),
};

class UserInfo {
  String id = '';
  String name = '';
  String phoneNumber = '';

  UserInfo({
    required this.id,
    required this.name,
  });

  bool get isEmpty => id.isEmpty;

  UserInfo.empty();
}

UserInfo currentUser = UserInfo.empty();
const String cacheUserIDKey = 'cache_user_id_key';
Doctor doctor = Doctor.fromJson(doctor as Map<String, dynamic>);
