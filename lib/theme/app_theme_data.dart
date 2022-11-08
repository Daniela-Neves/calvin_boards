import 'package:flutter/material.dart';

class AppThemeData {
  final BorderRadius borderRadius = BorderRadius.circular(8);

  ThemeData get materialThemeLight {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xff004f88),
      ),
    );
  }

  ThemeData get materialThemeDark {
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff004f88)),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff004f88), brightness: Brightness.dark),
    );
  }
}
