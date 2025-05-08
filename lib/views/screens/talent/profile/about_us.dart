import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String? aboutUs;
  final talent = Get.find<TalentController>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final text = await talent.getPolicies('about');
    setState(() {
      aboutUs = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Privacy Policy'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                'About Us',
                style: TextStyle(
                  color: AppColors.dark[50],
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.dark[600],
                  border: Border.all(color: AppColors.dark[400]!, width: 2),
                ),
                child: Obx(() {
                  if (talent.isLoading.value) {
                    return CustomLoading();
                  } else if (aboutUs == null) {
                    return Text(
                      "Error loading data",
                      style: TextStyle(color: AppColors.red),
                    );
                  } else {
                    return Text(
                      aboutUs!,
                      style: TextStyle(
                        color: AppColors.dark[100],
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    );
                  }
                }),
              ),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
