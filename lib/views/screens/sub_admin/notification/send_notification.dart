import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_drop_down.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/select_recipient.dart';

class SendNotification extends StatefulWidget {
  const SendNotification({super.key});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  bool forLater = false;
  DateTime? date;
  TimeOfDay? time;

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
                      CustomDropDown(
                        options: ["Soft Reminder", "Hard Reminder"],
                        hintText: "Notification Type",
                        onChanged: (p0) {},
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => Get.to(()=> SelectRecipient()),
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          height: 52,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.green[400]!),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text("Reciepents: "),
                              Text(
                                "0 Selected",
                                style: TextStyle(color: AppColors.red[300]),
                              ),
                              Spacer(),
                              Transform.rotate(
                                angle: 3.15,
                                child: CustomSvg(
                                  asset: AppIcons.arrowLeft,
                                  color: AppColors.green[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(hintText: "Notification Title"),
                      const SizedBox(height: 16),
                      CustomTextField(hintText: "Notification Body"),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColors.green[400]!,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomSvg(
                                      asset:
                                          "assets/icons/notification/template.svg",
                                      size: 16,
                                      color: AppColors.red[300],
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Use Template",
                                      style: TextStyle(
                                        color: AppColors.green[200],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: GestureDetector(
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
                                  border: Border.all(
                                    color: AppColors.green[400]!,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          ),
                        ],
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
                                    TimeOfDay? pickedTime = await showTimePicker(
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

                      CustomButton(
                        text: "Send",
                        leading: "assets/icons/notification/send.svg",
                        onTap: () => Get.to(() => SendNotification()),
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
