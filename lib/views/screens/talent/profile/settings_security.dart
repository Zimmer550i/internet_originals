import 'package:flutter/material.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:get/get.dart';

class SettingsSecurity extends StatefulWidget {
  const SettingsSecurity({super.key});

  @override
  State<SettingsSecurity> createState() => _SettingsSecurityState();
}

class _SettingsSecurityState extends State<SettingsSecurity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Settings & Security'),
      backgroundColor: AppColors.green[700],
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          SettingsTab(
            leadingIcon: "assets/icons/settings_security/change_password.svg",
            title: "Change Password",
            onTap: () {
              Get.toNamed(AppRoutes.changePassword);
            },
          ),
          SettingsTab(
            leadingIcon: "assets/icons/settings_security/privacy_policy.svg",
            title: "Privacy Policy",
            onTap: () {
              Get.toNamed(AppRoutes.privacyPolicy);
            },
          ),
          SettingsTab(
            leadingIcon: "assets/icons/settings_security/terms_service.svg",
            title: "Terms & Condition",
            onTap: () {
              Get.toNamed(AppRoutes.termsService);
            },
          ),
          SettingsTab(
            leadingIcon: "assets/icons/settings_security/about_us.svg",
            title: "About Us",
            bottomBOrder: false,
            onTap: () {
              Get.toNamed(AppRoutes.aboutUs);
            },
          ),
        ],
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final bool bottomBOrder;
  final Function()? onTap;

  const SettingsTab({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.bottomBOrder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 64,
        decoration: BoxDecoration(
          border:
              bottomBOrder
                  ? Border(
                    bottom: BorderSide(color: AppColors.dark[400]!, width: 1),
                  )
                  : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 4),
        margin: EdgeInsets.only(left: 32, right: 32),
        child: Row(
          children: [
            CustomSvg(asset: leadingIcon, width: 28, height: 28),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: AppColors.dark[50],
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            CustomSvg(asset: AppIcons.chevronRight, width: 28),
          ],
        ),
      ),
    );
  }
}
