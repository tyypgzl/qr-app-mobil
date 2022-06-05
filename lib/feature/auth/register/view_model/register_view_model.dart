import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_new/core/base/base_view_model.dart';
import 'package:qr_new/core/constants/route_constants.dart';
import 'package:qr_new/core/crypto/crypto_manager.dart';
import 'package:qr_new/core/enum/page_state_enum.dart';
import 'package:qr_new/core/mixin/validation_mixin.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/core/supabase/supabase_auth_service.dart';
import 'package:qr_new/core/utils/show_snack_bar.dart';
import 'package:qr_new/feature/scan/model/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterViewModel extends BaseViewModel with ValidationMixin {
  final authService = SupabaseAuthService();

  final client = GetIt.instance<SupabaseClient>();

  @override
  NavigationService get navigationService => NavigationService.instance;

  @override
  Future<bool> customBack() {
    NavigationService.instance.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() {
    return Future.delayed(const Duration(milliseconds: 100));
  }

  final formKey = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  String? email;
  String? password;

  bool isPasswordVisible = false;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> registerButtonOnTap(BuildContext context) async {
    state = PageState.LOADING;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var encryptedPassword = CryptoManager.encryptData(data: password!);

      var authResponse = await authService.register(
          email: email!,
          password: encryptedPassword,
          name: firstName,
          surname: lastName);
      var databaseResponse =
          await client.from('user').insert(user.toJson()).execute();

      log('Error${databaseResponse.error?.message ?? ''}Status Code: ${databaseResponse.status}');

      if (authResponse.statusCode == 200) {
        navigationService.pushNamedAndRemoveUntil(
            routePath: RouteConstants.login);
      } else {
        showSnackBar(
            context: context,
            content: Text(
                "Error: ${authResponse.error!.message}  Code: ${authResponse.error!.statusCode}"),
            isError: true);
      }
    }
    state = PageState.LOADED;
  }

  UserModel get user {
    var encryptedPassword = CryptoManager.encryptData(data: password!);

    return UserModel(
        name: firstName ?? '',
        surname: lastName ?? '',
        email: email ?? '',
        password: encryptedPassword,
        uuid: 'uuid');
  }

  void loginButtonOnTap() {
    navigationService.pushNamedAndRemoveUntil(routePath: RouteConstants.login);
  }

  String? nameValidation(String? value) {
    if (firstName != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir ad giriniz.';
      }
    } else {
      return 'Geçerli bir ad giriniz.';
    }
  }

  String? lastNameValidation(String? value) {
    if (lastName != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir soyad giriniz.';
      }
    } else {
      return 'Geçerli bir soyad giriniz.';
    }
  }

  String? mailValidation(String? value) {
    if (email != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir e-posta adresi giriniz.';
      }
    } else {
      return 'Geçerli bir e-posta adresi giriniz.';
    }
  }

  String? passwordValidation(String? value) {
    if (password != null) {
      if (isLowPasswordValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir şifre giriniz.';
      }
    } else {
      return 'Geçerli bir şifre giriniz.';
    }
  }
}
