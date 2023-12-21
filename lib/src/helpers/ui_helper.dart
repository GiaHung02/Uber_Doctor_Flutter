// import 'dart:js';

import 'package:flutter/material.dart';
// import 'package:paypal_integration_app/helpers/navigation_service.dart';
import 'package:one_context/one_context.dart';

class UIHelper {
  static showAlertDialog(String message, {title = 'Success'}) {
    OneContext().showDialog(
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2.0))),
          actions: [
            ElevatedButton(
                onPressed: () {
                  // go back from second page
                  // Navigator.of(context as BuildContext).pushNamed("/home_page");
                  Navigator.of(ctx).pushNamed("success_booking");
                  //  Navigator.of(ctx).pop();
                  // OneContext().pop();
                },
                child: Text('Ok'))
          ],
        );
      },
    );
  }
}
