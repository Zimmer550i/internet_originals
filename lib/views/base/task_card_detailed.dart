import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/talent/home/talent_pending_task_completion.dart';

class TaskCardDetailed extends StatefulWidget {
  final String title;
  final String brandName;
  final String imageLink;
  final DateTime deadline;
  final String details;
  final Map<String, String> requiredMatrics;
  const TaskCardDetailed({
    super.key,
    required this.title,
    required this.brandName,
    required this.imageLink,
    required this.deadline,
    required this.details,
    required this.requiredMatrics,
  });

  @override
  State<TaskCardDetailed> createState() => _TaskCardDetailedState();
}

class _TaskCardDetailedState extends State<TaskCardDetailed> {
  bool isUploading = false;
  List<String> matrics = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.requiredMatrics.length; i++) {
      matrics.add(widget.requiredMatrics.values.elementAt(i));
      matrics.add(widget.requiredMatrics.keys.elementAt(i));
      if (i != widget.requiredMatrics.length - 1) {
        matrics.add("|");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.network(
                  widget.imageLink,
                  height: 44,
                  width: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Text(widget.brandName, style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          Text(
            widget.details,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.left,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  "${widget.deadline.difference(DateTime.now()).inDays.toString()} Days Left",
                  style: TextStyle(color: AppColors.red[900], fontSize: 14),
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
                    matrics
                        .map(
                          (val) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
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
            CustomTextField(hintText: "Post Link", controller: controller),

          Align(
            alignment: Alignment.center,
            child: CustomButton(
              text: isUploading ? "Submit" : "Upload Link",
              width: null,
              textSize: 14,
              height: null,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              onTap: () {
                if (isUploading && controller.text != "") {
                  Get.to(() => TalentPendingTaskCompletion());
                } else {
                  setState(() {
                    isUploading = !isUploading;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
