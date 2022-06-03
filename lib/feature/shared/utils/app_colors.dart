import 'package:flutter/material.dart';

class AppColors {
  static AppColors? _instance;

  static AppColors get instance => _instance ??= AppColors._init();

  AppColors._init();

  Color orangeAccent = const Color(0xffffc170);
  Color pink = const Color(0xffff636e);
  Color white = const Color(0xfff2f6fc);
  Color black = const Color(0xff000000);
  Color grey = const Color(0xffDDDDDD);
}
