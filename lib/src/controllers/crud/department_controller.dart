import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uber_doctor_flutter/src/constants/url_api.dart';
import 'package:uber_doctor_flutter/src/model/api_response.dart';
import 'package:uber_doctor_flutter/src/model/department.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';

class DepartmentController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onToggleShowPassword() => showPassword.value = !showPassword.value;

  Future<List<DepartmentModel>> getDepartment() async {
    isLoading.value = true;
    try {
      var myUrl = GetDepartmentAPI;
      var response = await http.get(
        Uri.parse(myUrl),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
      );

      print(myUrl);

      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      print(apiResponse.status);
      print(apiResponse.data[0]['departmentName']);
      List<DepartmentModel> departments = [];
      if (apiResponse.status == 200) {
        apiResponse.data.forEach((element) {
          DepartmentModel department = DepartmentModel(
            id: element['id'],
            name: element['departmentName'],
          );
          departments.add(department);
        });

        return Future.value(departments);
      } else {
        return Future.value([]);
      }
    } catch (e) {
      print("hass fault");

      return Future.value([]);
    }
  }
}
