import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/core/language/loacale_key.g.dart';
import 'package:qr_new/feature/home/view_model/home_view_model.dart';
import 'package:qr_new/feature/lessons/view/lessons_view.dart';
import 'package:qr_new/feature/settings/view/settings_view.dart';

class HomeView extends BaseView<HomeViewModel> {
  final String email;
  HomeView({required this.email, Key? key}) : super(key: key);

  @override
  HomeViewModel get homeViewModel => HomeViewModel.instance;

  @override
  PreferredSizeWidget? appBar(HomeViewModel viewModel) => AppBar(
        actions: [
          IconButton(
            onPressed: viewModel.logoutButtonOnTap,
            icon: const Icon(Icons.logout),
          )
        ],
        title: Text(
          viewModel.selectedNavBar == 0
              ? LocaleKeys.home_lesson.tr()
              : LocaleKeys.home_settings.tr(),
        ),
      );

  @override
  Widget? bottomNavigationBar(HomeViewModel viewModel) {
    return NavigationBar(
      height: 60,
      selectedIndex: viewModel.selectedNavBar,
      onDestinationSelected: viewModel.onDestinationSelected,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: [
        NavigationDestination(
          selectedIcon: const Icon(Icons.book_sharp),
          icon: const Icon(Icons.book),
          label: LocaleKeys.home_lesson.tr(),
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings),
          label: LocaleKeys.home_settings.tr(),
        ),
      ],
    );
  }

  @override
  Widget? body(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.selectedNavBar == 0) {
      return LessonView(email: email);
    } else {
      return SettingsView();
    }
  }
}
