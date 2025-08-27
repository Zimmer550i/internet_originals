import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/helpers/route.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/views/base/custom_button.dart';

enum PendingPaymentItemStatus { pending, sent }

class PendingPaymentItem extends StatefulWidget {
  final CampaignModel campaign;

  const PendingPaymentItem({super.key, required this.campaign});

  @override
  State<PendingPaymentItem> createState() => _PendingPaymentItemState();
}

class _PendingPaymentItemState extends State<PendingPaymentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.dark[600],
        border: Border.all(color: AppColors.dark[400]!, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          ),
          const SizedBox(height: 10),
          Text(
            widget.campaign.description,
            style: TextStyle(
              color: AppColors.dark[50],
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSvg(
                asset: 'assets/icons/payments/tag.svg',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 8),
              Text(
                '\$${widget.campaign.budget}',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSvg(
                asset: 'assets/icons/payments/calender.svg',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 8),
              Text(
                'Due Date: ${Formatter.prettyDate(widget.campaign.duration.millisecondsSinceEpoch)}',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSvg(
                asset: 'assets/icons/payments/warning_circle.svg',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Expected Payout: ',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: widget.campaign.payoutDeadline,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
           
            Center(
              child: (widget.campaign.paymentStatus == "PENDING") ? CustomButton(
                text: 'Send Payment Request',
                onTap: () {
                  Get.toNamed(AppRoutes.paymentSelection);
                },
                width: null,
                textSize: 14,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ) : 
              
              CustomButton(
                width: null,
                textSize: 14,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                text: 'View Report',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Container();
                        // return PaidCampaignDetails(
                        //   imageUrl: widget.imageUrl,
                        //   title: widget.title,
                        //   company: widget.company,
                        //   amount: widget.amount,
                        //   paidOn: widget.paidOn,
                        // );
                      },
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
