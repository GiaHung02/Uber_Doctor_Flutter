import 'package:flutter/material.dart';

class VisitProvider with ChangeNotifier {
  int _visit = 0;

  int get visit => _visit;

  void updateVisit(int newValue) {
    _visit = newValue;
    notifyListeners();
  }
}