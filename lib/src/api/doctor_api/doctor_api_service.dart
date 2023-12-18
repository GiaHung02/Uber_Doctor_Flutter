import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart';

const String domain = "http://192.168.1.63";

class DoctorService {
  var data = <String, dynamic>{};
  List<Doctor> results = [];
  var futureProfileDoctor = Rxn<Future<Doctor>>();
  // var data = <String, dynamic>{};
  // Doctor result;
  // String urlGetDoctorByID = '$domain/api/v1/doctor/list';
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController bankingAccount = TextEditingController();
  final TextEditingController imagePath = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController accepted = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController spectiality = TextEditingController();
  final TextEditingController rate = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController exp = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController wallet = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<List<Doctor>> getDoctors({String? query}) async {
    var url = Uri.parse('$domain:8080/api/v1/doctor/list');
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
    // final response = await http
    //     .get(Uri.parse('http://172.31.98.105:8080/api/v1/doctor/list'));
    // print(response.body);
    // if (response.statusCode == 200) {
    //   final dynamic data = json.decode(response.body);

    //   if (data is List) {
    //     return data.map((json) => Doctor.fromJson(json)).toList();
    //   } else if (data is Map<String, dynamic> && data.containsKey('doctors')) {
    //     // Assuming 'doctors' is the key containing the list of doctors in the Map
    //     final List<dynamic> doctorsData = data['doctors'];
    //     return doctorsData.map((json) => Doctor.fromJson(json)).toList();
    //   } else {
    //     throw Exception('Invalid API response format');
    //   }
    // } else {
    //   throw Exception('Failed to load doctors');
    // }
  }

  static Future<Doctor> getDoctorByID(int doctorId) async {
    try {
      final Uri uri = Uri.parse('$domain:8080/api/v1/doctor/$doctorId');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return Doctor.fromJson(json.decode(response.body));
      } else {
        throw 'Failed to load doctor details: ${response.statusCode}';
      }
    } catch (error) {
      print('Error fetching doctor details: $error');
      throw error;
    }
  }

  static Future<void> updateDoctor(Doctor doctor, BuildContext context) async {
    try {
      final Uri apiUrl =
          Uri.parse('$domain:8080/api/v1/doctor/update/${doctor.id}');
      print(apiUrl);
      print(doctor.toJson());
      final response = await http.put(
        apiUrl,
        // headers: {'Content-Type': 'application/json'},
        body: jsonEncode(doctor.toJson()),
      );

      if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Doctor successfully updated',
        );
        // Handle the case where the server returns a 200 OK
        print('Doctor successfully updated');
      } else {
        // Handle the case where the server does not return a 200 OK
        print(
            'Failed to update doctor details. Response body: ${response.body}');
      }
    } catch (error) {
      // Handle any errors during the update process
      print('Error updating doctor details: $error');
      throw error; // Rethrow the error to propagate it
    }
  }
}
