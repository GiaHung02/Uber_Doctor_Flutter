import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uber_doctor_flutter/src/model/booking.dart';
import 'package:http/http.dart' as http;

class DoctorAppointmentPage extends StatefulWidget {
  const DoctorAppointmentPage({Key? key}) : super(key: key);

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

enum FilterStatus { upcoming, complete, cancel }

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  List<Booking> schedules = [];

  @override
  void initState() {
    super.initState();
    // Gọi hàm để lấy dữ liệu từ API và cập nhật danh sách bookings
    fetchBookings();
  }

  FilterStatus statusBooking = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;

  void fetchBookings() async {
    final url = Uri.parse('$domain/api/v1/booking/list');

    try {
      final response = await http.get(url);
      // print(response.body);
      if (response.statusCode == 200) {
        // Chuyển đổi JSON thành danh sách Booking và cập nhật state
        setState(() {
          schedules = List<Booking>.from(jsonDecode(response.body)['data']
              .map((booking) => Booking.fromJson(booking)));
        });
      } else {
        // Xử lý khi có lỗi từ API
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý khi có lỗi kết nối
      print('Error: $e');
    }
    //  print('schedule: $schedules');
    print('booking length from api: ${schedules.length}');
  }

  void reloadBookings() async {
    fetchBookings();
    setState(() {
      // Update state để rebuild trang
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filterSchedules = schedules.where((var schedule) {
      FilterStatus scheduleStatus;
      switch (schedule.statusBooking) {
        case 'upcoming':
          scheduleStatus = FilterStatus.upcoming;
          break;
        case 'complete':
          scheduleStatus = FilterStatus.complete;
          break;
        case 'cancel':
          scheduleStatus = FilterStatus.cancel;
          break;
        default:
          scheduleStatus = FilterStatus
              .upcoming; // Xác định trạng thái mặc định nếu không khớp
      }
      return scheduleStatus == statusBooking;
    }).toList();

    print('fillerschedule: ${filterSchedules.length}');
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Appointment Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // this is  the filter tabs
                        for (FilterStatus filterStatus in FilterStatus.values)
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.upcoming) {
                                  statusBooking = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.complete) {
                                  statusBooking = FilterStatus.complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.cancel) {
                                  statusBooking = FilterStatus.cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(child: Text(filterStatus.name)),
                          ))
                      ]),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      statusBooking.name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: filterSchedules.length,
                    itemBuilder: ((context, index) {
                      Booking _schedule = filterSchedules[index];
                      print('_schedule id: ${_schedule.id}');

                      bool isLastElement = filterSchedules.length + 1 == index;
                      return Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: !isLastElement
                              ? const EdgeInsets.only(bottom: 20)
                              : EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 34.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(13)),
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors
                                                .blue, // Update with your color logic
                                          ),
                                          child: _schedule.doctors?.imagePath !=
                                                  null
                                              ? Image.network(
                                                  "$domain/${_schedule.doctors?.imagePath}",
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.userDoctor,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              _schedule.doctors!.fullName,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'Spectial: ${_schedule.doctors!.spectiality}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text('Id: ${_schedule.id}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                        Container(
                                          height: 20,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 227, 124, 15),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _schedule.statusBooking,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ScheduleCard(booking: _schedule),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (_schedule.statusBooking == 'upcoming' ||
                                        _schedule.statusBooking == 'pending')
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            // Gọi hàm để hiển thị hộp thoại xác nhận
                                            showCancelConfirmationDialog(
                                                context, _schedule.id);
                                          },
                                          // onPressed: () async {
                                          //   // Gọi API để cancel booking khi nút "Cancel" được nhấn
                                          //   bool success =
                                          //       await ApiBooking.cancelBooking(
                                          //           _schedule.id);

                                          //   if (success) {
                                          //     // Xoá booking thành công, bạn có thể thực hiện các hành động cần thiết
                                          //     // (ví dụ: cập nhật UI, hiển thị thông báo, vv.)
                                          //     print(
                                          //         'Booking canceled successfully.');
                                          //     // Navigator.of(context).pushNamed(
                                          //     //   '/appointment_page',
                                          //     // );
                                          //        reloadBookings();
                                          //   } else {
                                          //     // Xử lý khi cancel booking không thành công
                                          //     print(
                                          //         'Failed to cancel booking.');
                                          //   }
                                          // },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 1, 78, 141),
                                            ),
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    if (_schedule.statusBooking == 'upcoming' ||
                                        _schedule.statusBooking == 'pending')
                                      Expanded(
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                Color.fromARGB(255, 1, 78, 141),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'Reschedule',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    }))),
          ]),
    ));
  }

  Future<void> showCancelConfirmationDialog(
      BuildContext context, int bookingId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Click ngoài không đóng hộp thoại
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận hủy đặt hẹn'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn muốn hủy đặt hẹn này không?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Huỷ'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
            ),
            TextButton(
              child: Text('Xác nhận'),
              onPressed: () async {
                // Gọi hàm để hủy đặt hẹn
                bool success = await ApiBooking.cancelBooking(bookingId);

                if (success) {
                  // Xoá booking thành công, bạn có thể thực hiện các hành động cần thiết
                  // (ví dụ: cập nhật UI, hiển thị thông báo, vv.)
                  print('Booking canceled successfully.');
                  // Navigator.of(context).pushNamed(
                  //   '/appointment_page',
                  // );
                  reloadBookings();
                  showDeleteSuccessSnackbar(
                      context); // Hiển thị thông báo thành công
                } else {
                  // Xử lý khi cancel booking không thành công
                  print('Failed to cancel booking.');
                }
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã hủy đặt hẹn thành công!'),
        duration: Duration(seconds: 2), // Thời gian hiển thị của snackbar
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final Booking booking;
  const ScheduleCard({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.access_alarm,
            color: Color.fromARGB(255, 1, 78, 141),
            size: 20,
          ),
          Flexible(
              child: Text(
            booking.appointmentTime,
            style: TextStyle(
              color: Color.fromARGB(255, 1, 78, 141),
            ),
          )),
          SizedBox(
            width: 40,
          ),
          Icon(
            Icons.calendar_today,
            color: Color.fromARGB(255, 1, 78, 141),
            size: 15,
          ),
          Text(
            booking.appointmentDate,
            style: TextStyle(color: Color.fromARGB(255, 1, 78, 141)),
          ),
        ],
      ),
    );
  }
}
