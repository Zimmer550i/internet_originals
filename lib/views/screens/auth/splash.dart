import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:internet_originals/views/screens/auth/onboarding.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/svg.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      Future.delayed(Duration(milliseconds: 1200), () {
        Get.off(() => Onboarding(), transition: Transition.noTransition);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (errorText != "") SizedBox(height: 70),
            Svg(asset: AppIcons.logo, width: null, height: null),
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
