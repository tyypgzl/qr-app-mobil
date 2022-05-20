import 'package:qr_new/core/navigation/navigation_service.dart';

import '../../../../core/base/base_view_model.dart';

class OnboardViewModel extends BaseViewModel {
  @override
  Future<bool> customBack() async {
    navigationService.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() async {}

  @override
  NavigationService get navigationService => NavigationService.instance;
}
