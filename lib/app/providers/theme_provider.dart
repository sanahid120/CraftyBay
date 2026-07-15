import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../controllers/theme_controller.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    ThemeController.getCurrentTheme().then((theme) {
      theme == 'light' ? _currentTheme = AppTheme.lightTheme : _currentTheme = AppTheme.darkTheme;
      notifyListeners();
    });
  }

  ThemeData _currentTheme = AppTheme.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void changeTheme(ThemeData themeData) {
    _currentTheme = themeData;
    themeData == AppTheme.lightTheme ? ThemeController.saveCurrentTheme('light') : ThemeController.saveCurrentTheme('dark');
    notifyListeners();
  }
}