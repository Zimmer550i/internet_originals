import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/utils/formatter.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/screens/talent/payments/paid_campaign_details.dart';

class PaidPaymentItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String company;
  final int amount;
  final int paidOn;

  const PaidPaymentItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.company,
    required this.amount,
    required this.paidOn,
  });

  @override
  State<PaidPaymentItem> createState() => _PaidPaymentItemState();
}

class _PaidPaymentItemState extends State<PaidPaymentItem> {
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
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  widget.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: AppColors.dark[50],
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.company,
                      style: TextStyle(
                        color: AppColors.dark[50],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Promote event on instagram',
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
                '\$${widget.amount}',
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
                'Due Date: ${Formatter.prettyDate(widget.paidOn)}',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                width: null,
                textSize: 14,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                text: 'View Report',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return PaidCampaignDetails(
                          imageUrl: widget.imageUrl,
                          title: widget.title,
                          company: widget.company,
                          amount: widget.amount,
                          paidOn: widget.paidOn,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
