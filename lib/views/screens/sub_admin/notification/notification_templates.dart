import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/hard_notification_item.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/soft_notification_item.dart';

class NotificationTemplates extends StatefulWidget {
  const NotificationTemplates({super.key});

  @override
  State<NotificationTemplates> createState() => _NotificationTemplatesState();
}

class _NotificationTemplatesState extends State<NotificationTemplates> {
  int selectedOption = 0;

  List<Map<String, dynamic>> softNotifications = [{}, {}, {}, {}];
  List<Map<String, dynamic>> hardNotifications = [{}, {}, {}, {}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notification Templates'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36),
                  CustomTabBar(
                    options: ['Soft Notifications', 'Hard Notifications'],
                    onChange: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  if (selectedOption == 0)
                    ...softNotifications.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: SoftNotificationItem(),
                      );
                    }),
                  if (selectedOption == 1)
                    ...softNotifications.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: HardNotificationItem(),
                      );
                    }),
                  SizedBox(height: 72),
                ],
              ),
            ),
            Positioned(
              bottom: 64,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: AppColors.red[500],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(24, 24, 24, .35),
                        blurRadius: 12,
                        offset: Offset(4, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: Colors.white, size: 48),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}