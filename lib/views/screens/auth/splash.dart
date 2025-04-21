import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:internet_originals/views/screens/auth/onboarding.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String errorText = "";

  @override
  void initState() {
    super.initState();
    // _getFCMToken();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      Future.delayed(Duration(milliseconds: 1200), () {
        Get.off(() => Onboarding(), transition: Transition.noTransition);
      });
    });
  }

  // ignore: unused_element
  Future<void> _getFCMToken() async {
    String? fcmToken;
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();

    setState(() {
      if (token != null) {
        fcmToken = token;
      } else {
        fcmToken = "Failed to get token";
      }
    });

    debugPrint("FCM Token: $fcmToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (errorText != "") SizedBox(height: 70),
            CustomSvg(asset: AppIcons.logo, width: 302, height: 100),
            if (errorText != "")
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(errorText),
              ),
          ],
        ),
      ),
    );
  }
}
