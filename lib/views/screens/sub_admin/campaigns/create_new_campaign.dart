import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/sub_admin/campaigns/new_campaign.dart';

class CreateNewCampaign extends StatefulWidget {
  const CreateNewCampaign({super.key});

  @override
  State<CreateNewCampaign> createState() => _CreateNewCampaignState();
}

class _CreateNewCampaignState extends State<CreateNewCampaign> {
  TextEditingController titleController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController contentTypeController = TextEditingController();
  TextEditingController paymentController = TextEditingController();

  DateTime? campaignStart;
  DateTime? campaignEnd;

  File? imageFile;

  List<TextEditingController> controllers = [];
  List<String> titles = [];
  List<TextEditingController> metricsControllers = [TextEditingController()];
  List<String> metricsTitles = ["Views"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create New Campaign"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.green[600],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.green[400]!),
                ),
                child: Column(
                  spacing: 16,
                  children: [
                    CustomTextField(
                      hintText: "Campaign Title",
                      controller: titleController,
                    ),
                    CustomTextField(
                      hintText: "Brand Name",
                      controller: brandNameController,
                    ),
                    CustomTextField(
                      trailing: AppIcons.addImage,
                      trailingColor: AppColors.red[400],
                      hintText:
                          imageFile != null
                              ? imageFile!.path.split('/').last
                              : "Select a Picture",
                      isDisabled: true,
                      onTap: () async {
                        ImagePicker picker = ImagePicker();
                        final file = await picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (file != null) {
                          setState(() {
                            imageFile = File(file.path);
                          });
                        } else {
                          setState(() {
                            imageFile = null;
                          });
                        }
                      },
                      controller: brandNameController,
                    ),
                    CustomTextField(
                      hintText: "Campaign Description",
                      controller: descriptionController,
                    ),
                    CustomTextField(
                      hintText: "Campaign Budget",
                      controller: budgetController,
                    ),
                    CustomTextField(
                      isDisabled: true,
                      trailing: AppIcons.calendar,
                      trailingColor: AppColors.red[400],
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: campaignStart ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        );

                        if (date != null && date != campaignStart) {
                          setState(() {
                            campaignStart = date;
                          });
                        }
                      },
                      hintText:
                          campaignStart == null
                              ? "Campaign Start"
                              : Formatter.dateFormatter(campaignStart!),
                    ),
                    CustomTextField(
                      isDisabled: true,
                      trailing: AppIcons.calendar,
                      trailingColor: AppColors.red[400],
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: campaignEnd ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        );

                        if (date != null && date != campaignEnd) {
                          setState(() {
                            campaignEnd = date;
                          });
                        }
                      },
                      hintText:
                          campaignEnd == null
                              ? "Campaign End"
                              : Formatter.dateFormatter(campaignEnd!),
                    ),
                    CustomTextField(
                      hintText: "Content Type",
                      controller: contentTypeController,
                    ),
                    CustomTextField(
                      hintText: "Payment Deadline in Text",
                      controller: paymentController,
                    ),
                    for (int i = 0; i < titles.length; i++)
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: titles[i],
                              controller: controllers[i],
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              setState(() {
                                titles.removeAt(i);
                                controllers.removeAt(i);
                              });
                            },
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.red[300]!),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 20,
                                  color: AppColors.red[300]!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => showAddNewDialog(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomSvg(asset: AppIcons.addSquare, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "Add New Field",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.red[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Expected Metrics",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    for (int i = 0; i < metricsTitles.length; i++)
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: metricsTitles[i],
                              controller: metricsControllers[i],
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              setState(() {
                                metricsTitles.removeAt(i);
                                metricsControllers.removeAt(i);
                              });
                            },
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.red[300]!),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 20,
                                  color: AppColors.red[300]!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => showAddNewDialog(isMetrics: true),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomSvg(asset: AppIcons.addSquare, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "Add New Field",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.red[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Admin Notes",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    CustomTextField(hintText: "Add notes...", lines: 5,),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: "Launch Campaign",
                      onTap: () {
                        Get.to(() => NewCampaign());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAddNewDialog({bool isMetrics = false}) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.green[600],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.green[400]!),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add New Field",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Enter Title",
                  controller: controller,
                  autoFocus: true,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        text: "Cancel",
                        width: null,
                        isSecondary: true,
                        onTap: () => Get.back(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        text: "Save",
                        width: null,
                        onTap: () {
                          String name = controller.text.trim();
                          if (isMetrics) {
                            metricsTitles.add(name);
                            metricsControllers.add(TextEditingController());
                          } else {
                            titles.add(name);
                            controllers.add(TextEditingController());
                          }
                          setState(() {
                            Get.back();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
