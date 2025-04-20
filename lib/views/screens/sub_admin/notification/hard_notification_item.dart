import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class HardNotificationItem extends StatefulWidget {
  const HardNotificationItem({super.key});

  @override
  State<HardNotificationItem> createState() => _HardNotificationItemState();
}

class _HardNotificationItemState extends State<HardNotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.dark[600],
        border: Border.all(color: AppColors.dark[400]!, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Time to record your content!',
                  style: TextStyle(
                    color: AppColors.green[25],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CustomSvg(
                asset: 'assets/icons/notification/pencil.svg',
                width: 24,
                height: 24,
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Hey [Talent Name], just a heads-up! Your content for [Campaign Name] is due on [Deadline Date]. Let us know if you need anything. Keep up the great work!',
            style: TextStyle(
              color: AppColors.green[50],
              fontSize: 12,
              height: 1.6,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              CustomButton(
                text: 'Yes',
                onTap: () {},
                height: 36,
                textSize: 14,
                width: (MediaQuery.of(context).size.width - 48 - 36 - 12) / 2,
              ),
              SizedBox(width: 12),
              CustomButton(
                text: 'No',
                isSecondary: true,
                onTap: () {},
                height: 36,
                textSize: 14,
                width:
                    (MediaQuery.of(context).size.width - 48 - 36 - 12) / 2 - 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
