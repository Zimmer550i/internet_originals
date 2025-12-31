import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/profile_picture.dart';
import 'package:internet_originals/views/screens/common/notifications.dart';

class HomeBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isHome;
  const HomeBar({super.key, this.isHome = false});

  @override
  State<HomeBar> createState() => _HomeBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeBarState extends State<HomeBar> {
  final user = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.green[700],
      surfaceTintColor: AppColors.green[700],
      titleSpacing: 0,
      title: Row(
        children: [
          const SizedBox(width: 20),
          if (widget.isHome)
            Row(
              children: [
                ProfilePicture(image: user.getImageUrl(), size: 44),
                const SizedBox(width: 8),
                Text("Hi, ", style: TextStyle(fontSize: 20)),
                Text(
                  user.userInfo.value!.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          if (!widget.isHome)
            CustomSvg(asset: AppIcons.logo, width: 76, height: 25),
          Spacer(),
          if (user.userInfo.value!.role != EUserRole.MANAGER)
            GestureDetector(
              onTap: () {
                Get.to(() => Notifications());
              },
              child: CustomSvg(asset: AppIcons.bellWithAlert),
            ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
