import 'dart:math';

import 'package:flutter/material.dart';

class RandomColor {
  List colors = [
    Colors.red,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.cyan,
    Colors.indigo,
    Colors.pink,
    Colors.teal
  ];

  randomColor() {
    return colors[Random().nextInt(8)];
  }
}
