import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uber_doctor_flutter/src/constants/url_api.dart';
import 'package:uber_doctor_flutter/src/model/api_response.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onToggleShowPassword() => showPassword.value = !showPassword.value;

  Future<bool> loginPatient(String phone) async {
    isLoading.value = true;
    try {
      var myUrl = loginPatientAPI + phone;
      var response = await http.get(
        Uri.parse(myUrl),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);

      if (apiResponse.status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginDoctor(String phone) async {
    isLoading.value = true;
    try {
      var myUrl = loginDoctorAPI + phone;

      var response = await http.get(
        Uri.parse(myUrl),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);

      if (apiResponse.status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
