import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:uber_doctor_flutter/src/model/booking.dart';

class BookingListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BookingListPageState createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  List<Booking> bookings = [];

  @override
  void initState() {
    super.initState();
    // Gọi hàm để lấy dữ liệu từ API và cập nhật danh sách bookings
    fetchBookings();
  }

  // Hàm để gọi API và cập nhật danh sách bookings
  void fetchBookings() async {
    final url = Uri.parse('$domain/api/v1/booking/list');

    try {
      final response = await http.get(url);
      // print(response.body);
      if (response.statusCode == 200) {
        // Chuyển đổi JSON thành danh sách Booking và cập nhật state
        setState(() {
          bookings = List<Booking>.from(jsonDecode(response.body)['data']
              .map((booking) => Booking.fromJson(booking)));
              
        });
             print(bookings.length);
      } else {
        // Xử lý khi có lỗi từ API
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý khi có lỗi kết nối
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách đặt hẹn'),
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          return BookingCard(booking: bookings[index]);
        },
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;
  BookingCard({required this.booking});
  @override
  Widget build(BuildContext context) {
    return Card(
      // Thiết kế giao diện của mỗi booking card ở đây
      child: ListTile(
        title: Text('Đặt hẹn #${booking.id}'),
        subtitle: Text(
            'Ngày hẹn: ${booking.appointmentDate} - ${booking.appointmentTime}'),
        // Thêm các trường thông tin khác tùy ý
      ),
    );
  }
}
