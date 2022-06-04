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
        listTileTheme: ListTileThemeData(
          textColor: AppColors.instance.white,
        ),
        navigationBarTheme: NavigationBarThemeData(
          elevation: 2.5,
          indicatorColor: AppColors.instance.orangeAccent,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: AppColors.instance.white),
          ),
          iconTheme: MaterialStateProperty.all(
            IconThemeData(color: AppColors.instance.black),
          ),
        ),
        appBarTheme: AppBarTheme(
          foregroundColor: AppColors.instance.white,
          centerTitle: true,
          elevation: 1.9,
        ),
        dialogTheme: DialogTheme(
          contentTextStyle: TextStyle(color: AppColors.instance.white),
          titleTextStyle: TextStyle(color: AppColors.instance.white),
        ),
      );

  @override
  ThemeMode get themeMode => ThemeMode.dark;

  @override
  ThemeModeEnum get themeModeEnum => ThemeModeEnum.dark;
}
