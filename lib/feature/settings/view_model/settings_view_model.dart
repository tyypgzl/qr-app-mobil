import 'package:qr_new/core/base/base_view_model.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';

class SettingsViewModel extends BaseViewModel {
  @override
  Future<bool> customBack() async {
    navigationService.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 1));
  }

  @override
  NavigationService get navigationService => NavigationService.instance;
}
