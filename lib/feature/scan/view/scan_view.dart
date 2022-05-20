import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/feature/home/model/lesson.dart';
import 'package:qr_new/feature/scan/view_model/scan_view_model.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';
import 'package:qr_new/feature/shared/widgets/custom_button.dart';
import 'package:qr_new/feature/shared/widgets/qr_scanner.dart';

class ScanView extends BaseView<ScanViewModel> {
  final Lesson lesson;

  ScanView({Key? key, required this.lesson}) : super(key: key);

  @override
  ScanViewModel get homeViewModel => ScanViewModel(
      email: lesson.email ?? 'email@email.com', lesson: lesson.name);

  @override
  PreferredSizeWidget? appBar(ScanViewModel viewModel) => AppBar(
        iconTheme: IconThemeData(color: AppColors.instance.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            color: AppColors.instance.black,
          )
        ],
        backgroundColor: AppColors.instance.orangeAccent,
        elevation: .8,
        title: Text(
          'Qr Okuma Ekranı',
          style: TextStyle(color: AppColors.instance.black),
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
                  child: Lottie.asset('assets/animations/qr_anim.json',
                      width: screenSize.width * .92),
                ),
              ],
            ),
            if (viewModel.isSuccess)
              SizedBox(
                height: screenSize.height * .7,
                width: screenSize.width,
                child: Lottie.asset(
                  'assets/animations/success.json',
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
                color: AppColors.instance.black,
              ),
              width: screenSize.width * .8,
              height: screenSize.width * .13,
              child: Text(
                'Qr Kod Okutuldu.',
                style:
                    TextStyle(color: AppColors.instance.orange, fontSize: 18),
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
      title: 'Derse Katıl',
      backgroundColor: AppColors.instance.pink,
      foregroundColor: AppColors.instance.white,
    );
  }
}
