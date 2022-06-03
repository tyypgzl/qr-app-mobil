import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_new/core/base/base_view_model.dart';
import 'package:qr_new/core/cache/hive_manager.dart';
import 'package:qr_new/core/constants/route_constants.dart';
import 'package:qr_new/core/enum/lanuage_enum.dart';
import 'package:qr_new/core/enum/theme_enum.dart';
import 'package:qr_new/core/language/language_manager.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/core/theme/theme_manager.dart';

class SettingsViewModel extends BaseViewModel {
  HiveManager<String> hiveLanguage = HiveManager<String>('language');
  late HiveManager<String> hiveTheme = HiveManager<String>('theme');

  ThemeModeEnum _themeEnum = ThemeModeEnum.light;
  LanguageEnum _languageEnum = LanguageEnum.turkish;

  bool isLightTheme = true;

  @override
  Future<bool> customBack() async {
    navigationService.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() async {
    _languageInit();
    _themeInit();
  }

  Future<void> _languageInit() async {
    await hiveLanguage.createBox();
    bool isLanguageBoxExist = await Hive.boxExists('language');
    if (isLanguageBoxExist) {
      var data = hiveLanguage.getBox(LanguageEnum.languageMode.name);
      if (data != null) {
        if (data == LanguageEnum.english.name) {
          _languageEnum = LanguageEnum.english;
        } else {
          _languageEnum = LanguageEnum.turkish;
        }
        await hiveLanguage.setBox(
            LanguageEnum.languageMode.name, _languageEnum.name);
      }
    }
  }

  Future<void> _themeInit() async {
    await hiveTheme.createBox();
    bool isLanguageBoxExist = await Hive.boxExists('theme');
    if (isLanguageBoxExist) {
      var data = hiveTheme.getBox(ThemeModeEnum.themeMode.name);
      if (data != null) {
        if (data == ThemeModeEnum.dark.name) {
          _themeEnum = ThemeModeEnum.dark;
        } else {
          _themeEnum = ThemeModeEnum.light;
        }
        await hiveTheme.setBox(ThemeModeEnum.themeMode.name, _themeEnum.name);
      }
    }
  }

  @override
  NavigationService get navigationService => NavigationService.instance;

  Future<void> turkishOnTap(
      BuildContext context, LanguageManager languageManager) async {
    languageManager.setTurkishLocale();
    _languageEnum = LanguageEnum.turkish;
    await hiveLanguage.setBox('languageMode', _languageEnum.name);
    notifyListeners();
  }

  Future<void> englishOnTap(
      BuildContext context, LanguageManager languageManager) async {
    languageManager.setEnglishLocale();
    _languageEnum = LanguageEnum.english;
    await hiveLanguage.setBox('languageMode', _languageEnum.name);
    notifyListeners();
  }

  Future<void> darkModeOnTap(
      BuildContext context, ThemeManager themeManager) async {
    themeManager.changeTheme();
    _themeEnum = ThemeModeEnum.dark;
    hiveTheme.setBox(ThemeModeEnum.themeMode.name, ThemeModeEnum.dark.name);
    notifyListeners();
  }

  Future<void> lightModeOnTap(
      BuildContext context, ThemeManager themeManager) async {
    themeManager.changeTheme();

    _themeEnum = ThemeModeEnum.light;
    hiveTheme.setBox(ThemeModeEnum.themeMode.name, ThemeModeEnum.light.name);
    notifyListeners();
  }

  Future<void> aboutOnTap(BuildContext context) async {
    await navigationService.pushNamed(routePath: RouteConstants.about);
  }

  void accountOnTap() {}
}
