import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_new/core/base/base_view_model.dart';
import 'package:qr_new/core/constants/route_constants.dart';
import 'package:qr_new/core/crypto/crypto_manager.dart';
import 'package:qr_new/core/enum/page_state_enum.dart';
import 'package:qr_new/core/mixin/validation_mixin.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/core/supabase/supabase_auth_service.dart';
import 'package:qr_new/core/utils/show_snack_bar.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';
import 'package:qr_new/feature/shared/widgets/auth_text_field.dart';
import 'package:qr_new/feature/shared/widgets/custom_button.dart';

class LoginViewModel extends BaseViewModel with ValidationMixin {
  SupabaseAuthService supaBaseAuthManager = SupabaseAuthService();
  @override
  Future<bool> customBack() {
    navigationService.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 1));
  }

  @override
  NavigationService get navigationService => NavigationService.instance;

  String? email;
  String? password;

  final formGlobalKey = GlobalKey<FormState>();
  final forgotPasswordKey = GlobalKey<FormState>();

  String? forgotMail;

  bool isPasswordVisible = true;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> loginOnTap(BuildContext context) async {
    state = PageState.LOADING;
    FocusManager.instance.primaryFocus?.nextFocus();

    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();

      log(email ?? 'Login EMail gelmedi');
      var encryptedPassword = CryptoManager.encryptData(data: password!);

      var response = await supaBaseAuthManager.login(
          email: email, password: encryptedPassword);

      if (response.statusCode == 200) {
        navigationService.pushNamedAndRemoveUntil(
            routePath: RouteConstants.home, args: email ?? '');
      } else {
        showSnackBar(
            context: context,
            content: Text("Error: ${response.error!.message}"),
            isError: true);
      }
    }
    state = PageState.LOADED;
  }

  String? mailValidation(String? value) {
    if (email != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir e-posta adresi giriniz.';
      }
    } else {
      return 'E-posta alanı boş geçilemez.';
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
      return 'Şifre alanı boş geçilemez.';
    }
  }

  String? forgotMailValidation(String? value) {
    if (forgotMail != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir e-posta adresi giriniz.';
      }
    } else {
      return 'E-posta alanı boş geçilemez.';
    }
  }

  void registerOnTap() {
    navigationService.pushNamedAndRemoveUntil(
        routePath: RouteConstants.register);
  }

  Future<void> forgotPasswordOnTap(BuildContext context) async {
    await _forgotPasswordDialog(context);
  }

  Future<void> _forgotPasswordDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Şifremi Unuttum'),
          content: Form(
            key: forgotPasswordKey,
            child: AuthTextField(
              padding: EdgeInsets.zero,
              keyboardType: TextInputType.emailAddress,
              labelText: const Text('E-posta').tr(),
              onChanged: (String? value) {
                forgotMail = value;
                notifyListeners();
                return forgotMail;
              },
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * .08),
              validator: forgotMailValidation,
            ),
          ),
          alignment: Alignment.center,
          actionsPadding: const EdgeInsets.only(bottom: 12),
          contentPadding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          actions: [
            CustomButton(
              title: const Text(
                'Gönder',
              ),
              backgroundColor: AppColors.instance.pink,
              foregroundColor: AppColors.instance.black,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .06,
              onTap: () async {
                if (forgotPasswordKey.currentState!.validate()) {
                  forgotPasswordKey.currentState!.save();
                  FocusManager.instance.primaryFocus?.nextFocus();
                  var response =
                      await supaBaseAuthManager.forgotPassword(forgotMail!);
                  navigationService.pop();

                  if (response.statusCode == 200) {
                    showSnackBar(
                      context: context,
                      content: Text(
                        '''Şifre sıfırlama işlemi tamamlandı.''',
                        style: TextStyle(color: AppColors.instance.black),
                      ),
                      isError: false,
                    );
                  } else {
                    showSnackBar(
                      context: context,
                      content: const Text('''Bir hata oluştu.'''),
                      isError: false,
                    );
                    log('Error: ${response.error!.message} Code: ${response.error!.statusCode}');
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
