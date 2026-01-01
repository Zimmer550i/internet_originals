import 'package:flutter/material.dart';
import 'package:internet_originals/controllers/auth_controller.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_modal.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/profile_picture.dart';
import 'package:get/get.dart';
import 'package:internet_originals/views/base/pull_to_refresh.dart';
import 'package:internet_originals/views/screens/auth/splash.dart';
import 'package:internet_originals/views/screens/talent/profile/talent_connections.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = Get.find<UserController>();
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green[700],
      body: PullToRefresh(
        onRefresh: () async {
          await user.getInfo();
          setState(() {});
        },
        // controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              SafeArea(child: SizedBox(height: 24)),
              Obx(
                () => Center(
                  child: ProfilePicture(image: user.getImageUrl(), size: 116),
                ),
              ),
              Obx(
                () => Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 24),
                    child: Text(
                      user.userInfo.value!.name,
                      style: TextStyle(
                        color: AppColors.dark[50],
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                leadingIcon: "assets/icons/connections.svg",
                title: "See Connection",
                onTap: () {
                  Get.to(() => TalentConnections());
                },
              ),
              ProfileTab(
                leadingIcon: "assets/icons/profile/frame.svg",
                title: "Social Platforms",
                onTap: () {
                  Get.toNamed(AppRoutes.socialPlatforms);
                },
              ),
              // for (int i = 0; i < 10; i++)
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
                    onLeftButtonClick: () {
                      Get.find<AuthController>().logout();
                      Get.off(() => Splash());
                    },
                    rightButtonText: 'Cancel',
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
        decoration: BoxDecoration(
          border:
              bottomBOrder
                  ? Border(
                    bottom: BorderSide(color: AppColors.dark[400]!, width: 0.5),
                  )
                  : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
        margin: EdgeInsets.only(left: 32, right: 32),
        child: Row(
          children: [
            CustomSvg(asset: leadingIcon, width: 24, height: 24),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: AppColors.dark[50],
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            CustomSvg(asset: AppIcons.chevronRight, width: 24),
          ],
        ),
      ),
    );
  }
}
