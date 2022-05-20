import 'package:flutter/material.dart';
import 'package:qr_new/core/constants/route_constants.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/core/widgets/error_view.dart';
import 'package:qr_new/feature/auth/login/view/login_view.dart';
import 'package:qr_new/feature/auth/onboard/view/onboard_view.dart';
import 'package:qr_new/feature/auth/register/view/register_view.dart';
import 'package:qr_new/feature/home/model/lesson.dart';
import 'package:qr_new/feature/home/view/home_view.dart';
import 'package:qr_new/feature/scan/view/scan_view.dart';

class AppRoute {
  static final NavigationService _navigationService =
      NavigationService.instance;

  static Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstants.onboard:
        return _navigationService.materialPageRoute(widget: OnboardView());

      case RouteConstants.register:
        return _navigationService.materialPageRoute(widget: RegisterView());

      case RouteConstants.login:
        return _navigationService.materialPageRoute(widget: LoginView());

      case RouteConstants.home:
        return _navigationService.materialPageRoute(
            widget: HomeView(email: routeSettings.arguments as String));
      case RouteConstants.scan:
        return _navigationService.materialPageRoute(
            widget: ScanView(
          lesson: routeSettings.arguments as Lesson,
        ));

      case RouteConstants.error:
        return _navigationService.materialPageRoute(
            widget: NotFoundPage(message: routeSettings.arguments as String));

      default:
        return _navigationService.materialPageRoute(
            widget: const NotFoundPage(message: 'Sayfa Bulunamadı.'));
    }
  }
}
