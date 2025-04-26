import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class NotificationServices {
  final messaging = FirebaseMessaging.instance;
  final localNotification = FlutterLocalNotificationsPlugin();

  Future<void> requestPermission() async {
    final settings = await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      providesAppNotificationSettings: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("Notification Permission Granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("Provisional Notification Permission Granted");
    } else {
      showSnackBar("Notification Permission Denied", isError: true);
    }
  }

  Future<String?> getDeviceToken() async {
    await requestPermission();

    String? token = await messaging.getToken();
    return token!;
  }
}
