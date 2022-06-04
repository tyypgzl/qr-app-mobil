import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_new/config/theme/dark_theme.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/core/constants/app_constants.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/feature/home/model/lesson.dart';
import 'package:qr_new/feature/scan/view_model/scan_view_model.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';
import 'package:qr_new/feature/shared/widgets/custom_button.dart';
import 'package:qr_new/feature/shared/widgets/qr_scanner.dart';

import '../../../core/language/loacale_key.g.dart';

class ScanView extends BaseView<ScanViewModel> {
  final Lesson lesson;

  ScanView({Key? key, required this.lesson}) : super(key: key);

  @override
  ScanViewModel get homeViewModel => ScanViewModel(
      email: lesson.email ?? 'email@email.com', lesson: lesson.name);

  @override
  PreferredSizeWidget? appBar(ScanViewModel viewModel) => AppBar(
        actions: [
          IconButton(
            onPressed: viewModel.logoutButtonOnTap,
            icon: const Icon(Icons.logout),
          )
        ],
        title: Text(
          LocaleKeys.scan_qrScanScreen.tr(),
        ),
      );

  @override
  Widget? body(BuildContext context, ScanViewModel viewModel) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: screenSize.height * .1),
        Stack(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(),
                    width: screenSize.width * .8,
                    height: screenSize.width * .8,
                    child: QrScanner(onRead: viewModel.onRead),
                  ),
                ),
                Positioned(
                  top: -15,
                  child: Lottie.asset(AppConstants.instance.qrAnimPath,
                      width: screenSize.width * .92),
                ),
              ],
            ),
            if (viewModel.isSuccess)
              SizedBox(
                height: screenSize.height * .7,
                width: screenSize.width,
                child: Lottie.asset(
                  AppConstants.instance.successAnimPath,
                  repeat: true,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
        SizedBox(
          height: screenSize.width * .08,
        ),
        if (viewModel.isScanned)
          Center(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: themeManager.appTheme == DarkTheme.mode
                    ? AppColors.instance.white
                    : AppColors.instance.black,
              ),
              width: screenSize.width * .8,
              height: screenSize.width * .13,
              child: Text(
                LocaleKeys.scan_qrRead.tr(),
                style: TextStyle(
                    color: themeManager.appTheme == DarkTheme.mode
                        ? AppColors.instance.black
                        : AppColors.instance.orangeAccent,
                    fontSize: 18),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget? bottomNavigationBar(ScanViewModel viewModel) {
    return CustomButton(
      onTap: () => viewModel.isScanned
          ? viewModel.joinLessonButonOnTap(
              NavigationService.instance.navigatorKey.currentContext!)
          : null,
      title: Text(
        LocaleKeys.scan_joinLesson.tr(),
      ),
      backgroundColor: AppColors.instance.pink,
      foregroundColor: AppColors.instance.white,
    );
  }
}
