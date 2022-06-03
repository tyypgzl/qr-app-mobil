import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_new/config/theme/interface_app_theme.dart';
import 'package:qr_new/core/enum/theme_enum.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';

class DarkTheme implements IAppTheme {
  static DarkTheme? _instance;
  static DarkTheme get mode => _instance ??= DarkTheme._();
  DarkTheme._();
  @override
  ThemeData get themeData => ThemeData.dark().copyWith(
        textTheme: GoogleFonts.ralewayTextTheme(),
        backgroundColor: AppColors.instance.black,
      );

  @override
  ThemeMode get themeMode => ThemeMode.dark;

  @override
  ThemeModeEnum get themeModeEnum => ThemeModeEnum.dark;
}
