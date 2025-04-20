import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';

class SendNotification extends StatefulWidget {
  const SendNotification({super.key});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notification History'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 36),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.dark[600],
                border: Border.all(color: AppColors.dark[400]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    hintText: 'Notification Type',
                    trailing: 'assets/icons/arrow_down.svg',
                  ),
                  SizedBox(height: 12),
                  CustomTextField(
                    hintText: 'Recipients',
                    trailing: 'assets/icons/arrow_down.svg',
                  ),
                  SizedBox(height: 12),
                  CustomTextField(
                    hintText: 'Message ....',
                    trailing: 'assets/icons/notification/template.svg',
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Action Fields:',
                    style: TextStyle(
                      color: AppColors.green[200],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: CustomTextField(hintText: 'Primary')),
                      SizedBox(width: 12),
                      Expanded(child: CustomTextField(hintText: 'Secondary')),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //TODO: Schedule
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.green[400]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomSvg(
                                asset: 'assets/icons/notification/clock.svg',
                                width: 16,
                                height: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Schedule for later',
                                style: TextStyle(
                                  color: AppColors.green[200],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 48),
                  CustomButton(
                    leading: 'assets/icons/notification/send.svg',
                    text: 'Send',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
