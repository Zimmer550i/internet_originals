import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_image_picker.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_performance_metrics_confirmation.dart';

class TalentPerformanceMetrics extends StatefulWidget {
  final CampaignModel campaign;
  const TalentPerformanceMetrics({super.key, required this.campaign});

  @override
  State<TalentPerformanceMetrics> createState() =>
      _TalentPerformanceMetricsState();
}

class _TalentPerformanceMetricsState extends State<TalentPerformanceMetrics> {
  final talent = Get.find<TalentController>();
  List<TextEditingController> controllers = [];
  List<String> titles = [];
  File? _imageFile;

  @override
  void initState() {
    super.initState();

    titles = widget.campaign.expectedMetrics?.keys.toList() ?? [];
    for (var _ in titles) {
      controllers.add(TextEditingController());
    }
  }

  void uploadData() async {
    Map<String, dynamic> data = {};

    if (_imageFile != null) {
      data["screenshot"] = _imageFile;
    }

    for (int i = 0; i < titles.length; i++) {
      data[titles[i]] = int.parse(controllers[i].text);
    }

    final message = await talent.uploadMatrix(widget.campaign.id, data);

    if (message == "success") {
      Get.to(
        () =>
            TalentPerformanceMetricsConfirmation(title: widget.campaign.title),
      );
    } else {
      showSnackBar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Performence Metrics"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Text(
                    "Enter your post engagement metrics manually",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.green[600],
                      border: Border.all(color: AppColors.green[400]!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      spacing: 16,
                      children: [
                        header(),
                        for (int i = 0; i < titles.length; i++)
                          CustomTextField(
                            hintText: titles[i],
                            controller: controllers[i],
                            textInputType: TextInputType.number,
                          ),
                        GestureDetector(
                          onTap: () async {
                            final image = await customImagePicker(
                              isCircular: false,
                              isSquared: false,
                            );
                            setState(() {
                              _imageFile = image;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: _imageFile == null ? 24 : 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.green[600],
                              border: Border.all(color: AppColors.green[400]!),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child:
                                _imageFile != null
                                    ? Image.file(
                                      _imageFile!,
                                      height: 90,
                                      fit: BoxFit.fitWidth,
                                    )
                                    : Column(
                                      children: [
                                        CustomSvg(
                                          asset: AppIcons.addImage,
                                          size: 40,
                                          color: AppColors.green[100],
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          "Upload Insights Screenshot",
                                          style: TextStyle(
                                            color: AppColors.green[100],
                                          ),
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => CustomButton(
                            text: "Submit",
                            isLoading: talent.campaignLoading.value,
                            width: null,
                            onTap: () {
                              uploadData();
                            },
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
      ),
    );
  }

  Row header() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.network(
            ApiService().baseUrl + widget.campaign.banner,
            height: 44,
            width: 44,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.campaign.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: "Open-Sans",
                  color: AppColors.green[25],
                ),
              ),
              Text(
                widget.campaign.brand,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Open-Sans",
                  color: AppColors.green[25],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
