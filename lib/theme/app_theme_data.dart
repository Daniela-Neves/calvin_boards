import 'package:flutter/material.dart';

class AppThemeData {
  final BorderRadius borderRadius = BorderRadius.circular(8);

  ThemeData get materialThemeLight {
    return ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 247, 232, 28),
            background: Colors.white),
        scaffoldBackgroundColor: Colors.white);
  }

  ThemeData get materialThemeDark {
    return ThemeData(
      //appBarTheme: const AppBarTheme(backgroundColor: Color(0xff004f88)),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(brightness: Brightness.dark),
    );
  }
}
