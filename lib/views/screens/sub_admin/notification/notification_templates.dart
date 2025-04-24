import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/create_notification.dart';

class NotificationTemplates extends StatefulWidget {
  final bool isEditable;
  const NotificationTemplates({super.key, this.isEditable = false});

  @override
  State<NotificationTemplates> createState() => _NotificationTemplatesState();
}

class _NotificationTemplatesState extends State<NotificationTemplates> {
  bool showingHard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification Templates"),
      floatingActionButton: GestureDetector(
        onTap:
            () => Get.to(
              () => CreateNotification(initialPick: showingHard ? 1 : 0),
            ),
        child: Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
            color: AppColors.red,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add_rounded, size: 52),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomTabBar(
              options: ["Soft Notifications", "Hard Notifications"],
              buttonsPerScreen: 2,
              onChange: (val) {
                setState(() {
                  if (val == 1) {
                    setState(() {
                      showingHard = true;
                    });
                  } else {
                    setState(() {
                      showingHard = false;
                    });
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () => Get.back(),
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
                          children: [
                            Row(
                              spacing: 8,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Time to Record Your Content!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.green[25],
                                  ),
                                ),
                                if (widget.isEditable)
                                  CustomSvg(
                                    asset: "assets/icons/notification/pencil.svg",
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Hi [Talent Name], your payment for [Campaign Name] is being processed. Expect to receive it by [Payout Date]. No further action is needed on your end.",
                              style: TextStyle(fontSize: 12),
                            ),
                            if (showingHard)
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        onTap: () {},
                                        text: "Yes",
                                        height: 26,
                                        textSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CustomButton(
                                        onTap: () {},
                                        text: "No",
                                        height: 26,
                                        textSize: 12,
                                        isSecondary: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
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
