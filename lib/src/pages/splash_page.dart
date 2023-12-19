import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/main.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';
import 'package:uber_doctor_flutter/src/pages/login_page.dart';

import 'package:uber_doctor_flutter/src/theme/extention.dart';
import 'package:uber_doctor_flutter/src/theme/light_color.dart';
import 'package:uber_doctor_flutter/src/theme/text_styles.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
     Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>
      // chạy vô doctor thì uncomment dòng này
      //  MyBsPage('0', title: 'Home page',)

      // chạy vô User thì uncomment dòng này
      MyHomePage("home", title: "user home")

      // chạy vô Login thì uncomment dòng này
      // LoginPage(),
       ));
    });
    super.initState();
  }
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/wallpaper.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: .6,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [LightColor.purpleExtraLight, LightColor.purple],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                      stops: [.5, 6]),
                ),
              ),
            ),
          ),
         Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                // Image.asset("assets/images/nazi.jpg", height: 100,),
                Text(
                  "Uber Doctor",
                  style: TextStyles.h1Style.white,
                ),
                Text(
                  "By healthcare Evolution",
                  style: TextStyles.bodySm.white.bold,
                ),
                Expanded(
                  flex: 7,
                  child: SizedBox(),
                ),
              ],
            ).alignTopCenter,
        ],
      ),
    );
  }
}
