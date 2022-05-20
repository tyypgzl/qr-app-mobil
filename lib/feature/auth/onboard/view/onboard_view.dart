import 'package:flutter/material.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/core/constants/route_constants.dart';
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
                      'assets/images/ic_qr.png',
                      width: 250,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Hoşgeldiniz',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
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
                            title: 'Giriş Yap',
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
                            title: 'Kayıt Ol',
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
