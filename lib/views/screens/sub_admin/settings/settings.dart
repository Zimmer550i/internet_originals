import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_modal.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class SettingsHome extends StatefulWidget {
  const SettingsHome({super.key});

  @override
  State<SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.green[700],
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSvg(asset: AppIcons.logo),

              CustomSvg(asset: AppIcons.bellWithAlert),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.green[700],
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SettingsTab(
            leadingIcon: "assets/icons/profile/user_crown.svg",
            title: "Personal Information",
            onTap: () {
              Get.toNamed(AppRoutes.adminPersonalInformation);
            },
          ),
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
              Get.toNamed(AppRoutes.adminPrivacyPolicy);
            },
          ),
          SettingsTab(
            leadingIcon: "assets/icons/settings_security/terms_service.svg",
            title: "Terms & Condition",
            onTap: () {
              Get.toNamed(AppRoutes.adminTermsService);
            },
          ),
          SettingsTab(
            leadingIcon: "assets/icons/settings_security/about_us.svg",
            title: "About Us",
            onTap: () {
              Get.toNamed(AppRoutes.adminAboutUs);
            },
          ),
          SettingsTab(
            leadingIcon: "assets/icons/profile/log_out.svg",
            title: "Log Out",
            bottomBOrder: false,
            onTap: () {
              showCustomModal(
                context: context,
                title: 'Are you sure you want to',
                highlight: 'Logout?',
                leftButtonText: 'Logout',
                rightButtonText: 'Cancel',
              );
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
