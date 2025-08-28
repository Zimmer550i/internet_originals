import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class PaymentTerms extends StatefulWidget {
  final CampaignModel campaign;
  const PaymentTerms({super.key, required this.campaign});

  @override
  State<PaymentTerms> createState() => _PaymentTermsState();
}

class _PaymentTermsState extends State<PaymentTerms> {
  bool _agreed = false;

  final String termsService =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum \nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Terms & Conditions'),
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
                'Please read and accept the payment agreements',
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
                child: Text(
                  termsService,
                  style: TextStyle(
                    color: AppColors.dark[100],
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: _agreed,
                    onChanged: (value) {
                      setState(() {
                        _agreed = value ?? false;
                      });
                    },
                    fillColor: WidgetStatePropertyAll(Colors.white),
                    overlayColor: WidgetStatePropertyAll(Colors.pink),
                  ),
                  Text(
                    'I agree to the Terms & Conditions.',
                    style: TextStyle(
                      color: AppColors.dark[50],
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => CustomButton(
                      text: 'Accept & Send Copy',
                      width: null,
                      isDisabled: !_agreed,
                      isLoading:
                          Get.find<TalentController>().paymentLoading.value,
                      height: 40,
                      onTap: () {
                        if (_agreed) {
                          Get.find<TalentController>()
                              .requestForPayment(widget.campaign.id, null)
                              .then((message) {
                                if (message == "success") {
                                  Get.toNamed(AppRoutes.cashPaymentSubmitted);
                                } else {
                                  showSnackBar(message);
                                }
                              });
                        }
                      },
                      textSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
