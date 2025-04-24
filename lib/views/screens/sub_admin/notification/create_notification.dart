import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_drop_down.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';

class CreateNotification extends StatefulWidget {
  final int? initialPick;
  final String? title;
  final String? body;
  const CreateNotification({
    super.key,
    this.initialPick,
    this.title,
    this.body,
  });

  @override
  State<CreateNotification> createState() => _CreateNotificationState();
}

class _CreateNotificationState extends State<CreateNotification> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title ?? "";
    bodyController.text = widget.body ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title == null ? "Create New Template" : "Edit Template",
      ),
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
                    spacing: 16,
                    children: [
                      CustomDropDown(
                        options: ['Soft Notification', 'Hard Notification'],
                        initialPick: widget.initialPick,
                        onChanged: (p0) {},
                      ),
                      CustomTextField(hintText: "Notificaiton Title"),
                      CustomTextField(hintText: "Notificaiton Body"),
                      const SizedBox(height: 12),
                      CustomButton(
                        text: "Save",
                        onTap: () {
                          Get.back();
                        },
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
