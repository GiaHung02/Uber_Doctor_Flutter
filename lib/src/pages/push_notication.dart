import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:uber_doctor_flutter/main.dart';

void mainInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Push());
}

class Push extends StatefulWidget {
  const Push({Key? key}) : super(key: key);

  @override
  _PushState createState() => _PushState();
}

class _PushState extends State<Push> {
  @override
  void initState() {
    configonesignal();
    super.initState();
    mainInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Hello"),
          ],
        ),
      ),
    );
  }

  void configonesignal() {
    OneSignal.initialize("0ba9731b-33bd-43f4-8b59-61172e27447d");
  }
}
