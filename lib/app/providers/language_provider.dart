import 'package:flutter/material.dart';
import '../controllers/language_controller.dart';

class LanguageProvider extends ChangeNotifier {
  final LanguageController _languageController = LanguageController();
  
  Locale _currentLocale = const Locale('en');

  final List<Locale> _supportedLocales = [
    const Locale('en'),
    const Locale('bn'),
  ];

  LanguageProvider() {
    _loadSavedLanguage();
  }

  List<Locale> get supportedLocales => _supportedLocales;

  Locale get currentLocale => _currentLocale;

  Future<void> _loadSavedLanguage() async {
    String langCode = await _languageController.getCurrentLanguage();
    _currentLocale = Locale(langCode);
    notifyListeners();
  }

  Future<void> changeLocale(Locale locale) async {
    if (_currentLocale == locale) return;
    
    _currentLocale = locale;
    notifyListeners();
    await _languageController.saveCurrentLanguage(locale.languageCode);
  }
}
