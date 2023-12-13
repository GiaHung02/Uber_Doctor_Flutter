import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uber_doctor_flutter/src/model/doctor.dart';

import 'package:uber_doctor_flutter/src/model/pathologycal.dart';

///////// FIX PORT /////////

/// API SEARCH SYMPTOMS AND RECOMMEND DOCTORS ///
const String domain = "http://172.16.3.113:8080";
class FetchSymptomList {
  var data = <String, dynamic>{};
  List<Symptomslist> results = [];
  String urlList =
      '$domain/api/v1/pathologycal/list';

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
          results = (data['data'] as List).map((e) => Doctor.fromJson(e)).toList();
          if (query != null && query.isNotEmpty) {
            results = results
                .where((element) =>
                    element.fullName?.toLowerCase().contains(query.toLowerCase()) == true ||
                    element.spectiality?.toLowerCase().contains(query.toLowerCase()) == true ||
                    element.image!.contains(query.toLowerCase()))
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


// class FetchBookingList {
//   var data = <String, dynamic>{};
//   List<Doctor> results = [];
//   String urlList = '$domain/api/v1/booking/list';

//   Future<List<Doctor>> getBookingList({String? query}) async {
//     var url = Uri.parse(urlList);
//     try {
//       var response = await http.get(url);
//        print(response.statusCode);
//       if (response.statusCode == 200) {
//         data = json.decode(response.body);
//         if (data.containsKey('data') && data['data'] is List) {
//           results = (data['data'] as List).map((e) => Doctor.fromJson(e)).toList();
//           // if (query != null && query.isNotEmpty) {
//           //   results = results
//           //       .where((element) =>
//           //           element.fullName?.toLowerCase().contains(query.toLowerCase()) == true ||
//           //           element.spectiality?.toLowerCase().contains(query.toLowerCase()) == true ||
//           //           element.image!.contains(query.toLowerCase()))
//           //       .toList();
//           // }
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
class FetchDataException implements Exception {
  final String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return "Exception: $message";
  }
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





