import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/models/notification_model.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/notification_widget.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final talent = Get.find<TalentController>();
  final sub = Get.find<SubAdminController>();
  final scrollController = ScrollController();
  late bool isTalent;

  @override
  void initState() {
    super.initState();
    isTalent =
        Get.find<UserController>().userInfo.value!.role == EUserRole.INFLUENCER;
    populateData();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        if (!(isTalent
            ? talent.notificationLoading.value
            : sub.notificationLoading.value)) {
          if (isTalent) {
            talent.getNotifications(getMore: true);
          } else {
            sub.getNotifications(getMore: true);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (isTalent) {
      talent.readAllNotifications();
    } else {
      sub.readAllNotifications();
    }
  }

  Map<DateTime, List<NotificationModel>> data = {};

  void populateData() {
    final l = isTalent ? talent.notifications : sub.notifications;

    for (var i in l) {
      final key = DateTime(
        i.createdAt.year,
        i.createdAt.month,
        i.createdAt.day,
      );

      if (data.containsKey(key)) {
        data[key]!.add(i);
      } else {
        data[key] = [i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifications"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                children: [
                  ...getNotifications(data),
                  Obx(
                    () =>
                        (isTalent
                                ? talent.notificationLoading.value
                                : sub.notificationLoading.value)
                            ? CustomLoading()
                            : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getNotifications(Map<DateTime, List<NotificationModel>> data) {
    List<Widget> rtn = [];

    final sortedKeys = data.keys.toList()..sort((a, b) => b.compareTo(a));

    for (var i in sortedKeys) {
      rtn.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              formatDate(i),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.green[25],
              ),
            ),
          ),
        ),
      );
      for (var j in data[i]!) {
        rtn.add(NotificationWidget(item: j, showBoarder: data[i]!.last == j));
      }
    }

    return rtn;
  }

  String formatDate(DateTime t) {
    final now = DateTime.now();
    final List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    if (t.year == now.year && t.month == now.month && t.day == now.day) {
      return "Today";
    } else if (t.year == now.year &&
        t.month == now.month &&
        now.day - t.day == 1) {
      return "Yesterday";
    } else if (t.year == now.year &&
        t.month == now.month &&
        t.day - now.day == 1) {
      return "Tomorrow";
    } else {
      return "${t.day} ${months[t.month - 1]} ${t.year}";
    }
  }
}
