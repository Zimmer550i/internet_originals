import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class CampaignAssigned extends StatelessWidget {
  final UserModel influncer;
  final CampaignModel campaign;

  const CampaignAssigned({
    super.key,
    required this.influncer,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.dark[500],
                ),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.width * 0.45,
                child: Center(
                  child: CustomSvg(
                    asset: 'assets/icons/tick.svg',
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
              ),
              SizedBox(height: 36),
              Text(
                'You assigned',
                style: TextStyle(
                  fontSize: 21,
                  color: AppColors.dark[25],
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (influncer.avatar != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.network(
                        ApiService().baseUrl + influncer.avatar!,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(width: 8),
                  Text(
                    influncer.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'to',
                    style: TextStyle(
                      color: AppColors.dark[50],
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Image.network(
                      ApiService().baseUrl + campaign.banner,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    campaign.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 36),
              CustomButton(
                text: 'Go Back',
                width: MediaQuery.of(context).size.width * 0.6,
                textSize: 16,
                onTap: () {
                  Get.back();
                  Get.back();
                  // Get.until((route) {
                  //   return route.settings.name == AppRoutes.subAdminApp;
                  // });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
