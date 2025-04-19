import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class TalentPerformanceMetricsConfirmation extends StatefulWidget {
  const TalentPerformanceMetricsConfirmation({super.key});

  @override
  State<TalentPerformanceMetricsConfirmation> createState() =>
      _TalentPerformanceMetricsConfirmationState();
}

class _TalentPerformanceMetricsConfirmationState
    extends State<TalentPerformanceMetricsConfirmation> {
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
                "Metrics Submitted Successfully!",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.green[25],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Your performance metrics for the Nike Air Max campaign have been successfully uploaded. Next, upload your invoice to receive payment.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Send Payment Request",
                width: null,
                onTap: () {
                  Get.until(
                    (route) =>
                        Get.currentRoute == AppRoutes.talentApp ||
                        Get.currentRoute == AppRoutes.subAdminApp,
                  );
                },
              ),
              const SizedBox(height: 12),

              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.until(
                    (route) =>
                        Get.currentRoute == AppRoutes.talentApp ||
                        Get.currentRoute == AppRoutes.subAdminApp,
                  );
                },
                child: Text(
                  "Back to Campaign",
                  style: TextStyle(color: AppColors.red[400], fontSize: 14),
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
