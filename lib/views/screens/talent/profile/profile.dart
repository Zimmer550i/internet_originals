import 'package:flutter/material.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_modal.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/profile_picture.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green[700],
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ProfilePicture(
            image: "https://picsum.photos/200/300",
            allowEdit: false,
            size: MediaQuery.of(context).size.width * 0.32,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 36),
            child: Text(
              "Susan Marvin",
              style: TextStyle(
                color: AppColors.dark[50],
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ProfileTab(
            leadingIcon: "assets/icons/profile/user_crown.svg",
            title: "Personal Information",
            onTap: () {
              Get.toNamed(AppRoutes.personalInformation);
            },
          ),
          ProfileTab(
            leadingIcon: "assets/icons/profile/frame.svg",
            title: "Social Platforms",
            onTap: () {
              Get.toNamed(AppRoutes.socialPlatforms);
            },
          ),
          ProfileTab(
            leadingIcon: "assets/icons/profile/settings.svg",
            title: "Settings & Security",
            onTap: () {
              Get.toNamed(AppRoutes.settingsSecurity);
            },
          ),
          ProfileTab(
            leadingIcon: "assets/icons/profile/log_out.svg",
            title: "Logout",
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

class ProfileTab extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final bool bottomBOrder;
  final Function()? onTap;

  const ProfileTab({
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
