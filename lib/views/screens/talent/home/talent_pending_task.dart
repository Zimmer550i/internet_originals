import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/models/task_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/talent/home/talent_pending_task_completion.dart';

class TalentPendingTask extends StatefulWidget {
  final TaskModel task;
  const TalentPendingTask({super.key, required this.task});

  @override
  State<TalentPendingTask> createState() => _TalentPendingTaskState();
}

class _TalentPendingTaskState extends State<TalentPendingTask> {
  final talent = Get.find<TalentController>();
  final TextEditingController controller = TextEditingController();
  bool isUploading = false;

  void submit() async {}

  List<String> formatMatrics() {
    List<String> matrics = [];

    for (int i = 0; i < widget.task.campaign.expectedMetrics!.length; i++) {
      matrics.add(widget.task.campaign.expectedMetrics!.values.elementAt(i));
      matrics.add(widget.task.campaign.expectedMetrics!.keys.elementAt(i));
      if (i != widget.task.campaign.expectedMetrics!.entries.length - 1) {
        matrics.add("|");
      }
    }

    return matrics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Pending Task"),
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
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.green[600],
                    border: Border.all(color: AppColors.green[400]!),
                  ),
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Image.network(
                                ApiService().baseUrl +
                                    widget.task.campaign.banner,
                                height: 44,
                                width: 44,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.task.campaign.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  widget.task.campaign.brand,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.task.campaign.description,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.red[200],
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomSvg(asset: AppIcons.clock),
                            const SizedBox(width: 4),
                            Text(
                              "${widget.task.campaign.duration.difference(DateTime.now()).inDays.toString()} Days Left",
                              style: TextStyle(
                                color: AppColors.red[900],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Required Matrics",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            children:
                                formatMatrics()
                                    .map(
                                      (val) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: Text(
                                          val,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      ),

                      if (isUploading)
                        CustomTextField(
                          hintText: "Post Link",
                          controller: controller,
                        ),

                      Obx(
                        () => Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                            text: isUploading ? "Submit" : "Upload Link",
                            isLoading: talent.taskLoading.value,
                            width: null,
                            textSize: 14,
                            height: null,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            onTap: () async {
                              if (isUploading && controller.text != "") {
                                final message = await talent.submitPostLink(
                                  widget.task.id,
                                  controller.text.trim(),
                                );

                                if (message == "success") {
                                  Get.to(() => TalentPendingTaskCompletion());
                                  showSnackBar(
                                    "Post submitter succesfully",
                                    isError: false,
                                  );
                                } else {
                                  showSnackBar(message);
                                }
                              } else {
                                setState(() {
                                  isUploading = !isUploading;
                                });
                              }
                            },
                          ),
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
