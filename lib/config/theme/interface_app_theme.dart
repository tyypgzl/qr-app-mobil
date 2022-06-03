import 'package:flutter/material.dart';
import 'package:qr_new/core/enum/theme_enum.dart';

abstract class IAppTheme {
  final ThemeData themeData;
  final ThemeMode themeMode;
  final ThemeModeEnum themeModeEnum;

  IAppTheme({
    required this.themeData,
    required this.themeMode,
    required this.themeModeEnum,
  });
}
