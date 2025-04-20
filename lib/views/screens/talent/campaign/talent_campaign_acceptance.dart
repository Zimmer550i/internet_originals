import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/screens/talent/talent_app.dart';

class TalentCampaignAcceptance extends StatefulWidget {
  const TalentCampaignAcceptance({super.key});

  @override
  State<TalentCampaignAcceptance> createState() =>
      _TalentCampaignAcceptanceState();
}

class _TalentCampaignAcceptanceState extends State<TalentCampaignAcceptance> {
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
                "Campaign Accepted! 🎉",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.green[25],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "You've successfully accepted the campaign. Check your active campaigns to track progress.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "View in Active Campaigns",
                width: null,
                onTap: () {
                  Get.until(
                    (route) =>
                        Get.currentRoute == AppRoutes.talentApp ||
                        Get.currentRoute == AppRoutes.subAdminApp,
                  );
                  talentAppKey.currentState?.setState(() {
                    talentAppKey.currentState?.index = 1;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      talentCampaignTabBarKey.currentState?.setState(() {
                        talentCampaignTabBarKey.currentState?.index = 1;
                      });
                    });
                  });
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
