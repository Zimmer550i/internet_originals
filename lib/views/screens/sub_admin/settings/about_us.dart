import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_loading.dart';

class AdminAboutUs extends StatefulWidget {
  const AdminAboutUs({super.key});

  @override
  State<AdminAboutUs> createState() => _AdminAboutUsState();
}

class _AdminAboutUsState extends State<AdminAboutUs> {
  final subAdmin = Get.find<SubAdminController>();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fetchData() async {
    final text = await subAdmin.getPolicies("about");
    if (text != null) {
      setState(() {
        _controller.text = text;
      });
    }
  }

  void updateData() async {
    await subAdmin.updatePolicies("about", _controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'About Us'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18),
            Text(
              'About Us',
              style: TextStyle(
                color: AppColors.dark[50],
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.dark[600],
                      border: Border.all(color: AppColors.dark[400]!, width: 2),
                    ),
                    child: Obx(() {
                      if (subAdmin.isLoading.value) {
                        return CustomLoading();
                      } else {
                        return TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          maxLines: null,
                          enabled: _enabled,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB8BDBF),
                          ),
                          cursorColor: AppColors.red,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: "Write here...",
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Obx(() {
                return CustomButton(
                  text: _enabled ? 'Update' : 'Edit',
                  isSecondary: !_enabled || subAdmin.isLoading.value,
                  isLoading: subAdmin.isLoading.value,
                  onTap: () {
                    setState(() {
                      _enabled = !_enabled;
                    });
                    if (_enabled) {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        _focusNode.requestFocus();
                      });
                    } else {
                      updateData();
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
