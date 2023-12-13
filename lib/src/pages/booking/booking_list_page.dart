// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:uber_doctor_flutter/src/api/api_service.dart';
// import 'package:uber_doctor_flutter/src/colors.dart';
// import 'package:uber_doctor_flutter/src/model/booking.dart';

// class FetchDataException implements Exception {
//   final String message;

//   FetchDataException(this.message);

//   @override
//   String toString() {
//     return "Exception: $message";
//   }
// }

// void fetchBookings() {
//   var data = <String, dynamic>{};
//   List<Booking> results = [];
//   String urlList = '$domain/api/v1/booking/list';

//   Future<List<Booking>> getBookingList({String? query}) async {
//     var url = Uri.parse(urlList);
//     try {
//       var response = await http.get(url);

//       if (response.statusCode == 200) {
//         data = json.decode(response.body);
//         if (data.containsKey('data') && data['data'] is List) {
//           results =
//               (data['data'] as List).map((e) => Booking.fromJson(e)).toList();
//           print(results);

//           return results;
//         } else {
//           throw FetchDataException('Invalid data format');
//         }
//       } else {
//         print('fetch error');
//         throw FetchDataException('Failed to fetch data');
//       }
//     } on Exception catch (e) {
//       print('error: $e');
//       throw FetchDataException('An error occurred: $e');
//     }
//   }
// }

// class BookingListPage extends StatefulWidget {
//   @override
//   _BookingListPageState createState() => _BookingListPageState();
// }

// class _BookingListPageState extends State<BookingListPage> {
//   List<Booking> bookings = [];

//   @override
//   void initState() {
//     super.initState();
//     // Gọi hàm để lấy dữ liệu từ API và cập nhật danh sách bookings
//     fetchBookings();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Danh sách đặt hẹn'),
//       ),
//       body: ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           return BookingCard(booking: bookings[index]);
//         },
//       ),
//     );
//   }
// }
// Widget _bookingList() {
//     return FutureBuilder<List<Booking>>(
//       future: fetchBookings.getBookingList(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           var data = snapshot.data;
//           if (data == null || data.isEmpty) {
//             return Center(child: Text('No doctors found'));
//           } else {
//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: data?.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: randomColor(),
//                           child: data?[index].image != null &&
//                                   data[index].image!.isNotEmpty
//                               ? Image.network(data[index].image![0] as String)
//                               : Container(),
//                         ),
//                         title: Text(
//                           '${data?[index].fullName}',
//                           style: TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                         subtitle: Text(
//                           '${data?[index].spectiality}',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         onTap: () {
//                           // _navigateToDoctorDetail(data![index], index);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//         }
//       },
//     );
//   }
// class BookingCard extends StatelessWidget {
//   final Booking booking;

//   BookingCard({required this.booking});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       // Thiết kế giao diện của mỗi booking card ở đây
//       child: ListTile(
//         title: Text('Đặt hẹn #' + booking.id.toString()),
//         subtitle: Text(
//             'Ngày hẹn: ${booking.appointmentDate} - ${booking.appointmentTime}'),
//         // Thêm các trường thông tin khác tùy ý
//       ),
//     );
//   }
// }

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
