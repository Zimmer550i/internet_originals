import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/manager_controller.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_image_picker.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_networked_image.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/views/screens/manager/campaign/manager_performance_metrics_confirmation.dart';

class ManagerPerformanceMetrics extends StatefulWidget {
  final CampaignModel campaign;
  const ManagerPerformanceMetrics({super.key, required this.campaign});

  @override
  State<ManagerPerformanceMetrics> createState() =>
      _ManagerPerformanceMetricsState();
}

class _ManagerPerformanceMetricsState extends State<ManagerPerformanceMetrics> {
  final manager = Get.find<ManagerController>();
  List<TextEditingController> controllers = [];
  List<String> titles = [];
  File? _imageFile;

  @override
  void initState() {
    super.initState();

    titles = widget.campaign.expectedMetrics?.keys.toList() ?? [];
    for (var title in titles) {
      controllers.add(
        TextEditingController(
          text: widget.campaign.matrix?[title].toString() ?? "",
        ),
      );
    }
  }

  void uploadData() async {
    Map<String, dynamic> data = {};

    if (_imageFile != null) {
      data["screenshot"] = _imageFile;
    }

    data['campaignId'] = widget.campaign.id;
    data['influencerId'] = widget.campaign.influencerId;

    for (int i = 0; i < titles.length; i++) {
      data[titles[i]] = int.parse(controllers[i].text);
    }

    final message = await manager.uploadMatrix(widget.campaign.id, data);

    if (message == "success") {
      Get.to(
        () => ManagerPerformanceMetricsConfirmation(campaign: widget.campaign),
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
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.green[600],
                              border: Border.all(color: AppColors.green[400]!),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child:
                                _imageFile == null &&
                                        widget.campaign.screenshot != null
                                    ? CustomNetworkedImage(
                                      url:
                                          ApiService().baseUrl +
                                          widget.campaign.screenshot!,
                                      height: 90,
                                      fit: BoxFit.fitWidth,
                                    )
                                    : _imageFile != null
                                    ? Image.file(
                                      _imageFile!,
                                      height: 90,
                                      fit: BoxFit.fitWidth,
                                    )
                                    : Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 24,
                                      ),
                                      child: Column(
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
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => CustomButton(
                            text: "Submit",
                            isLoading: manager.campaignLoading.value,
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
        CustomNetworkedImage(
          url: ApiService().baseUrl + widget.campaign.banner,
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
