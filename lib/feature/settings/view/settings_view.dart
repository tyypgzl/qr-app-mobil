import 'package:flutter/material.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/feature/settings/view_model/settings_view_model.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';
import 'package:qr_new/feature/shared/utils/const.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends BaseView<SettingsViewModel> {
  SettingsView({Key? key}) : super(key: key);

  @override
  SettingsViewModel get homeViewModel => SettingsViewModel();

  @override
  Widget? body(BuildContext context, SettingsViewModel viewModel) {
    return SettingsList(
      sections: [
        SettingsSection(
          tiles: [
            SettingsTile(
              enabled: true,
              title: const Text('Hesap'),
              leading: const Icon(Icons.account_circle),
              onPressed: (context) {},
            ),
            SettingsTile(
              enabled: true,
              title: const Text('Dil'),
              description: const Text('Türkçe'),
              leading: const Icon(Icons.language),
              onPressed: (context) {},
            ),
            SettingsTile.switchTile(
              initialValue: true,
              onToggle: (value) {},
              title: const Text('Tema'),
              description: const Text('Işık Modu'),
              leading: const Icon(Icons.light_mode),
              activeSwitchColor: AppColors.instance.pink,
            ),
            SettingsTile(
              enabled: true,
              title: const Text('Hakkında'),
              leading: const Icon(Icons.description),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              title: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Version: '),
                  Text(
                    version,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ),
          ],
        )
      ],
    );
  }
}
