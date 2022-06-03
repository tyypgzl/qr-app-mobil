import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/core/enum/theme_enum.dart';
import 'package:qr_new/core/language/language_manager.dart';
import 'package:qr_new/core/language/loacale_key.g.dart';
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
    return Column(
      children: [
        Expanded(
          child: SettingsList(
            applicationType: ApplicationType.material,
            lightTheme: SettingsThemeData(
              settingsListBackground: AppColors.instance.white,
              settingsSectionBackground: AppColors.instance.white,
            ),
            darkTheme: SettingsThemeData(
              settingsListBackground: AppColors.instance.black,
              settingsSectionBackground: AppColors.instance.black,
            ),
            sections: [
              SettingsSection(
                tiles: [
                  SettingsTile(
                    enabled: true,
                    title: Text(LocaleKeys.settings_language.tr()),
                    description: Text(LocaleKeys.settings_selected.tr()),
                    leading: Icon(Icons.language,
                        color: AppColors.instance.orangeAccent),
                    trailing: const SizedBox(),
                    value: DropdownButton<Locale>(
                      isExpanded: true,
                      value: languageManager.selectedLocale,
                      items: [
                        DropdownMenuItem(
                          onTap: () =>
                              viewModel.turkishOnTap(context, languageManager),
                          value: LanguageManager.instance.trLocale,
                          child: Text(LocaleKeys.settings_turkish.tr()),
                        ),
                        DropdownMenuItem(
                          onTap: () =>
                              viewModel.englishOnTap(context, languageManager),
                          value: LanguageManager.instance.enLocale,
                          child: Text(LocaleKeys.settings_english.tr()),
                        ),
                      ],
                      onChanged: (locale) {
                        if (locale != null) {
                          context.setLocale(locale);
                        }
                      },
                    ),
                  ),
                  SettingsTile(
                    enabled: true,
                    title: Text(LocaleKeys.settings_theme.tr()),
                    leading: themeManager.appTheme.themeModeEnum ==
                            ThemeModeEnum.dark
                        ? Icon(Icons.dark_mode, color: AppColors.instance.pink)
                        : Icon(Icons.light_mode,
                            color: AppColors.instance.pink),
                    trailing: const SizedBox(),
                    value: DropdownButton<ThemeModeEnum>(
                      value: themeManager.appTheme.themeModeEnum,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          onTap: () =>
                              viewModel.lightModeOnTap(context, themeManager),
                          value: ThemeModeEnum.light,
                          child: Text(LocaleKeys.settings_light.tr()),
                        ),
                        DropdownMenuItem(
                          onTap: () =>
                              viewModel.darkModeOnTap(context, themeManager),
                          value: ThemeModeEnum.dark,
                          child: Text(LocaleKeys.settings_dark.tr()),
                        ),
                      ],
                      onChanged: (theme) {
                        if (theme != null) {}
                      },
                    ),
                  ),
                  SettingsTile(
                    enabled: true,
                    title: Text(LocaleKeys.settings_about.tr()),
                    leading: const Icon(Icons.description),
                    onPressed: viewModel.aboutOnTap,
                  ),
                ],
              )
            ],
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.settings_version.tr(),
                style: const TextStyle(fontSize: 15),
              ),
              const Text(
                version,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
