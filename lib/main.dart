import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_originals/services/local_notification_service.dart';
import 'package:internet_originals/views/screens/auth/splash.dart';
import 'package:internet_originals/themes/dark_theme.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_constants.dart';
import 'package:internet_originals/utils/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/localization_controller.dart';
import 'controllers/theme_controller.dart';
import 'helpers/di.dart' as di;
import 'helpers/route.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("--- Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print(
      'Message notification: ${message.notification?.title}/${message.notification?.body}',
    );
  }

  await LocalNotificationService.displayNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase Initialization Error: $e");
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await LocalNotificationService.initialize();

  Map<String, Map<String, String>> languages = await di.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.green[700],
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return ScreenUtilInit(
              designSize: const Size(393, 852),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return GetMaterialApp(
                  title: AppConstants.APP_NAME,
                  debugShowCheckedModeBanner: false,
                  scaffoldMessengerKey: rootScaffoldMessengerKey,
                  navigatorKey: Get.key,
                  // theme: themeController.darkTheme ? dark(): light(),
                  theme: dark(),
                  defaultTransition: Transition.cupertino,
                  locale: localizeController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(
                    AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode,
                  ),
                  transitionDuration: const Duration(milliseconds: 500),
                  getPages: AppRoutes.pages,
                  // initialRoute: AppRoutes.designPattern,
                  home: Splash(),
                );
              },
            );
          },
        );
      },
    );
  }
}
