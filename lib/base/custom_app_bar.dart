import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;
  final Function()? leadingCallback;
  final String? trailing;
  const CustomAppBar({
    super.key,
    required this.title,
    this.hasLeading = true,
    this.leadingCallback,
    this.trailing,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 8,
        children: [
          hasLeading
              ? GestureDetector(
                onTap: () {
                  Get.back();
                },
                behavior: HitTestBehavior.translucent,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.arrowLeft,
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                        Color(0xff4e4e4e),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              )
              : SizedBox(height: 48, width: 48),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
            ),
          ),
          if (trailing != null)
            SvgPicture.asset(
              trailing!,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                AppColors.dark[400]!,
                BlendMode.srcIn,
              ),
            ),

          if (hasLeading) SizedBox(width: 48),
        ],
      ),
      backgroundColor: AppColors.green[700],
      centerTitle: true,
    );
  }
}
