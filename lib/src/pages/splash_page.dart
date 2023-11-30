import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/main.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';

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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyHomePage('0', title: 'Home page',)));
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
                image: AssetImage("assets/images/hitler.jpg"),
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
                Image.asset("assets/images/nazi.jpg", height: 100,),
                Text(
                  "Time Health",
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
