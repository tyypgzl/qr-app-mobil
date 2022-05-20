import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_new/core/constants/app_constants.dart';
import 'package:qr_new/core/constants/route_constants.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';
import 'package:qr_new/route/route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'feature/shared/utils/api_const.dart';

void main() {
  _initialize();
  runApp(const Init());
}

void _initialize() {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: AppConstants.instance.supabaseURL,
    anonKey: AppConstants.instance.supabaseAnonKey,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  GetIt getIt = GetIt.instance;

  getIt.registerSingleton<SupabaseClient>(SupabaseClient(
      ApiConstants.instance.supabaseURL, ApiConstants.instance.supabaseKEY));
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConstants.onboard,
      onGenerateRoute: AppRoute.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      title: AppConstants.instance.appTitle,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.ralewayTextTheme(),
        navigationBarTheme: NavigationBarThemeData(
          elevation: 1.5,
          backgroundColor: AppColors.instance.grey,
          indicatorColor: AppColors.instance.orange,
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
            iconTheme: IconThemeData(color: AppColors.instance.black)),
      ),
    );
  }
}
