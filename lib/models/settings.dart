import 'package:flutter/material.dart';

class Settings {
  static double fontCoef = 1;
  static String? listItem = 'x1';
  static Color fontColor = Colors.black;

  static void setFontCoef(String? value) {
    switch (value) {
      case 'x1':
        fontCoef = 1;
        break;

      case 'x1.25':
        fontCoef = 1.25;
        break;

      case 'x1.5':
        fontCoef = 1.5;
        break;
    }
  }
}