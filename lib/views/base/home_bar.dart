import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class HomeBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  const HomeBar({super.key, this.isHome = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.green[700],
      titleSpacing: 0,
      title: Row(
        children: [
          const SizedBox(width: 20,),
          ClipOval(
            child: Image.asset("assets/images/user.png", height: 44, width: 44),
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Row(
              children: [
                Text("Hi, ", 
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text("Susan", 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(child: Container()),
                CustomSvg(asset: AppIcons.bellWithAlert),
                const SizedBox(width: 20,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
