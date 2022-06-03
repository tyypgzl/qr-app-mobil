import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/core/constants/app_constants.dart';
import 'package:qr_new/core/constants/route_constants.dart';
import 'package:qr_new/core/language/loacale_key.g.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/feature/auth/onboard/view_model/onboard_view_model.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';
import 'package:qr_new/feature/shared/widgets/custom_button.dart';

class OnboardView extends BaseView<OnboardViewModel> {
  OnboardView({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, OnboardViewModel viewModel) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Image.asset(
                      AppConstants.instance.appIconPath,
                      width: 250,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.auth_onboard_welcome,
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ).tr(),
                  ),
                  const Spacer(flex: 7),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.instance.orangeAccent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            onTap: () async {
                              await NavigationService.instance
                                  .pushNamed(routePath: RouteConstants.login);
                            },
                            backgroundColor: AppColors.instance.pink,
                            foregroundColor: AppColors.instance.white,
                            title:
                                const Text(LocaleKeys.auth_onboard_login).tr(),
                            height: MediaQuery.of(context).size.height * .067,
                            width: MediaQuery.of(context).size.width * .85,
                          ),
                          CustomButton(
                            onTap: () async {
                              await NavigationService.instance.pushNamed(
                                  routePath: RouteConstants.register);
                            },
                            backgroundColor: AppColors.instance.pink,
                            foregroundColor: AppColors.instance.white,
                            title: const Text(
                              LocaleKeys.auth_onboard_register,
                            ).tr(),
                            height: MediaQuery.of(context).size.height * .067,
                            width: MediaQuery.of(context).size.width * .85,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  OnboardViewModel get homeViewModel => OnboardViewModel();
}
