import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class TalentPendingTaskCompletion extends StatelessWidget {
  const TalentPendingTaskCompletion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Spacer(),
              CustomSvg(asset: AppIcons.bigBlackTick, size: 180),
              const SizedBox(height: 32),
              Text(
                "Your Post’s Link Submitted Successfully! 🎉",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.green[25],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Your participation in the campaign has been recorded. Once the campaign period ends, you’ll be prompted to submit performance metrics.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Back To Home",
                width: null,
                onTap: () {
                  Get.until(
                    (route) =>
                        (Get.currentRoute == AppRoutes.talentApp) ||
                        (Get.currentRoute == AppRoutes.subAdminApp),
                  );
                },
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
