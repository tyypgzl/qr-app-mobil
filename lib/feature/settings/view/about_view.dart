import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_new/core/language/loacale_key.g.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.settings_about.tr(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(LocaleKeys.licenseHeader.tr(), style: _style),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(LocaleKeys.license1.tr(), style: _style),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(LocaleKeys.license2.tr(), style: _style),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(LocaleKeys.license4.tr(), style: _style),
            ),
          ],
        ),
      ),
    );
  }
}

var _style = const TextStyle(fontSize: 16);
