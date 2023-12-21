import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:uber_doctor_flutter/main.dart';

void main() {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic Notification',
            channelDescription: 'Notication chanel for basic test')
      ],
      debug: true);
}

class Push extends StatefulWidget {
  const Push({Key? key}) : super(key: key);

  @override
  _PushState createState() => _PushState();
}

class _PushState extends State<Push> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
    // mainInit();
  }

  TriggerNotications() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Simple Notification',
        body: 'Simple Button',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.key as String),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: TriggerNotications,
        child: const Text("Trigger Notications"),
      )),
    );
  }

  // void configonesignal() {
  //   OneSignal.initialize("0ba9731b-33bd-43f4-8b59-61172e27447d");
  // }
}
