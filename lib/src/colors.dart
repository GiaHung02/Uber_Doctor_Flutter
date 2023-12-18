import 'dart:js';
import 'dart:math';

import 'package:flutter/material.dart';

const Color wcolor= Colors.white;
const Color bcolor= Colors.black;
const Color pcolor= Color(0xFF0C84FF);
// const Color wcolor= Colors.white;
Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context as BuildContext).primaryColor,
      Colors.orange,
      Colors.green,
      Colors.grey,
      Colors.orange,
      Colors.blue,
      Colors.black,
      Colors.red,
      Colors.brown,
      Colors.purple,
      Colors.blue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }