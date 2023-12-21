import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uber_doctor_flutter/src/model/booking.dart';

import 'package:uber_doctor_flutter/src/model/pathologycal.dart';

///////// FIX PORT /////////

/// API SEARCH SYMPTOMS AND RECOMMEND DOCTORS ///
const String domain = "http://172.16.0.57:8080";

class FetchSymptomList {
  var data = <String, dynamic>{};
  List<Symptomslist> results = [];
  String urlList = '$domain/api/v1/pathologycal/list';

  Future<List<Symptomslist>> getsymptomList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        if (data.containsKey('data') && data['data'] is List) {
          results = (data['data'] as List)
              .map((e) => Symptomslist.fromJson(e))
              .toList();
          if (query != null && query.isNotEmpty) {
            results = results
                .where((element) =>
                    element.symptoms
                            ?.toLowerCase()
                            .contains(query.toLowerCase()) ==
                        true ||
                    element.reason
                            ?.toLowerCase()
                            .contains(query.toLowerCase()) ==
                        true)
                .toList();
          }
          return results;
        } else {
          throw FetchDataException('Invalid data format');
        }
      } else {
        print('fetch error');
        throw FetchDataException('Failed to fetch data');
      }
    } on Exception catch (e) {
      print('error: $e');
      throw FetchDataException('An error occurred: $e');
    }
  }
}

class FetchDoctorList {
  var data = <String, dynamic>{};
  List<Doctor> results = [];
  String urlList = '$domain/api/v1/doctor/list';

  Future<List<Doctor>> getDoctorList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        if (data.containsKey('data') && data['data'] is List) {
          results =
              (data['data'] as List).map((e) => Doctor.fromJson(e)).toList();
          if (query != null && query.isNotEmpty) {
            results = results
                .where((element) =>
                    element.fullName
                            ?.toLowerCase()
                            .contains(query.toLowerCase()) ==
                        true ||
                    element.spectiality
                            ?.toLowerCase()
                            .contains(query.toLowerCase()) ==
                        true ||
                    element.imagePath!.contains(query.toLowerCase()))
                .toList();
          }
          return results;
        } else {
          throw FetchDataException('Invalid data format');
        }
      } else {
        print('fetch error');
        throw FetchDataException('Failed to fetch data');
      }
    } on Exception catch (e) {
      print('error: $e');
      throw FetchDataException('An error occurred: $e');
    }
  }
}

class BookingApiService {
  var data = <String, dynamic>{};
  List<Booking> results = [];
  String urlList = '$domain/api/v1/booking/list';

  Future<List<Booking>> getBookingsWithPatientName({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        if (data.containsKey('data') && data['data'] is List) {
          results = (data['data'] as List)
              .map((e) {
                var booking = Booking.fromJson(e);
                if (query != null && query.isNotEmpty) {
                  var patientFullName =
                      booking.patients?.fullName?.toLowerCase() ?? '';
                  var patientPhone = booking.patients?.phoneNumber ?? 0;

                  if (patientFullName.contains(query.toLowerCase()) ||
                      patientPhone.toString().contains(query)) {
                    return booking;
                  } else {
                    return null;
                  }
                } else {
                  return booking;
                }
              })
              .where((booking) => booking != null)
              .toList()
              .cast<Booking>();

          return results;
        } else {
          throw FetchDataException('Invalid data format');
        }
      } else {
        print('fetch error');
        throw FetchDataException('Failed to fetch data');
      }
    } on Exception catch (e) {
      print('error: $e');
      throw FetchDataException('An error occurred: $e');
    }
  }
}

class ApiBooking {
  static final String baseUrl = '$domain/api/v1';

  static Future<List<Booking>> getBookingList() async {
    final url =
        Uri.parse('$baseUrl/booking/list'); // Điều chỉnh endpoint API của bạn

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Chuyển đổi dữ liệu từ JSON sang List<Booking>
        List<dynamic> data = json.decode(response.body)['data'];
        List<Booking> bookings =
            data.map((item) => Booking.fromJson(item)).toList();

        return bookings;
      } else {
        // Xử lý lỗi khi gọi API
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Xử lý lỗi kết nối
      print('Error: $e');
      return [];
    }
  }

  static Future<bool> cancelBooking(int bookingId) async {
    final url = Uri.parse('$baseUrl/booking/delete/$bookingId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // Booking đã được xoá thành công
        return true;
      } else {
        // Xử lý lỗi khi gọi API
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Xử lý lỗi kết nối
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> updateStatusToCancel(Booking booking) async {
    final url = Uri.parse('$baseUrl/booking/update/${booking.id}');
    Booking requestData = booking;
    booking.statusBooking = 'cancel';
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Booking update data:$requestData');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Cập nhật trạng thái thành công
           print('>>>>>>>>>>>>> cap nhat StatusBooking = cancel thanh cong');
        return true;
      } else {
        // Xử lý lỗi khi gọi API
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Xử lý lỗi kết nối
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> updateStatusToConfirmed(Booking booking) async {
    final url = Uri.parse('$baseUrl/booking/update/${booking.id}');
    Booking requestData = booking;
    booking.statusBooking = 'confirmed';
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Booking update data:$requestData');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Cập nhật trạng thái thành công
         print('>>>>>>>>>>>>> cap nhat StatusBooking = confirmed thanh cong');
        return true;
      } else {
        // Xử lý lỗi khi gọi API
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Xử lý lỗi kết nối
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> updateStatusToUpcoming(Booking booking) async {
    final url = Uri.parse('$baseUrl/booking/update/${booking.id}');
    Booking requestData = booking;
    booking.statusBooking = 'upcoming';
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Booking update data:$requestData');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Cập nhật trạng thái thành công
           print('>>>>>>>>>>>>> cap nhat StatusBooking = upcoming thanh cong');
        return true;
      } else {
        // Xử lý lỗi khi gọi API
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Xử lý lỗi kết nối
      print('Error: $e');
      return false;
    }
  }
}

class FetchDataException implements Exception {
  final String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return "Exception: $message";
  }
}
