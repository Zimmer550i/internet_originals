import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/views/screens/auth/login.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/onboarding.png", fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Talent and opportunity meet here. Let’s make your vision a reality!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      Get.off(() => Login());
                    },
                    child: CustomSvg(
                      asset: AppIcons.redArrowRight,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
