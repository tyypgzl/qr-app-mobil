import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_new/core/base/base_view_model.dart';
import 'package:qr_new/core/enum/page_state_enum.dart';
import 'package:qr_new/core/language/language_manager.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:qr_new/core/theme/theme_manager.dart';
import 'package:qr_new/core/widgets/loading_overlay.dart';

// ignore: must_be_immutable
abstract class BaseView<T extends BaseViewModel> extends StatelessWidget {
  BaseView({Key? key}) : super(key: key);

  T get homeViewModel;

  final theme =
      Theme.of(NavigationService.instance.navigatorKey.currentContext!);
  final textTheme =
      Theme.of(NavigationService.instance.navigatorKey.currentContext!)
          .textTheme;
  final screenSize =
      MediaQuery.of(NavigationService.instance.navigatorKey.currentContext!)
          .size;
  final themeManager = ThemeManager.instance;
  final languageManager = LanguageManager.instance;

  PreferredSizeWidget? appBar(T viewModel) => null;

  Widget? bodyWithoutScaffold(BuildContext context, T viewModel) => null;
  Widget? body(BuildContext context, T viewModel) => null;
  Widget? bottomNavigationBar(T viewModel) => null;

  Color? get backgroundColor => null;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: themeManager,
        child: Consumer<ThemeManager>(
          builder: (context, value, child) => ChangeNotifierProvider.value(
            value: languageManager,
            child: Consumer<LanguageManager>(
              builder: (context, value, child) =>
                  ChangeNotifierProvider<T>.value(
                value: homeViewModel,
                child: Consumer<T>(
                  builder: (context, viewModel, child) => SafeArea(
                    child: WillPopScope(
                      onWillPop: viewModel.customBack,
                      child: bodyWithoutScaffold(context, viewModel) ??
                          Scaffold(
                            backgroundColor: backgroundColor,
                            appBar: appBar(viewModel),
                            body: viewModel.initialStateCompleted
                                ? Stack(
                                    children: [
                                      if (body(context, viewModel) != null)
                                        body(context, viewModel)!,
                                      if (viewModel.state == PageState.LOADING)
                                        const LoadingOverlay()
                                    ],
                                  )
                                : Center(
                                    child: Lottie.asset(
                                      'assets/animations/loading.json',
                                      height: 90,
                                    ),
                                  ),
                            bottomNavigationBar: bottomNavigationBar(viewModel),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
