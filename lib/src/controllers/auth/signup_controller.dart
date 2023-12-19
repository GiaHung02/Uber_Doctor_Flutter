import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:uber_doctor_flutter/src/constants/url_api.dart';
import 'package:uber_doctor_flutter/src/model/api_response.dart';
import 'package:uber_doctor_flutter/src/model/register_doctor_model.dart';
import 'package:uber_doctor_flutter/src/model/register_patient_model.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;

  static SignUpController get find => Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  onToggleShowPassword() => showPassword.value = !showPassword.value;

  Future<int> createPatient(RegisterPatientModel user, context) async {
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse(registerPatientAPI),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode(user.toJson()),
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);

      print(apiResponse.status);
      print(apiResponse.data);
      print(apiResponse.message);

      return apiResponse.data.id;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Switch to a different IP or a different WiFi',
      );
      return -1;
    }
  }

  Future<int> createDoctor(RegisterDoctorModel user, context) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse(registerDoctorAPI),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode(user.toJson()),
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      return apiResponse.data.id;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Switch to a different IP or a different WiFi',
      );
      return -1;
    }
  }
}
