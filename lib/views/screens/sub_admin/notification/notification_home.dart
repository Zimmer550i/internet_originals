import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/influencer_list.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/notification_templates.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/send_notification.dart';

class NotificationHome extends StatefulWidget {
  const NotificationHome({super.key});

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomButton(
              text: "Send Notification",
              leading: "assets/icons/notification/send.svg",
              onTap: () => Get.to(() => SendNotification()),
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: "See Templates",
              leading: 'assets/icons/notification/template.svg',
              isSecondary: true,
              onTap:
                  () => Get.to(() => NotificationTemplates(isEditable: true)),
            ),
            const SizedBox(height: 24),
            CustomTabBar(
              options: ["Scheduled", "Sent"],
              onChange: (val) {
                setState(() {
                  index = val;
                });
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green[600],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.green[400]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Soft Notification",
                            style: TextStyle(
                              fontSize: 12,
                              height: 18 / 12,
                              color: AppColors.red[300],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Deadline Reminder",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              height: 20 / 14,
                              color: AppColors.green[25],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Your campaign “Adidas Running” requires you to upload performance metrics",
                            style: TextStyle(
                              // color: AppColors.green[100],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () => Get.to(() => InfluencerList()),
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              "10 Talents",
                              style: TextStyle(
                                color: AppColors.red[300],
                                fontSize: 12,
                                height: 18 / 12,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.red[300],
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            spacing: 8,
                            children: [
                              CustomSvg(
                                asset: AppIcons.calendar,
                                size: 16,
                                color: AppColors.red[300],
                              ),
                              Text(
                                "Feb 12, 2025 | ",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              CustomSvg(
                                asset: AppIcons.clock,
                                size: 16,
                                color: AppColors.red[300],
                              ),
                              Text(
                                "10:53 AM",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
