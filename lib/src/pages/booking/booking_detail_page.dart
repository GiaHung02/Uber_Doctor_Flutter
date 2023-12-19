import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_context/one_context.dart';
import 'package:uber_doctor_flutter/src/constants/url_api.dart';
import 'package:uber_doctor_flutter/src/model/booking.dart';
import 'package:uber_doctor_flutter/src/theme/button.dart';
import 'package:uber_doctor_flutter/src/theme/colors.dart';
import 'package:uber_doctor_flutter/src/theme/styles.dart';
import 'package:uber_doctor_flutter/src/widgets/custom_appbar.dart';

import '../../helpers/ui_helper.dart';

void sendSuccessDataToBackend(
    double? price, int? id, Map<String, dynamic> bookingDetail) async {
  // Ensure that "patients" key exists and is a map
// Ensure that "patients" key exists and is a map
  final dynamic patientsValue = bookingDetail['patients'];
  String convertDateFormat(String inputDate) {
    // Chuyển đổi từ "12/19/2023" sang "2023-12-19"
    List<String> dateParts = inputDate.split('/');
    String formattedDate = "${dateParts[2]}-${dateParts[0]}-${dateParts[1]}";
    return formattedDate;
  }

  String formattedAppointmentDate =
      convertDateFormat(bookingDetail["appointmentDate"]);

// Parse JSON string if "patients" key is a String
  final Map<String, dynamic>? patientsData = patientsValue is String
      ? jsonDecode(patientsValue)
      : patientsValue as Map<String, dynamic>?;

// Extract patient ID if "patients" key is a map and contains "id" property
  final int? patientId = patientsData != null ? patientsData['id'] : null;
//     print('>>>>>>>>>>>>>>>>>>>>>>appointmentDate: ${bookingDetail["appointmentDate"]}');
//     print('>>>>>>>>>>>>>>>>>>>>>>appointmentTime: ${bookingDetail["appointmentTime"]}');
//     print('>>>>>>>>>>>>>>>>>>>>>>symptoms: ${bookingDetail["symptoms"]}');
//     print('>>>>>>>>>>>>>>>>>>>>>>notes: ${bookingDetail["notes"]}');
//     print('>>>>>>>>>>>>>>>>>>>>>>doctỏ id: ${id}');
//     print('>>>>>>>>>>>>>>>>>>>>>>price: ${price}');
// print('Dữ Liệu Yêu Cầu: ${json.encode({
//   "appointmentDate": bookingDetail["appointmentDate"],
//   "appointmentTime": bookingDetail["appointmentTime"],
//   "symptoms": bookingDetail["symptoms"],
//   "notes": bookingDetail["notes"],
//   "patients": {
//     "id": patientId,
//     // Các trường bệnh nhân khác
//   },
//   "doctors": {
//     "id": id,
//     // Các trường bác sĩ khác
//   }
// })}');
  try {
    Dio dio = Dio();
    Response response = await dio.post('$domain2/api/v1/payment/create', data: {
      "paymentPhone": "0972984029",
      "price": price,
      "patientName": "Hoang",
      "message": "payment success with PayPal"
    });

    Response response1 =
        await dio.post('$domain2/api/v1/booking/create', data: {
      "appointmentDate": formattedAppointmentDate,
      "appointmentTime": bookingDetail["appointmentTime"],
      "symptoms": bookingDetail["symptoms"],
      "notes": bookingDetail["notes"],
      "price": price,
      "bookingAttachedFile": null,
      "patients": {
        "id": patientId, 
      },
      "doctors": {
        "id": id,
      }
    });

    // Xử lý kết quả từ backend (response.data)
    // print('Backend Response: ${response1.data}');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>> Backend Response: ${response1.statusCode}');
  } catch (e) {
    if (e is DioError) {
      // Xử lý DioError, kiểm tra mã lỗi 403 và thực hiện hành động tương ứng
      if (e.response?.statusCode == 403) {
        // Xử lý lỗi 403 ở đây
      } else {
        // Xử lý các trường hợp khác
      }
    } else {
      // Xử lý các loại lỗi khác
    }
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
              ' ${bookingDetail['appointmentTime']}',
              style: TextStyle(
                color: Color.fromARGB(255, 114, 114, 114),
                fontSize: 17.0,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),

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
              ' ${bookingDetail['appointmentDate']}',
              style: TextStyle(
                color: Color.fromARGB(255, 114, 114, 114),
                fontSize: 17.0,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          if (bookingDetail['symptoms'] != null &&
              bookingDetail['symptoms'] != '')
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Symptoms:',
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
                    ' ${bookingDetail['symptoms']}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 114, 114, 114),
                      fontSize: 17.0,
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),

          // Kiểm tra và hiển thị Notes nếu có dữ liệu
          if (bookingDetail['notes'] != null && bookingDetail['notes'] != '')
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Notes:',
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
                    ' ${bookingDetail['notes']}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 114, 114, 114),
                      fontSize: 17.0,
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
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
              '${doctor.price} USD',
              style: TextStyle(
                color: Color.fromARGB(255, 114, 114, 114),
                fontSize: 17.0,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),

          Button(
            width: double.infinity,
            title: 'Payment Booking',
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
                          },
                          "description": "The payment transaction description.",
                        }
                      ],
                      note: "Contact us for any questions on your order.",
                      onSuccess: (Map params) {
                        print("onSuccess: $params");
                        UIHelper.showAlertDialog('Payment Successfully',
                            title: 'Success');

                        // print(params);
                        // print("Payment Status: $params['status']");
                        // print("Payment Status: $params[datafirst_name]");

                        sendSuccessDataToBackend(doctor.price, doctor.id,
                            Map<String, dynamic>.from(bookingDetail));
                        // Navigator.of(context)
                        //     .pushNamed("/success_booking");
                        
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
            disable: false,
          ),
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
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue, // Update with your color logic
                  ),
                  child:
                      doctor.imagePath != null && doctor.imagePath!.isNotEmpty
                          ? Image.network(
                              "$domain2/${doctor.imagePath!}",
                              fit: BoxFit.cover,
                            )
                          : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    //   home: const PaymentPage(title: '',),
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
    // TODO: implement build
    throw UnimplementedError();
  }
}