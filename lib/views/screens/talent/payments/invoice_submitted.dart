import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class InvoiceSubmitted extends StatelessWidget {
  const InvoiceSubmitted({super.key});

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
                'Invoice Submitted Successfully! 🎉',
                style: TextStyle(
                  fontSize: 21,
                  color: AppColors.dark[25],
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18),
              Text(
                'Your invoice is under review. Expect processing within 96 hours',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.dark[50],
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 36),
              CustomButton(
                text: 'Back to Payments',
                width: MediaQuery.of(context).size.width * 0.6,
                textSize: 16,
                onTap: () {
                  Get.until(
                    (route) =>
                        (Get.currentRoute == AppRoutes.talentApp) ||
                        (Get.currentRoute == AppRoutes.subAdminApp),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
