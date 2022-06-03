import 'dart:developer';

import 'package:flutter/material.dart';

class LanguageManager extends ChangeNotifier {
  static LanguageManager? _instance;

  static LanguageManager get instance => _instance ??= LanguageManager._init();

  LanguageManager._init();

  final path = 'assets/lang';

  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');

  List<Locale> get supportedLocales => [enLocale, trLocale];

  Locale _selectedLocale = const Locale('tr', 'TR');

  Locale get selectedLocale => _selectedLocale;

  set selectedLocale(Locale value) {
    _selectedLocale = value;
    log(value.toLanguageTag());
    notifyListeners();
  }

  void setTurkishLocale() {
    selectedLocale = trLocale;
  }

  void setEnglishLocale() {
    selectedLocale = enLocale;
  }
}
