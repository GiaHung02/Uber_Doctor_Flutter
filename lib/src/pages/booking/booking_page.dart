import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uber_doctor_flutter/src/config/config.dart';
import 'package:uber_doctor_flutter/src/model/booking_date_convert.dart';
import 'package:uber_doctor_flutter/src/theme/button.dart';
import 'package:uber_doctor_flutter/src/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../model/booking.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

enum TimeSlotStatus {
  Available,
  Booked,
}

List<Color> timeOfDayColors = [
  const Color.fromARGB(255, 135, 193, 241), // Màu sắc cho buổi sáng
  const Color.fromARGB(255, 148, 230, 151), // Màu sắc cho buổi chiều
  const Color.fromARGB(255, 228, 172, 86), // Màu sắc cho buổi tối
];

class _BookingPageState extends State<BookingPage> {
  late tz.Location _bangkokTimeZone;
  late tz.TZDateTime _currentTimeInBangkok;
    late Map<DateTime, List<String>> bookedSlotsByDay;
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? _selectedTime;
  String symptoms = '';
  String notes = '';
  @override
  void initState() {
    super.initState();
    // Khởi tạo tz một lần
    tz.initializeTimeZones();
    _bangkokTimeZone = tz.getLocation('Asia/Bangkok');
    tz.setLocalLocation(_bangkokTimeZone);
    // Lấy thời gian hiện tại ở múi giờ 'Asia/Bangkok'
    _currentTimeInBangkok = tz.TZDateTime.now(_bangkokTimeZone);
    
  }

  // String _bookingAttachedFile = '';
  List<String> doctorWorkingHours = [
    "06:00",
    "06:30",
    "07:00",
    "07:30",
    "08:00",
    "08:30",
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    "20:00",
    "20:30",
    "21:00",
    "21:30",
    "22:00",
    "22:30",
    "23:00",
    "23:30",
  ];
 List<String> bookedSlots = [
  // "20:00",
  // "20:30",
  
];
String formatTime(DateTime time) {
  var formatter = DateFormat('HH:mm');
  return formatter.format(time);
}
  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as Doctor;
    List<String> availableTimes = buildAvailableTimes();
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
                ),
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
                      int dayIndex = index % 7;
                      int timeOfDayIndex = index ~/ (availableTimes.length / 3);

                      Color slotColor = Colors.grey;

                      if (timeOfDayIndex >= 0 &&
                          timeOfDayIndex < timeOfDayColors.length) {
                        slotColor = timeOfDayColors[timeOfDayIndex];
                      }

                      return _buildGridItem(
                          index, slotColor, doctorWorkingHours[index]);
                    },
                    childCount: availableTimes.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                  ),
                ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildSymptomsTextField(),
                _buildNotesTextField(),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Button(
                width: double.infinity,
                title: 'Book Appointment',
                onPressed: () async {
                  if (_selectedTime != null) {
                    final appointmentDate = DateConverted.getDate(_currentDay);
                    final appointmentTime = _selectedTime!;
                    final Map<String, String> bookingDetail = HashMap();
                    bookingDetail.addAll({
                      "appointmentDate": appointmentDate,
                      "appointmentTime": appointmentTime,
                      "symptoms": symptoms,
                      "notes": notes,
                      "doctor": jsonEncode(doctor),
                      "patients": jsonEncode({"id": 2})
                    });
                    Navigator.of(context).pushNamed(
                      '/booking_detail_page',
                      arguments: bookingDetail,
                    );
                  } else {
                    // Xử lý trường hợp không có thời gian được chọn
                  }
                },
                disable: _timeSelected || _dateSelected ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
        });
      }),
    );
  }

  Widget _buildGridItem(int index, Color slotColor, String time) {
  // Định dạng thời gian theo chuẩn PostgreSQL
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  String formattedTime = formatter.format(_currentTimeInBangkok);
  // Chuyển đổi thành kiểu DateTime
  DateTime currentTime = DateTime.parse(formattedTime);
  // In thời gian đã định dạng và chuyển đổi
  // print('Current Time in Bangkok Timezone (String): $formattedTime');
  // print('Current Time in Bangkok Timezone (DateTime): $currentTime');

  DateTime slotTime = DateTime(
    _currentDay.year,
    _currentDay.month,
    _currentDay.day,
    int.parse(time.split(':')[0]),
    int.parse(time.split(':')[1]),
  );

 String formattedSlotTime = formatTime(slotTime);

  if (bookedSlots.contains(formattedSlotTime) &&
    slotTime.day == _currentDay.day &&
    slotTime.month == _currentDay.month &&
    slotTime.year == _currentDay.year) {
  // Hiển thị slot time đã đặt ở ngày đó
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey,
    ),
    alignment: Alignment.center,
    child: Text(
      doctorWorkingHours[index],
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  );
} else if (currentTime.isBefore(slotTime)) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        setState(() {
          _currentIndex = index;
          _timeSelected = true;
          _selectedTime = doctorWorkingHours[index];
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: _currentIndex == index ? Colors.white : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(15),
          color: _currentIndex == index ? Colors.blue : slotColor,
        ),
        alignment: Alignment.center,
        child: Text(
          doctorWorkingHours[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _currentIndex == index ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  } else {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey,
      ),
      alignment: Alignment.center,
      child: Text(
        doctorWorkingHours[index],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}


  Widget _buildSymptomsTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        onChanged: (value) {
          setState(() {
            symptoms = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Enter your Symptoms',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildNotesTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        onChanged: (value) {
          setState(() {
            notes = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Notes to Doctor',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  List<String> buildAvailableTimes() {
    return doctorWorkingHours;
  }
}
