import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uber_doctor_flutter/src/constants/url_api.dart';
import 'package:uber_doctor_flutter/src/helpers/ui_helper.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart';
import 'package:uber_doctor_flutter/src/theme/button.dart';
import 'package:uber_doctor_flutter/src/theme/colors.dart';
import 'package:uber_doctor_flutter/src/theme/styles.dart';
import 'package:uber_doctor_flutter/src/widgets/custom_appbar.dart';

void sendSuccessDataToBackend(Map params) async {
  try {
    Dio dio = Dio();
    Response response =
        await dio.post('$domain/api/v1/payment/create', data: params);

    // Xử lý kết quả từ backend (response.data)
    print('Backend Response: ${response.data}');
  } catch (error) {
    // Xử lý lỗi
    print('Error sending data to backend: $error');
  }
}

class BookingDetailPage extends StatelessWidget {
  const BookingDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Appointment',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //     pinned: true,
          //     title: Text('Booking Detail'),
          //     backgroundColor: Config.primaryColor),
          SliverToBoxAdapter(
            child: DetailBody(),
          )
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //lấy dữ liệu từ trang booking
    final bookingDetail = ModalRoute.of(context)!.settings.arguments as Map;
    //decode tu json
    final doctor = Doctor.fromJson(jsonDecode(bookingDetail["doctor"]));
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 226, 230),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 195, 193, 193).withOpacity(0.5),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(children: [
              DetailDoctorCard(
                doctor: doctor,
              ),
              SizedBox(
                height: 15,
              ),
              DoctorInfo(doctor: doctor),
            ]),
          ),
          SizedBox(
            height: 12,
          ),
          // Time booking
          Text(
            'Date booking:',
            style: kTitleStyle,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 191, 212, 232),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Text(
              ' ${bookingDetail['getDate']}',
              style: TextStyle(
                color: Color.fromARGB(255, 114, 114, 114),
                fontSize: 17.0,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          // Time booking
          Text(
            'Time:',
            style: kTitleStyle,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 191, 212, 232),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Text(
              ' ${bookingDetail['getTime']}',
              style: TextStyle(
                color: Color.fromARGB(255, 114, 114, 114),
                fontSize: 17.0,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          // Price booking
          Text(
            'Price:',
            style: kTitleStyle,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 191, 212, 232),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Text(
              '${doctor.price} VND',
              style: TextStyle(
                color: Color.fromARGB(255, 114, 114, 114),
                fontSize: 17.0,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
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
                              "total": '${doctor.price}',
                              // "total": '',
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
                        onSuccess: (Map params) {
                          print("onSuccess: $params");
                          UIHelper.showAlertDialog('Payment Successfully',
                              title: 'Success');
                          // Navigator.of(context as BuildContext).pushNamed("/success_booking");

                          sendSuccessDataToBackend(params);
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
    );
  }
}

class DoctorInfo extends StatelessWidget {
  final Doctor doctor;
  const DoctorInfo({
    Key? key,
    required this.doctor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NumberCard(
          label: 'Patients',
          value: '100+',
        ),
        SizedBox(width: 15),
        NumberCard(
          label: 'Experiences',
          value: '${doctor.exp}',
        ),
        SizedBox(width: 15),
        NumberCard(
          label: 'Rating',
          value: '${doctor.rate}',
        ),
      ],
    );
  }
}

class AboutDoctor extends StatelessWidget {
  final String title;
  final String desc;
  const AboutDoctor({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NumberCard extends StatelessWidget {
  final String label;
  final String value;

  const NumberCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(MyColors.bg03),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 15,
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(MyColors.grey02),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                color: Color(MyColors.header01),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailDoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DetailDoctorCard({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${doctor.fullName}',
                      style: TextStyle(
                          color: Color(MyColors.header01),
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Spectiality: ${doctor.spectiality}',
                      style: TextStyle(
                        color: Color(MyColors.grey02),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Image(
                image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREpIkClC9oX1l5NYvDU-9sRGZufk18bvSFEA&usqp=CAU",
                ),
                width: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
