import 'dart:developer';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:qr_new/feature/shared/utils/api_const.dart';

class OneSignalManager {
  OneSignalManager._();

  static Future<void> initialize() async {
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId(APIconst.oneSignalAppId);
    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {
      log("Accepted permission: $accepted");
    });
  }

  static void notificationHandler() {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});

    OneSignal.shared
        .setPermissionObserver((OSPermissionStateChanges changes) {});

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {});

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {});
  }
}
