// Flutter imports:
import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/call/call.dart';
import 'package:uber_doctor_flutter/src/call/login_page.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';

// Project imports:
// import '../../home_page.dart';
// import '../../login_page.dart';

class PageRouteNames {
  static const String login = '/login';
  static const String home = '/home_page';
}

const TextStyle textStyle = TextStyle(
  color: Colors.black,
  fontSize: 13.0,
  decoration: TextDecoration.none,
);

Map<String, WidgetBuilder> routes = {
  PageRouteNames.login: (context) => const LoginPage(),
  PageRouteNames.home: (context) => const CallPage(),
};

class UserInfo {
  String id = '';
  String name = '';

  UserInfo({
    required this.id,
    required this.name,
  });

  bool get isEmpty => id.isEmpty;

  UserInfo.empty();
}

UserInfo currentUser = UserInfo.empty();
const String cacheUserIDKey = 'cache_user_id_key';