import 'package:flutter/material.dart';

class ScaniaTheme {
  Color primarySwatch = const Color(0xFF041E42);
  final buttonTheme = const ButtonThemeData(buttonColor: Color(0xFF041E42));
  final toggleTheme = const ToggleButtonsThemeData(
      selectedColor: Color.fromARGB(255, 83, 158, 99));

  ThemeData get scaniaTheme {
    return ThemeData(
        primaryColor: primarySwatch,
        buttonTheme: buttonTheme,
        toggleButtonsTheme: toggleTheme);
  }
}
