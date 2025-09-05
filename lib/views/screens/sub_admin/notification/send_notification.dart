import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_drop_down.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';

class SendNotification extends StatefulWidget {
  final UserModel influencer;
  const SendNotification({super.key, required this.influencer});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  final sub = Get.find<SubAdminController>();
  final title = TextEditingController();
  final body = TextEditingController();
  String type = "SOFT";
  bool forLater = false;
  DateTime? date;
  TimeOfDay? time;

  void onCallback() async {
    final message = await sub.sendNotification(
      title.text.trim(),
      body.text.trim(),
      widget.influencer.id,
      type,
      date?.copyWith(hour: time?.hour, minute: time?.minute),
    );

    if (message == "success") {
      if (forLater) {
        showSnackBar("Notification scheduled for later", isError: false);
      } else {
        showSnackBar("Notification sent successfully", isError: false);
      }
    } else {
      showSnackBar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Send Notification"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.green[600],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.green[400]!),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Notification to",
                              style: TextStyle(color: AppColors.green.shade200),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.green.shade500,
                                  border: Border.all(
                                    color: AppColors.green.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 4,
                                  children: [
                                    ClipRRect(
                                      child:
                                          widget.influencer.avatar != null
                                              ? Image.network(
                                                (ApiService().baseUrl +
                                                    widget.influencer.avatar!),
                                                height: 44,
                                                width: 44,
                                                fit: BoxFit.cover,
                                              )
                                              : SizedBox(height: 44, width: 44),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        widget.influencer.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: AppColors.green[25],
                                          height: 28 / 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomDropDown(
                        options: ["Soft Reminder", "Hard Reminder"],
                        initialPick: 0,
                        hintText: "Notification Type",
                        onChanged: (p0) {
                          if (p0 == "Soft Reminder") {
                            type = "SOFT";
                          } else if (p0 == "Hard Reminder") {
                            type = "HARD";
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: "Notification Title",
                        controller: title,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: "Notification Body",
                        controller: body,
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            forLater = !forLater;
                          });
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                                forLater
                                    ? AppColors.red[100]
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.green[400]!),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomSvg(
                                asset: AppIcons.clock,
                                size: 16,
                                color:
                                    forLater
                                        ? AppColors.red[500]
                                        : AppColors.red[300],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Schedule for Later",
                                style: TextStyle(
                                  color:
                                      forLater
                                          ? AppColors.red[500]
                                          : AppColors.green[200],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (forLater)
                        Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050),
                                    );

                                    if (pickedDate != null) {
                                      setState(() {
                                        date = pickedDate;
                                      });
                                    }
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    height: 52,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.green[400]!,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        CustomSvg(
                                          asset: AppIcons.calendar,
                                          size: 16,
                                          color: AppColors.red[400],
                                        ),
                                        const SizedBox(width: 8),
                                        date == null
                                            ? Text(
                                              "Pick Date",
                                              style: TextStyle(
                                                color: AppColors.green[200],
                                              ),
                                            )
                                            : Text(
                                              Formatter.dateFormatter(date!),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                          context: context,
                                          initialTime: time ?? TimeOfDay.now(),
                                        );

                                    if (pickedTime != null) {
                                      setState(() {
                                        time = pickedTime;
                                      });
                                    }
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    height: 52,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.green[400]!,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        CustomSvg(
                                          asset: AppIcons.clock,
                                          size: 16,
                                          color: AppColors.red[400],
                                        ),
                                        const SizedBox(width: 8),
                                        time == null
                                            ? Text(
                                              "Pick Time",
                                              style: TextStyle(
                                                color: AppColors.green[200],
                                              ),
                                            )
                                            : Text(
                                              Formatter.timeFormatter(
                                                time: time!,
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 40),

                      Obx(
                        () => CustomButton(
                          text: "Send",
                          isLoading: sub.notificationLoading.value,
                          leading: "assets/icons/notification/send.svg",
                          onTap: onCallback,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
