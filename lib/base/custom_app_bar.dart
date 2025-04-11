import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 8,
        children: [
          hasLeading
              ? SvgPicture.asset(
                AppIcons.arrowLeft,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  Color(0xff4e4e4e),
                  BlendMode.srcIn,
                ),
              )
              : SizedBox(height: 24, width: 24,),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontVariations: [FontVariation("wght", 600)],
              color: Colors.grey[500],
            ),
          ),
          trailing != null
              ? SvgPicture.asset(
                trailing!,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.dark[400]!,
                  BlendMode.srcIn,
                ),
              )
              : SizedBox(height: 24, width: 24),
        ],
      ),
      backgroundColor: AppColors.green[700],
      centerTitle: true,
      // Add more customization here if needed
    );
  }
}
