
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController {
  static const String _themeKey = "selected_theme";

  static const String light = "light";
  static const String dark = "dark";


  static Future<void> saveCurrentTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  static Future<String> getCurrentTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? light;
  }
}