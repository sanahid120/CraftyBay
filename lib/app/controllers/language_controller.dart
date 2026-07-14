import 'package:shared_preferences/shared_preferences.dart';

class LanguageController {
  static const String _languageKey = "selected_language";
  
  static const String english = "en";
  static const String bangla = "bn";

  static const Map<String, String> languageMap = {
    english: "English",
    bangla: "বাংলা",
  };

  Future<void> saveCurrentLanguage(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, lang);
  }

  Future<String> getCurrentLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? english;
  }
}
