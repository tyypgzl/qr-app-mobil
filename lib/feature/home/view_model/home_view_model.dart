import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_new/core/base/base_view_model.dart';
import 'package:qr_new/core/constants/route_constants.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/core/supabase/supabase_auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel._();
  static HomeViewModel? _instance;
  static HomeViewModel get instance => _instance ??= HomeViewModel._();

  SupabaseAuthService supabaseAuthService = SupabaseAuthService();
  final client = GetIt.instance<SupabaseClient>();

  int selectedNavBar = 0;

  void onDestinationSelected(int value) {
    selectedNavBar = value;
    debugPrint(value.toString());
    notifyListeners();
  }

  Future<void> logoutButtonOnTap() async {
    await supabaseAuthService.signOut();
    NavigationService.instance
        .pushNamedAndRemoveUntil(routePath: RouteConstants.onboard);
  }

  @override
  Future<bool> customBack() async {
    navigationService.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() async {}

  @override
  NavigationService get navigationService => NavigationService.instance;
}
