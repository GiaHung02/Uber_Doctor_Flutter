import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAuthProvider with ChangeNotifier {
  String? _token;
  String? _role;
  String? _id;

  String? get token => _token;
  String? get role => _role;
  String? get id => _id;

  Future<void> setTokenAndRole(String? token, String? role, String? id) async {
    _token = token;
    _role = role;
    _id = id;
    notifyListeners();

    // Lưu token và role vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token ?? '');
    prefs.setString('role', role ?? '');
    prefs.setString('id', role ?? '');
  }

  Future<void> loadTokenAndRole() async {
    // Load token và role từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _role = prefs.getString('role');
    _id = prefs.getString('id');

    notifyListeners();
  }

  void logout() {
    _token = null;
    _role = null;
    _id = null;

    notifyListeners();

    // Xóa token và role từ SharedPreferences khi đăng xuất
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('token');
      prefs.remove('role');
      prefs.remove('id');
    });
  }
}
