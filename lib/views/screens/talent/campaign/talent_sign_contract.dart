import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_image_picker.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_campaign_acceptance.dart';

class TalentSignContract extends StatefulWidget {
  const TalentSignContract({super.key});

  @override
  State<TalentSignContract> createState() => _TalentSignContractState();
}

class _TalentSignContractState extends State<TalentSignContract>  {
  bool agreedToTerms = false;
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Review & Sign the Agreement"),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Please read and confirm participation",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.green[600],
                      border: Border.all(color: AppColors.green[400]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet consectetur. Lacus at venenatis gravida vivamus mauris. Quisque mi est vel dis. Donec rhoncus laoreet odio orci sed risus elit accumsan. Mattis ut est tristique amet vitae at aliquet. Ac vel porttitor egestas scelerisque enim quisque senectus. Euismod ultricies vulputate id cras bibendum sollicitudin proin odio bibendum. Velit velit in scelerisque erat etiam rutrum phasellus nunc. Sed lectus sed a at et eget. Nunc purus sed quis at risus.",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.green[100],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          splashRadius: 50,
                          side: BorderSide(color: AppColors.red[50]!, width: 2),
                          value: agreedToTerms,
                          activeColor: AppColors.red,
                          onChanged: (val) {
                            setState(() {
                              agreedToTerms = val!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Text(
                          "I have read and agree to the terms of this contract.",
                          style: TextStyle(fontSize: 14, height: 24 / 14),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Align(
                    child: GestureDetector(
                      onTap: () async {
                        var image = await customImagePicker(
                          isCircular: false,
                          isSquared: false,
                        );

                        if (image != null) {
                          setState(() {
                            _imageFile = File(image.path);
                          });
                        } else {
                          setState(() {
                            _imageFile = null;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
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
                                  fit: BoxFit.fitHeight,
                                )
                                : Column(
                                  children: [
                                    CustomSvg(asset: AppIcons.signature),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Upload Sign Image",
                                      style: TextStyle(
                                        color: AppColors.green[100],
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Align(
                    child: CustomButton(
                      text: "Sign & Confirm Participation",
                      width: null,
                      onTap: () {
                        Get.to(() => TalentCampaignAcceptance());
                      },
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
}
