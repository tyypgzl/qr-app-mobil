import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/core/constants/app_constants.dart';
import 'package:qr_new/core/language/loacale_key.g.dart';
import 'package:qr_new/feature/auth/login/view_model/login_view_model.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';
import 'package:qr_new/feature/shared/widgets/auth_text_field.dart';
import 'package:qr_new/feature/shared/widgets/custom_button.dart';

class LoginView extends BaseView<LoginViewModel> {
  LoginView({Key? key}) : super(key: key);

  @override
  LoginViewModel get homeViewModel => LoginViewModel();

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? body(BuildContext context, LoginViewModel viewModel) {
    return Form(
      key: viewModel.formGlobalKey,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -230,
            left: -130,
            child: Transform.rotate(
              angle: 699.3,
              child: SvgPicture.asset(
                AppConstants.instance.textSvgPath,
                color: AppColors.instance.orangeAccent,
                width: 600,
              ),
            ),
          ),

          //Sol Alt
          Positioned(
            bottom: -(screenSize.height * .47),
            left: -(screenSize.width * .41),
            child: SizedBox(
              width: 325,
              child: Image.asset(
                AppConstants.instance.orangePath,
                color: AppColors.instance.orangeAccent,
              ),
            ),
          ),
          //Sağ Alt
          Positioned(
            bottom: -(screenSize.height * .29),
            right: -(screenSize.width * .32),
            child: SizedBox(
              width: 250,
              child: Image.asset(
                AppConstants.instance.orangePath,
                color: AppColors.instance.orangeAccent,
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: screenSize.height * .1),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    LocaleKeys.auth_login_login,
                    style: TextStyle(
                        color: AppColors.instance.black,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  ).tr(),
                ),
              ),
              SizedBox(height: screenSize.height * .05),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenSize.height * .5,
                  decoration: BoxDecoration(
                    color: AppColors.instance.orangeAccent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthTextField(
                        validator: viewModel.mailValidation,
                        onChanged: (value) => viewModel.email = value,
                        labelText: const Text(LocaleKeys.auth_login_mail).tr(),
                        keyboardType: TextInputType.emailAddress,
                        size: Size(
                            screenSize.width * .97, screenSize.height * .10),
                      ),
                      AuthTextField(
                        validator: viewModel.passwordValidation,
                        onChanged: (value) => viewModel.password = value,
                        labelText:
                            const Text(LocaleKeys.auth_login_password).tr(),
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        size: Size(
                            screenSize.width * .97, screenSize.height * .10),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: TextButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            onPressed: () =>
                                viewModel.forgotPasswordOnTap(context),
                            child: Text(
                              LocaleKeys.auth_login_forgotPassword,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.instance.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ),
                      ),
                      CustomButton(
                        onTap: () => viewModel.loginOnTap(context),
                        backgroundColor: AppColors.instance.pink,
                        foregroundColor: AppColors.instance.white,
                        title: const Text(
                          LocaleKeys.auth_login_login,
                        ).tr(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(LocaleKeys.auth_login_dontHaveAccount)
                              .tr(),
                          TextButton(
                            onPressed: viewModel.registerOnTap,
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.instance.black),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.zero),
                            ),
                            child: const Text(LocaleKeys.auth_login_register,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800))
                                .tr(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
