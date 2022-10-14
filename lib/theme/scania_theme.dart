import 'package:flutter/material.dart';

class ScaniaTheme {
  MaterialColor primarySwatch = Colors.indigo;
  final buttonTheme = const ButtonThemeData(buttonColor: Colors.indigo);
  final toggleTheme = const ToggleButtonsThemeData(
      selectedColor: Color.fromARGB(255, 83, 158, 99));

  ThemeData get scaniaTheme {
    return ThemeData(
        primaryColor: primarySwatch,
        buttonTheme: buttonTheme,
        toggleButtonsTheme: toggleTheme);
  }
}
