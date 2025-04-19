import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';

final GlobalKey<CustomTabBarState> talentCampaignTabBarKey =
    GlobalKey<CustomTabBarState>();

class CustomTabBar extends StatefulWidget {
  final List<String> options;
  final Function(int) onChange;
  const CustomTabBar({
    super.key,
    required this.options,
    required this.onChange,
  });

  @override
  State<CustomTabBar> createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        for (int i = 0; i < widget.options.length; i++)
          Expanded(child: button(i)),
      ],
    );
  }

  Widget button(int pos) {
    bool isSelected = pos == index;

    return InkWell(
      onTap: () {
        setState(() {
          index = pos;
          widget.onChange(pos);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: 28,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: isSelected ? AppColors.red : Colors.transparent,
          border: isSelected ? null : Border.all(color: AppColors.green[400]!),
        ),
        child: Center(
          child: Text(
            widget.options[pos],
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: isSelected ? 16 : 14,
              color: isSelected ? Colors.white : AppColors.green[200],
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
