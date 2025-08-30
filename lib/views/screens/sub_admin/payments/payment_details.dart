import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/payment_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminPaymentDetails extends StatefulWidget {
  final PaymentModel payment;

  const AdminPaymentDetails({super.key, required this.payment});

  @override
  State<AdminPaymentDetails> createState() => _AdminPaymentDetailsState();
}

class _AdminPaymentDetailsState extends State<AdminPaymentDetails> {
  final sub = Get.find<SubAdminController>();
  late int starCount = widget.payment.influencerRating.toInt();

  @override
  void initState() {
    super.initState();
    sub.singlePayment.value = null;
    WidgetsBinding.instance.addPostFrameCallback((val) {
      sub.getSinglePayments(widget.payment.id).then((message) {
        if (message != "success") {
          showSnackBar(message);
        }
      });
    });
  }

  Widget _stars() {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          // onTap: () {
          //   setState(() {
          //     starCount = index + 1;
          //   });
          // },
          child: Icon(
            index < starCount ? Icons.star : Icons.star_border,
            color: index < starCount ? AppColors.red[400] : Colors.grey,
            size: 18,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Details'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SafeArea(
              child: Obx(
                () =>
                    sub.singlePayment.value == null
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomLoading(),
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 18),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.dark[600],
                                border: Border.all(
                                  color: AppColors.dark[400]!,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.network(
                                          ApiService().baseUrl +
                                              sub
                                                  .singlePayment
                                                  .value!
                                                  .influencerAvatar,
                                          width: 56,
                                          height: 56,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sub
                                                .singlePayment
                                                .value!
                                                .influencerName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          _stars(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Campaign: @${sub.singlePayment.value!.campaignName}',
                                    style: TextStyle(
                                      color: AppColors.green[50],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Amount: \$${Formatter.formatNumberMagnitude(sub.singlePayment.value!.amount.toDouble())}',
                                    style: TextStyle(
                                      color: AppColors.green[50],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 36),
                                  Text(
                                    'Performance Metrics',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  for (var i
                                      in sub
                                          .singlePayment
                                          .value!
                                          .matrix!
                                          .entries)
                                    DetailsItem(
                                      primaryText:
                                          "${i.key.substring(0, 1).toUpperCase() + i.key.substring(1)}: ${Formatter.formatNumberMagnitude(i.value.value.toDouble())}",
                                      secondaryText: "(Goal: ${i.value.goal})",
                                    ),
                                  if (sub.singlePayment.value!.postLink != null)
                                    InkWell(
                                      onTap: () {
                                        launchMyUrl(
                                          ApiService().baseUrl +
                                              sub
                                                  .singlePayment
                                                  .value!
                                                  .postLink!,
                                        );
                                      },
                                      child: DetailsItem(
                                        primaryText: 'View Link',
                                        primaryTextColor: AppColors.red[300],
                                        tailingIcon:
                                            'assets/icons/payments/arrow_tr.svg',
                                      ),
                                    ),
                                  if (sub.singlePayment.value!.screenshot !=
                                      null)
                                    DetailsItem(
                                      onTap: () {
                                        launchMyUrl(
                                          ApiService().baseUrl +
                                              sub
                                                  .singlePayment
                                                  .value!
                                                  .screenshot!,
                                        );
                                      },
                                      primaryText:
                                          'Download Insight Screenshot',
                                      primaryTextColor: AppColors.red[300],
                                      tailingIcon:
                                          'assets/icons/payments/arrow_down.svg',
                                    ),
                                  if (sub
                                      .singlePayment
                                      .value!
                                      .invoices
                                      .isNotEmpty)
                                    DetailsItem(
                                      onTap: () {
                                        for (var i
                                            in sub
                                                .singlePayment
                                                .value!
                                                .invoices) {
                                          launchMyUrl(ApiService().baseUrl + i);
                                        }
                                        for (var i
                                            in sub
                                                .singlePayment
                                                .value!
                                                .invoices) {
                                          launchMyUrl(ApiService().baseUrl + i);
                                        }
                                      },
                                      primaryText: 'Download Invoice',
                                      primaryTextColor: AppColors.red[300],
                                      tailingIcon:
                                          'assets/icons/payments/arrow_down.svg',
                                    ),
                                  const SizedBox(height: 36),
                                  if (sub.singlePayment.value!.status !=
                                      "PENDING")
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 24,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Approved!",
                                          style: TextStyle(
                                            color: AppColors.green.shade100,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),

                                  if (!sub.paymentLoading.value)
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomLoading(),
                                      ),
                                    ),

                                  if (sub.singlePayment.value!.status ==
                                      "PENDING")
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            text: 'Cancel',
                                            isSecondary: true,
                                            onTap: () {
                                              sub
                                                  .cancelPayment(
                                                    widget.payment.id,
                                                  )
                                                  .then((message) {
                                                    if (message == "success") {
                                                      Get.until((route) {
                                                        return Get
                                                                .currentRoute ==
                                                            AppRoutes
                                                                .subAdminApp;
                                                      });
                                                      showSnackBar(
                                                        "Payment has been canceled!",
                                                        isError: false,
                                                      );
                                                      sub.getPayments(
                                                        "PENDING",
                                                      );
                                                    } else {
                                                      showSnackBar(message);
                                                    }
                                                  });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: CustomButton(
                                            text: 'Approve',
                                            onTap: () {
                                              sub
                                                  .approvePayment(
                                                    widget.payment.id,
                                                  )
                                                  .then((message) {
                                                    if (message == "success") {
                                                      Get.until((route) {
                                                        return Get
                                                                .currentRoute ==
                                                            AppRoutes
                                                                .subAdminApp;
                                                      });
                                                      showSnackBar(
                                                        "Payment has Approved!",
                                                        isError: false,
                                                      );
                                                      sub.getPayments(
                                                        "PENDING",
                                                      );
                                                    } else {
                                                      showSnackBar(message);
                                                    }
                                                  });
                                            },
                                          ),
                                        ),
                                      ],
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
      ),
    );
  }
}

Future<void> launchMyUrl(String url) async {
  final Uri uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

class DetailsItem extends StatelessWidget {
  final String primaryText;
  final String? secondaryText;
  final String? tailingIcon;
  final Function()? onTap;
  final Color? primaryTextColor;

  const DetailsItem({
    super.key,
    required this.primaryText,
    this.secondaryText,
    this.primaryTextColor,
    this.tailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.dark[400]!, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              primaryText,
              style: TextStyle(
                color: primaryTextColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (tailingIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomSvg(asset: tailingIcon!, width: 28),
              ),
            if (secondaryText != null)
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  secondaryText!,
                  style: TextStyle(
                    color: AppColors.green[200],
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
