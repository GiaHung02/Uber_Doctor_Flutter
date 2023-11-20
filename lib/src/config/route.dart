import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uber_doctor_flutter/src/model/doctor_model.dart';
import 'package:uber_doctor_flutter/src/pages/detail_page.dart';


import 'package:uber_doctor_flutter/src/pages/home_page.dart';
import 'package:uber_doctor_flutter/src/pages/splash_page.dart';
import 'package:uber_doctor_flutter/src/widgets/custom_route.dart';


class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => SplashPage(),
      '/HomePage': (_) => HomePage(),
      '/pages/detail_page': (context) {
        final DoctorModel model = ModalRoute.of(context)!.settings.arguments as DoctorModel;
        return DetailPage(model: model);
      },
   };
 }



  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name!.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return MaterialPageRoute(
        builder: (BuildContext context) => Scaffold(
          body: Center(
            child: Text('Route not found!'),
          ),
        ),
      );
    }
    switch (pathElements[1]) {
      case "DetailPage":
        final arguments = settings.arguments;
        if (arguments is DoctorModel) {
          return CustomRoute<bool>(
            builder: (BuildContext context) => DetailPage(model: arguments),
            settings: settings,
          );
        } else {
          return MaterialPageRoute(
            builder: (BuildContext context) => Scaffold(
              body: Center(
                child: Text('Invalid argument type for DetailPage!'),
              ),
            ),
          );
        }
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: Text('Route not found!'),
            ),
          ),
        );
    }
  }
}





