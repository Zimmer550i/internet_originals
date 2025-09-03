import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/sub_admin/campaigns/new_campaign.dart';

class CreateNewCampaign extends StatefulWidget {
  final CampaignModel? campaign;
  const CreateNewCampaign({super.key, this.campaign});

  @override
  State<CreateNewCampaign> createState() => _CreateNewCampaignState();
}

class _CreateNewCampaignState extends State<CreateNewCampaign> {
  final sub = Get.find<SubAdminController>();

  TextEditingController titleController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController contentTypeController = TextEditingController();
  TextEditingController campaignTypeController = TextEditingController();
  TextEditingController paymentController = TextEditingController();

  // DateTime? campaignStart;
  DateTime? campaignEnd;

  File? imageFile;

  List<TextEditingController> controllers = [];
  List<String> titles = [];
  List<TextEditingController> metricsControllers = [TextEditingController()];
  List<String> metricsTitles = ["Views"];

  @override
  void initState() {
    super.initState();
    if (widget.campaign != null) {
      titleController.text = widget.campaign!.title;
      brandNameController.text = widget.campaign!.brand;
      descriptionController.text = widget.campaign!.description;
      budgetController.text = widget.campaign!.budget.toString();
      contentTypeController.text = widget.campaign!.contentType;
      campaignTypeController.text = widget.campaign!.campaignType;
      paymentController.text = widget.campaign!.payoutDeadline;

      campaignEnd = widget.campaign!.duration;

      metricsControllers.clear();
      metricsTitles.clear();

      for (var i in widget.campaign!.expectedMetrics!.entries) {
        metricsTitles.add(i.key);
        metricsControllers.add(TextEditingController(text: i.value));
      }

      for (var i in widget.campaign!.otherFields!.entries) {
        titles.add(i.key);
        controllers.add(TextEditingController(text: i.value));
      }
    }
  }

  void onCreate() async {
    if (!validateInputs()) {
      showSnackBar("Please fill up all the fields");
      return;
    }

    Map<String, String> expectedMetrics = {};
    for (int i = 0; i < metricsTitles.length; i++) {
      expectedMetrics[metricsTitles[i]] = metricsControllers[i].text;
    }
    Map<String, String> otherFields = {};
    for (int i = 0; i < titles.length; i++) {
      otherFields[titles[i]] = controllers[i].text.trim();
    }
    final message = await sub.createCampaign(
      titleController.text,
      descriptionController.text,
      brandNameController.text,
      imageFile!,
      campaignTypeController.text,
      double.parse(budgetController.text),
      campaignEnd!,
      contentTypeController.text,
      paymentController.text,
      expectedMetrics,
      otherFields,
    );

    if (message == "success") {
      Get.to(() => NewCampaign(campaign: sub.singleCampaign.value!));
    } else {
      showSnackBar(message);
    }
  }

  void onUpdate() async {
    if (!validateInputs(skipImage: true)) {
      showSnackBar("Please fill up all the fields");
      return;
    }

    Map<String, String> expectedMetrics = {};
    for (int i = 0; i < metricsTitles.length; i++) {
      expectedMetrics[metricsTitles[i]] = metricsControllers[i].text;
    }
    Map<String, String> otherFields = {};
    for (int i = 0; i < titles.length; i++) {
      otherFields[titles[i]] = controllers[i].text.trim();
    }
    final message = await sub.updateCampaign(
      widget.campaign!.id,
      titleController.text,
      descriptionController.text,
      brandNameController.text,
      imageFile,
      campaignTypeController.text,
      double.parse(budgetController.text),
      campaignEnd!,
      contentTypeController.text,
      paymentController.text,
      expectedMetrics,
      otherFields,
    );

    if (message == "success") {
      // ignore: use_build_context_synchronously
      if (Navigator.canPop(context)) {
        Get.back();
      }
      showSnackBar("Campaign updated successfully", isError: false);
    } else {
      showSnackBar(message);
    }
  }

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
                              : widget.campaign != null
                              ? "Update picture"
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
                    ),
                    CustomTextField(
                      hintText: "Campaign Type",
                      controller: campaignTypeController,
                    ),
                    CustomTextField(
                      hintText: "Campaign Description",
                      controller: descriptionController,
                    ),
                    CustomTextField(
                      hintText: "Campaign Budget",
                      controller: budgetController,
                      textInputType: TextInputType.number,
                    ),
                    // CustomTextField(
                    //   isDisabled: true,
                    //   trailing: AppIcons.calendar,
                    //   trailingColor: AppColors.red[400],
                    //   onTap: () async {
                    //     final DateTime? date = await showDatePicker(
                    //       context: context,
                    //       initialDate: campaignStart ?? DateTime.now(),
                    //       firstDate: DateTime(2000),
                    //       lastDate: DateTime(2050),
                    //     );

                    //     if (date != null && date != campaignStart) {
                    //       setState(() {
                    //         campaignStart = date;
                    //       });
                    //     }
                    //   },
                    //   hintText:
                    //       campaignStart == null
                    //           ? "Campaign Start"
                    //           : Formatter.dateFormatter(campaignStart!),
                    // ),
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
                      hintText: "Payment Deadline (Ex: in 90 days)",
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
                              textInputType: TextInputType.number,
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
                    CustomTextField(hintText: "Add notes...", lines: 5),
                    const SizedBox(height: 16),
                    Obx(
                      () => CustomButton(
                        text:
                            widget.campaign == null
                                ? "Launch Campaign"
                                : "Update",
                        isLoading: sub.campaignLoading.value,
                        onTap: widget.campaign == null ? onCreate : onUpdate,
                      ),
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

  bool validateInputs({bool skipImage = false}) {
    if (titleController.text.trim().isEmpty) return false;
    if (brandNameController.text.trim().isEmpty) return false;
    if (descriptionController.text.trim().isEmpty) return false;
    if (budgetController.text.trim().isEmpty) return false;
    if (contentTypeController.text.trim().isEmpty) return false;
    if (campaignTypeController.text.trim().isEmpty) return false;
    if (paymentController.text.trim().isEmpty) return false;
    if (campaignEnd == null) return false;
    if (!skipImage && imageFile == null) return false;

    return true;
  }
}
