import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

// import 'package:paypal_integration_app/constants.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:one_context/one_context.dart';
import 'package:uber_doctor_flutter/src/constants/url_api.dart';
import 'package:uber_doctor_flutter/src/helpers/ui_helper.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart';
import 'package:uber_doctor_flutter/src/pages/booking/success_booked.dart';

bool debugShowCheckedModeBanner = false;
const localeEnglish = [Locale('en', '')];

// void mainInit() {
//   runApp(const Payment());
// }

void mainInit() => OnePlatform.app = () => Payment();

class Payment extends StatelessWidget {
  // const Payment({super.key});

  Payment({super.key}) {
    print('>> MyApp2 loaded!');
    OneContext().key = GlobalKey<NavigatorState>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log('>> MyApp - build()');
    // Place that widget on most top

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const PaymentPage(),
    // );

    return OneNotification(
      builder: (_, __) => MaterialApp(
        title: 'Flutter Demo',
        home: const PaymentPage(title: 'Flutter Demo Home Page'),
        builder: OneContext().builder,
        navigatorKey: OneContext().key,
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.title});

  final String title;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    mainInit();
  }

  @override
  Widget build(BuildContext context) {
    // final bookingDetail = ModalRoute.of(context)!.settings.arguments as Map;
    // final doctor = Doctor.fromJson(jsonDecode(bookingDetail["doctor"]));
    // print(bookingDetail);
    return Scaffold(
      appBar: AppBar(
        title: Text('PayPal Integration Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => UsePaypal(
                          sandboxMode: true,
                          clientId: "${Constants.clientId}",
                          secretKey: "${Constants.secretKey}",
                          returnURL: "${Constants.returnURL}",
                          cancelURL: "${Constants.cancelURL}",
                          transactions: [
                            {
                              "amount": {
                                // "total": '${doctor.price}',
                                 "total": '12',
                                "currency": "USD",
                                // "details": {
                                //   "subtotal": '10.12',
                                //   "shipping": '0',
                                //   "shipping_discount": 0
                                // }
                              },
                              "description":
                                  "The payment transaction description.",
                              // "payment_options": {
                              //   "allowed_payment_method":
                              //       "INSTANT_FUNDING_SOURCE"
                              // },
                              // "item_list": {
                              //   "items": [
                              //     {
                              //       "name": "A demo product",
                              //       "quantity": 1,
                              //       "price": '10.12',
                              //       "currency": "USD"
                              //     }
                              //   ],

                              //   // shipping address is not required though
                              //   "shipping_address": {
                              //     "recipient_name": "Jane Foster",
                              //     "line1": "Travis County",
                              //     "line2": "",
                              //     "city": "Austin",
                              //     "country_code": "US",
                              //     "postal_code": "73301",
                              //     "phone": "+00000000",
                              //     "state": "Texas"
                              //   },
                              // }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            print("onSuccess: $params");

                            UIHelper.showAlertDialog('Payment Successfully',
                                title: 'Success');
                            // Navigator.of(context as BuildContext).pushNamed("/success_booking");
                          },
                          onError: (error) {
                            print("onError: $error");
                            UIHelper.showAlertDialog(
                                'Unable to completet the Payment',
                                title: 'Error');
                          },
                          onCancel: (params) {
                            print('cancelled: $params');
                            UIHelper.showAlertDialog('Payment Cannceled',
                                title: 'Cancel');
                          }),
                    ),
                  );
                },
                child: Text('Payment Booking'))
          ],
        ),
      ),
    );
  }
}
