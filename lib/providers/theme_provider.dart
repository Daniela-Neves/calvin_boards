import 'package:eletroCar/theme/app_theme_data.dart';

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _appThemeData;
  late bool _isDark;

  ThemeProvider() {
    _appThemeData = AppThemeData().materialThemeLight;
    _isDark = false;
  }

  void toggleDark() {
    if (_isDark) {
      _appThemeData = AppThemeData().materialThemeLight;
    } else {
      _appThemeData = AppThemeData().materialThemeDark;
    }
    _isDark = !_isDark;

    notifyListeners();
  }

  ThemeData getTheme() => _appThemeData;

  bool isDark() => _isDark;
}
