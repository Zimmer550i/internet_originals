import 'package:internet_originals/models/notification_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';

enum NotificationType { soft, hard, completed, decision, remindLater }

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({
    super.key,
    required this.item,
    required this.showBoarder,
  });

  final NotificationModel item;
  final bool showBoarder;

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  NotificationType status = NotificationType.soft;
  DateTime? date;
  TimeOfDay? time;

  @override
  void initState() {
    super.initState();
    if (widget.item.type == "HARD") {
      status = NotificationType.hard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: widget.item.status == "READ" ? null : AppColors.red[400],
          borderRadius: BorderRadius.circular(
            widget.item.status == "READ" ? 0 : 8,
          ),
          border: Border(
            bottom:
                widget.showBoarder
                    ? BorderSide(color: Colors.transparent)
                    : BorderSide(color: AppColors.green[400]!),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      widget.item.status == "READ"
                          ? AppColors.green[500]
                          : AppColors.red[300],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppIcons.bell,
                    colorFilter: ColorFilter.mode(
                      widget.item.status == "READ"
                          ? AppColors.red[300]!
                          : AppColors.red[25]!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color:
                          widget.item.status == "READ"
                              ? AppColors.green[50]
                              : Colors.white,
                    ),
                  ),
                  Text(
                    widget.item.body,
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          widget.item.status == "READ"
                              ? AppColors.green[100]
                              : Colors.white,
                    ),
                  ),
                  if (status == NotificationType.hard)
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () async {
                              setState(() {
                                status = NotificationType.completed;
                                Future.delayed(
                                  Duration(seconds: 3),
                                  () => setState(() {
                                    status = NotificationType.hard;
                                  }),
                                );
                              });
                            },
                            text: "Yes",
                            height: 26,
                            textSize: 12,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              setState(() {
                                status = NotificationType.decision;
                              });
                            },
                            text: "No",
                            height: 26,
                            textSize: 12,
                            isSecondary: true,
                          ),
                        ),
                      ],
                    ),
                  if (status == NotificationType.completed)
                    Center(
                      child: Text(
                        "Completed!",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color:
                              widget.item.status == "READ"
                                  ? AppColors.green[50]
                                  : Colors.white,
                        ),
                      ),
                    ),
                  if (status == NotificationType.decision)
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
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
                                  height: 28,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
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
                            const SizedBox(width: 16),
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
                                  height: 28,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
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
                        const SizedBox(height: 16),
                        CustomButton(
                          text: "Confirm Reminder Time",
                          height: 35,
                          width: null,
                          onTap: () {
                            if (date != null && time != null) {
                              setState(() {
                                status = NotificationType.remindLater;
                                date = DateTime(
                                  date!.year,
                                  date!.month,
                                  date!.day,
                                  time!.hour,
                                  time!.minute,
                                );
                              });
                              Future.delayed(
                                Duration(seconds: 3),
                                () => setState(() {
                                  status = NotificationType.hard;
                                }),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  if (status == NotificationType.remindLater)
                    Center(
                      child: Text(
                        "You will be reminded after ${date!.difference(DateTime.now()).inDays} days!",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color:
                              widget.item.status == "READ"
                                  ? AppColors.green[50]
                                  : Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
