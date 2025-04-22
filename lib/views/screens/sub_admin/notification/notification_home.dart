import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/notification_item.dart';

class NotificationHome extends StatefulWidget {
  const NotificationHome({super.key});

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  List<Map<String, dynamic>> resentNotifications = [
    {
      'type': NotificationType.soft,
      'status': NotificationStatus.sent,
      'created_at': 1745147285555,
    },
    {
      'type': NotificationType.soft,
      'status': NotificationStatus.scheduled,
      'created_at': 1745147285555,
    },
    {
      'type': NotificationType.hard,
      'status': NotificationStatus.sent,
      'created_at': 1745147285555,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(isHome: false),
      backgroundColor: AppColors.green[700],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 12),
              CustomButton(
                leading: "assets/icons/notification/send.svg",
                text: 'Send Notification',
                onTap: () {
                  Get.toNamed(AppRoutes.sendNotification);
                },
              ),
              SizedBox(height: 18),
              CustomButton(
                leading: 'assets/icons/notification/template.svg',
                text: 'See Template',
                isSecondary: true,
                onTap: () {
                  Get.toNamed(AppRoutes.notificationTemplates);
                },
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.notificationHistory);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Text(
                        'Notification History',
                        style: TextStyle(
                          color: AppColors.green[100],
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'See All',
                        style: TextStyle(
                          color: AppColors.green[100],
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 4),
                      CustomSvg(
                        asset: 'assets/icons/notification/arrow_right.svg',
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              ...resentNotifications.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: NotificationItem(
                    type: item['type'],
                    status: item['status'],
                    createdAt: item['created_at'],
                    onTap: () {

                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
