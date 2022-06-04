import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/core/constants/app_constants.dart';
import 'package:qr_new/core/enum/theme_enum.dart';
import 'package:qr_new/core/language/loacale_key.g.dart';
import 'package:qr_new/feature/settings/view_model/settings_view_model.dart';

import '../../shared/utils/app_colors.dart';

class SettingsView extends BaseView<SettingsViewModel> {
  SettingsView({Key? key}) : super(key: key);

  @override
  SettingsViewModel get homeViewModel => SettingsViewModel();

  @override
  Widget? body(BuildContext context, SettingsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading:
                Icon(Icons.language, color: AppColors.instance.orangeAccent),
            title: Text(
              LocaleKeys.settings_language.tr(),
              style: _titleStyle,
            ),
            subtitle: Text(
              LocaleKeys.settings_selected.tr(),
              style: _subTitleLightStyle,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: [
                        SimpleDialogOption(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 44),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppConstants.instance.trFlagPath,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(LocaleKeys.settings_turkish.tr(),
                                    style: viewModel.isDarkMode
                                        ? _dialogDarkStyle
                                        : _dialogLightStyle),
                              ],
                            ),
                            onPressed: () => viewModel.turkishOnTap(
                                context, languageManager)),
                        SimpleDialogOption(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 44),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppConstants.instance.ukFlagPath,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  LocaleKeys.settings_english.tr(),
                                  style: viewModel.isDarkMode
                                      ? _dialogDarkStyle
                                      : _dialogLightStyle,
                                ),
                              ],
                            ),
                            onPressed: () => viewModel.englishOnTap(
                                context, languageManager)),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: themeManager.appTheme.themeModeEnum == ThemeModeEnum.dark
                ? Icon(Icons.dark_mode, color: AppColors.instance.pink)
                : Icon(Icons.light_mode, color: AppColors.instance.pink),
            title: Text(
              LocaleKeys.settings_theme.tr(),
              style: _titleStyle,
            ),
            subtitle: Text(
              viewModel.isDarkMode
                  ? LocaleKeys.settings_dark.tr()
                  : LocaleKeys.settings_light.tr(),
              style: viewModel.isDarkMode
                  ? _subTitleDarklStyle
                  : _subTitleLightStyle,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: [
                        SimpleDialogOption(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 44),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppConstants.instance.lightModePath,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(LocaleKeys.settings_light.tr(),
                                    style: viewModel.isDarkMode
                                        ? _dialogDarkStyle
                                        : _dialogLightStyle),
                              ],
                            ),
                            onPressed: () => viewModel.lightModeOnTap(
                                context, themeManager)),
                        SimpleDialogOption(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 44),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppConstants.instance.darkModePath,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  LocaleKeys.settings_dark.tr(),
                                  style: viewModel.isDarkMode
                                      ? _dialogDarkStyle
                                      : _dialogLightStyle,
                                ),
                              ],
                            ),
                            onPressed: () =>
                                viewModel.darkModeOnTap(context, themeManager)),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(
              LocaleKeys.settings_about.tr(),
              style: _titleStyle,
            ),
            onTap: () => viewModel.aboutOnTap(context),
          ),
        ],
      ),
    );
  }

  final _titleStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final _dialogLightStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final _subTitleLightStyle =
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w600);

  final _dialogDarkStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.instance.white);
  final _subTitleDarklStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.instance.white);
}
