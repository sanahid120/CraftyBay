import 'package:flutter/material.dart';

import '../app_theme.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = AppTheme.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void changeTheme(ThemeData themeData) {
    _currentTheme = themeData;
    notifyListeners();
  }
}