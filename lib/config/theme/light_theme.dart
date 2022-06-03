import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_new/config/theme/interface_app_theme.dart';
import 'package:qr_new/core/enum/theme_enum.dart';

import '../../feature/shared/utils/app_colors.dart';

class LightTheme implements IAppTheme {
  static LightTheme? _instance;
  static LightTheme get mode => _instance ??= LightTheme._();
  LightTheme._();
  @override
  ThemeData get themeData => ThemeData.light().copyWith(
        backgroundColor: AppColors.instance.white,
        textTheme: GoogleFonts.ralewayTextTheme(),
        navigationBarTheme: NavigationBarThemeData(
          elevation: 1.5,
          backgroundColor: AppColors.instance.grey,
          indicatorColor: AppColors.instance.orangeAccent,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: AppColors.instance.black),
          ),
          iconTheme: MaterialStateProperty.all(
            IconThemeData(color: AppColors.instance.black),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.instance.orangeAccent,
          foregroundColor: AppColors.instance.black,
          centerTitle: true,
          elevation: 0.9,
          iconTheme: IconThemeData(
            color: AppColors.instance.black,
          ),
        ),
      );

  @override
  ThemeMode get themeMode => ThemeMode.light;

  @override
  ThemeModeEnum get themeModeEnum => ThemeModeEnum.light;
}
