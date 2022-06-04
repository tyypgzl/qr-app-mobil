import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_new/core/base/base_view_model.dart';
import 'package:qr_new/core/constants/route_constants.dart';
import 'package:qr_new/core/enum/page_state_enum.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/core/supabase/supabase_auth_service.dart';
import 'package:qr_new/core/utils/show_snack_bar.dart';
import 'package:qr_new/feature/auth/register/model/student.dart';
import 'package:qr_new/feature/scan/model/user.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';
import 'package:qr_new/feature/shared/utils/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScanViewModel extends BaseViewModel {
  final String email;
  final String lesson;
  final client = GetIt.instance<SupabaseClient>();

  SupabaseAuthService supabaseAuthService = SupabaseAuthService();

  late Student student;

  ScanViewModel({required this.email, required this.lesson}) {
    isScanned = false;
  }
  bool isSuccess = false;

  bool isScanned = false;

  String? _barcode;

  String? get barcode => _barcode;

  set barcode(String? value) {
    _barcode = value;
    notifyListeners();
  }

  void onRead(String? barcodeString) {
    barcode = barcodeString;
    isScanned = true;
  }

  @override
  Future<bool> customBack() async {
    navigationService.pop();
    return Future.value(true);
  }

  Future<void> logoutButtonOnTap() async {
    await supabaseAuthService.signOut();
    NavigationService.instance
        .pushNamedAndRemoveUntil(routePath: RouteConstants.onboard);
  }

  Future<void> joinLessonButonOnTap(BuildContext context) async {
    state = PageState.LOADING;
    log(email);
    var response =
        await client.from('user').select().eq('email', email).execute();
    var list = response.data as List;
    var userList = list.map((e) => UserModel.fromJson(e)).toList();
    var user = userList.first;

    Student student = Student(
        name: user.name,
        surname: user.surname,
        email: email,
        lesson: lesson,
        uuid: barcode);

    var studentResponse =
        await client.from('student').insert(student.toJson()).execute();

    state = PageState.LOADED;
    if ((response.status ?? nullInt) >= 200 &&
        (response.status ?? nullInt) <= 209) {
      if ((studentResponse.status ?? nullInt) >= 200 &&
          (studentResponse.status ?? nullInt) <= 209) {
        isSuccess = true;
        showSnackBar(
            context: context,
            content: Text(
              'Ders yoklamasına katıldınız.',
              style: TextStyle(color: AppColors.instance.black),
            ),
            isError: false);
        await Future.delayed(const Duration(seconds: 2));
        await NavigationService.instance
            .pushNamed(routePath: RouteConstants.home, args: email);
      }
    } else {
      showSnackBar(
          context: context,
          content: Text(
            'Dersler Çekil',
            style: TextStyle(color: AppColors.instance.black),
          ),
          isError: false);
    }
  }

  @override
  Future<void> init() async {
    log('Scan:$email');
    var status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      final permisson = await Permission.camera.request();
      log(permisson.name);
    }
  }

  @override
  NavigationService get navigationService => NavigationService.instance;
}
