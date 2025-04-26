import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_originals/main.dart';

class LocalNotificationService {
  LocalNotificationService._privateConstructor();
  static final LocalNotificationService instance = LocalNotificationService._privateConstructor();

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) {
      if (kDebugMode) {
        print("LocalNotificationService already initialized.");
      }
      return;
    }

    if (kDebugMode) {
      print("Initializing LocalNotificationService...");
    }

    await _initializeLocalNotifications();
    await _requestPermissions();
    await _configureFCM();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    _isInitialized = true;
    if (kDebugMode) {
      print("LocalNotificationService initialized successfully.");
    }

    getFcmToken();
    handleInitialMessage();
  }

  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onDidReceiveBackgroundNotificationResponse,
    );

    await _createAndroidNotificationChannel();
  }

  static Future<void> _requestPermissions() async {
     if (kDebugMode) print("Requesting permissions...");
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
        print('User granted FCM permission: ${settings.authorizationStatus}');
    }

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    final bool? androidResult = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();

     final bool? iosResult = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );

    if (kDebugMode) {
        print('Android local notification permission granted: $androidResult');
        print('iOS local notification permission granted: $iosResult');
    }
  }

   static Future<void> _createAndroidNotificationChannel() async {
     const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

     if (kDebugMode) print("Android Notification Channel created.");
   }

  static Future<void> _configureFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('--- Received FOREGROUND message ---');
        print('Message data: ${message.data}');
        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification!.title} / ${message.notification!.body}');
        }
      }
      displayNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('--- BACKGROUND message tapped (App Opened) ---');
        print('Message data: ${message.data}');
      }
      _handleMessageData(message.data, tapped: true);
    });

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> handleInitialMessage() async {
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
       if (kDebugMode) {
        print('--- TERMINATED message tapped (App Opened) ---');
        print('Initial Message data: ${initialMessage.data}');
      }
      _handleMessageData(initialMessage.data, tapped: true);
    }
  }


  static Future<void> displayNotification(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch.remainder(100000) + Random().nextInt(100);
    final String title = message.notification?.title ?? 'No Title';
    final String body = message.notification?.body ?? 'No Body';
    final Map<String, dynamic> payloadData = message.data;

     if (kDebugMode) {
      print("Displaying Notification: ID=$id, Title=$title, Body=$body, Payload=$payloadData");
    }

    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: jsonEncode(payloadData),
    );

     if (kDebugMode) print("Notification shown successfully.");
  }

  static void _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
     if (kDebugMode) {
      print('--- Local Notification Tapped (Foreground/Background) ---');
      print('Notification ID: ${notificationResponse.id}');
      print('Action ID: ${notificationResponse.actionId}');
      print('Payload: ${notificationResponse.payload}');
    }

    if (notificationResponse.payload != null && notificationResponse.payload!.isNotEmpty) {
      try {
        final Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
        _handleMessageData(data, tapped: true);
      } catch (e) {
         if (kDebugMode) print("Error decoding notification payload: $e");
      }
    } else {
      _handleMessageData({}, tapped: true);
    }
  }

   @pragma('vm:entry-point')
   static void _onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) {
     if (kDebugMode) {
        print('--- Local Notification Tapped (Background Specific Handler) ---');
        print('Payload: ${notificationResponse.payload}');
     }
    _onDidReceiveNotificationResponse(notificationResponse);
   }

  static void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
     if (kDebugMode) {
      print('--- Deprecated: onDidReceiveLocalNotification (iOS Foreground) ---');
      print('ID: $id, Title: $title, Payload: $payload');
    }
     if (payload != null && payload.isNotEmpty) {
      try {
        final Map<String, dynamic> data = jsonDecode(payload);
        _handleMessageData(data, tapped: false);
      } catch (e) {
         if (kDebugMode) print("Error decoding payload in deprecated handler: $e");
      }
    }
  }

  static void _handleMessageData(Map<String, dynamic> data, {required bool tapped}) {
    if (kDebugMode) {
      print("Handling message data: $data (Tapped: $tapped)");
    }

    final String? screen = data['screen'] as String?;
    if (tapped && screen != null) {
       if (kDebugMode) print("Navigating to screen: $screen");
    } else {
       if (kDebugMode) {
        print("No navigation action defined or notification not tapped yet.");
       }
    }
  }

static Future<String?> getFcmToken() async {
  try {
    String? apnsToken;
    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
         apnsToken = await _firebaseMessaging.getAPNSToken();
         if (apnsToken == null) {
           if (kDebugMode) print('Warning: APNS token was null when explicitly requested.');
           await Future.delayed(const Duration(seconds: 2));
           apnsToken = await _firebaseMessaging.getAPNSToken();
         }
         if (kDebugMode) print('APNS Token: $apnsToken');
    }
    String? fcmToken = await _firebaseMessaging.getToken();
    if (kDebugMode) print('Firebase Messaging Token: $fcmToken');
    return fcmToken;
  } catch (e) {
    if (kDebugMode) print("Error getting FCM token: $e");
    return null;
  }
}
}