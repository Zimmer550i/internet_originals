import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/auth_controller.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/screens/auth/account_under_review.dart';
import 'package:internet_originals/views/screens/auth/email_verification.dart';
import 'package:internet_originals/views/screens/auth/login.dart';
import 'package:internet_originals/views/screens/auth/onboarding.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/screens/auth/user_information.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String errorText = "";
  String? nextRoute;
  final user = Get.find<UserController>();
  final auth = Get.find<AuthController>();

  void getRoute() async {
    final stopwatch = Stopwatch()..start();

    final isLoggedIn = await auth.checkLoginStatus();

    if (isLoggedIn) {
      await Future.delayed(Duration(milliseconds: 1200) - stopwatch.elapsed);
      final role = user.userInfo.value!.role;
      if (role == EUserRole.SUB_ADMIN) {
        Get.offNamed(AppRoutes.subAdminApp);
      } else if (role == EUserRole.INFLUENCER) {
        Get.offNamed(AppRoutes.talentApp);
      } else if (role == EUserRole.USER) {
        if (user.userInfo.value!.socials.isNotEmpty) {
          Get.to(() => AccountUnderReview());
        } else {
          Get.to(() => UserInformation());
        }
      } else if (role == EUserRole.MANAGER) {
        Get.offNamed(AppRoutes.managerApp);
      } else if (role == EUserRole.GUEST) {
        Get.offAll(() => Login());
        Get.to(() => EmailVerification());
        auth.sendOtp(user.userInfo.value!.email);
        showSnackBar(
          "Please verify your account. An OTP has been sent to your Email",
          isError: false,
        );
      }
    } else {
      Get.off(() => Onboarding(), transition: Transition.noTransition);
    }

    stopwatch.stop();
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
