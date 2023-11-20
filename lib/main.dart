import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/config/route.dart';
import 'package:uber_doctor_flutter/src/theme/theme.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care',
      theme: AppTheme.lightTheme,
      routes: Routes.getRoute(),
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      
      
    );
  }
}
