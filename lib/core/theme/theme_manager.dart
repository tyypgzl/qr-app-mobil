import 'package:flutter/material.dart';
import 'package:qr_new/config/theme/light_theme.dart';

import '../../config/theme/interface_app_theme.dart';

class ThemeManager extends ChangeNotifier {
  static ThemeManager? _instance;
  static ThemeManager get instance => _instance ??= ThemeManager._init();

  late IAppTheme appTheme;

  ThemeManager._init() {
    appTheme = LightTheme.mode;
  }

  void changeTheme(IAppTheme theme) {
    appTheme = theme;
    notifyListeners();
  }
}
