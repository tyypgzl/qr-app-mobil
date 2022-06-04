import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:native_notify/native_notify.dart';
import 'package:qr_new/config/theme/dark_theme.dart';
import 'package:qr_new/core/constants/app_constants.dart';
import 'package:qr_new/core/constants/route_constants.dart';
import 'package:qr_new/core/enum/theme_enum.dart';
import 'package:qr_new/core/language/language_manager.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/core/theme/theme_manager.dart';
import 'package:provider/provider.dart' as provider;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/route/route.dart';
import 'config/theme/light_theme.dart';
import 'feature/shared/utils/api_const.dart';

GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initialize();
  await _hiveLangAndThemeInit();
  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: LanguageManager.instance.path,
      fallbackLocale: LanguageManager.instance.trLocale,
      startLocale: LanguageManager.instance.enLocale,
      child: const Init(),
    ),
  );
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return provider.ChangeNotifierProvider<ThemeManager>.value(
      value: ThemeManager.instance,
      child: provider.Consumer<ThemeManager>(
        builder: (context, theme, child) => MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          initialRoute: RouteConstants.onboard,
          onGenerateRoute: AppRoute.generateRoute,
          scaffoldMessengerKey: scaffoldMessengerKey,
          navigatorKey: NavigationService.instance.navigatorKey,
          title: AppConstants.instance.appTitle,
          theme: theme.appTheme.themeData,
          themeMode: theme.appTheme.themeMode,
          darkTheme: DarkTheme.mode.themeData,
        ),
      ),
    );
  }
}

Future<void> _initialize() async {
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();

  NativeNotify.initialize(891, 'Nv1K0Mch93VcsRtwyTZCZ7', null, null);

  await Supabase.initialize(
    url: APIconst.supabaseURL,
    anonKey: APIconst.supabaseURL,
    localStorage: const HiveLocalStorage(),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  GetIt getIt = GetIt.instance;

  getIt.registerSingleton<SupabaseClient>(
    SupabaseClient(APIconst.supabaseURL, APIconst.supabaseKEY),
  );
}

Future<void> _hiveLangAndThemeInit() async {
  bool isThemeBoxExist = await Hive.boxExists('theme');

  if (isThemeBoxExist) {
    var box = await Hive.openBox<String>('theme');
    var data = box.get(ThemeModeEnum.themeMode.name);
    if (data != null) {
      if (data == ThemeModeEnum.dark.name) {
        ThemeManager.instance.changeTheme(DarkTheme.mode);
      } else {
        ThemeManager.instance.changeTheme(LightTheme.mode);
      }
    }
  }
}
