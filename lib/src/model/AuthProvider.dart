import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAuthProvider with ChangeNotifier {
  String? _token;
  String? _role;

  String? get token => _token;
  String? get role => _role;

  Future<void> setTokenAndRole(String? token, String? role) async {
    _token = token;
    _role = role;
    notifyListeners();

    // Lưu token và role vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token ?? '');
    prefs.setString('role', role ?? '');
  }

  Future<void> loadTokenAndRole() async {
    // Load token và role từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _role = prefs.getString('role');
    notifyListeners();
  }

  void logout() {
    _token = null;
    _role = null;
    notifyListeners();

    // Xóa token và role từ SharedPreferences khi đăng xuất
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('token');
      prefs.remove('role');
    });
  }
}