// import 'package:doctor_appointment_app/providers/dio_provider.dart';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uber_doctor_flutter/src/config/config.dart';
import 'package:uber_doctor_flutter/src/model/booking_date_convert.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart';
import 'package:uber_doctor_flutter/src/theme/button.dart';
import 'package:uber_doctor_flutter/src/widgets/custom_appbar.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  //declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? token;
//get token for insert booking date and time into database

  // Future<void> getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString('token') ?? '';
  // }

  @override
  void initState() {
    // getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = (ModalRoute.of(context)!.settings.arguments as Doctor);

    Config().init(context);
    // final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Appointment',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                AboutDoctor(doctor: doctor),
                _tableCalendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    alignment: Alignment.center,
                    child: const Text(
                      'Weekend is not available, please select another date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: _currentIndex == index
                                ? Config.primaryColor
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  _currentIndex == index ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1.5),
                ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: Button(
                width: double.infinity,
                title: 'Book Appointment',
                onPressed: () async {
                  //convert date/day/time into string first
                  final getDate = DateConverted.getDate(_currentDay);
                  final getDay = DateConverted.getDay(_currentDay.weekday);
                  final getTime = DateConverted.getTime(_currentIndex!);
                  final Map<String, String> bookingDetail = HashMap();
                  bookingDetail.addAll({
                    "getDate": getDate,
                    "getDay": getDay,
                    "getTime": getTime,
                    "doctor": jsonEncode(doctor)
                  });
                  Navigator.of(context)
                      .pushNamed('/booking_detail_page', arguments: bookingDetail);
                  // final booking = await DioProvider().bookAppointment(
                  //     getDate, getDay, getTime, doctor['doctor_id'], token!);

                  //if booking return status code 200, then redirect to success booking page

                  // if (booking == 200) {
                  // Navigator.of(context).pushNamed('/booking_detail_page');
                  // }
                },
                disable: _timeSelected && _dateSelected ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //table calendar
  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2024, 03, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Config.primaryColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          //check if weekend is selected
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}

// About Doctor widget
class AboutDoctor extends StatelessWidget {
  const AboutDoctor({Key? key, required this.doctor}) : super(key: key);

  // final Map<dynamic, dynamic> doctor;
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      color: Color.fromARGB(255, 176, 212, 241),
      child: Column(
        children: <Widget>[
          Config.spaceSmall,
          CircleAvatar(
            radius: 95.0,
            backgroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREpIkClC9oX1l5NYvDU-9sRGZufk18bvSFEA&usqp=CAU",
            ),
            backgroundColor: Colors.white,
          ),
          Config.spaceSmall,
          Text(
            "DR. ${doctor.fullName}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: Config.widthSize * 0.75,
            child: Text(
              'Chuyên Khoa: ${doctor.spectiality}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "Experience: ${doctor.exp}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
        ],
      ),
    );
  }
}
