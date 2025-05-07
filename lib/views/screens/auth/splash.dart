import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/views/screens/auth/onboarding.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/screens/sub_admin/sub_admin_app.dart';
import 'package:internet_originals/views/screens/talent/talent_app.dart';

import '../../../services/shared_prefs_service.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String errorText = "";
  Widget? nextRoute;
  final user = Get.find<UserController>();

  void getRoute() async {
    final stopwatch = Stopwatch()..start();

    final token = await SharedPrefsService.get('token');
    if (token != null) {
      final message = await user.getInfo();
      if (message == "success") {
        if (user.userInfo.value!.role == "INFLUENCER") {
          nextRoute = TalentApp(key: talentAppKey,);
        } else {
          nextRoute = SubAdminApp(key: subAdminAppKey,);
        }
      } else {
        nextRoute = Onboarding();
      }
    } else {
      nextRoute = Onboarding();
    }

    await Future.delayed(Duration(milliseconds: 1200) - stopwatch.elapsed);

    if (nextRoute != null) {
      Get.off(() => nextRoute!, transition: Transition.noTransition);
    } else {
      Get.off(() => Onboarding(), transition: Transition.noTransition);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      getRoute();
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
