import 'package:flutter/material.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_attachment.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:get/get.dart';

class SubmitInvoice extends StatefulWidget {
  const SubmitInvoice({super.key});

  @override
  State<SubmitInvoice> createState() => _SubmitInvoiceState();
}

class _SubmitInvoiceState extends State<SubmitInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Upload Invoice'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Text(
              'Submit your invoice',
              style: TextStyle(
                color: AppColors.dark[50],
                fontSize: 19,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.dark[600],
                border: Border.all(color: AppColors.dark[400]!, width: 1),
              ),
              child: Column(
                children: [
                  CustomAttachment(text: 'Attach file', onSelect: (file) {}),
                  CustomAttachment(
                    text: 'Attach file (optional)',
                    onSelect: (file) {},
                  ),
                  SizedBox(height: 36),
                  CustomButton(
                    text: 'Submit',
                    width: null,
                    height: 40,
                    onTap: () {
                      Get.toNamed(AppRoutes.invoiceSubmitted);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
