import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/notification_item.dart';

class NotificationHistory extends StatefulWidget {
  const NotificationHistory({super.key});

  @override
  State<NotificationHistory> createState() => _NotificationHistoryState();
}

class _NotificationHistoryState extends State<NotificationHistory> {
  List<Map<String, dynamic>> notifications = [
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
      appBar: CustomAppBar(title: 'Notification History'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18),
              ...notifications.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: NotificationItem(
                    type: item['type'],
                    status: item['status'],
                    createdAt: item['created_at'],
                    onTap: () {},
                  ),
                );
              }).toList(),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
