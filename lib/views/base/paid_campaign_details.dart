import 'package:flutter/material.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_networked_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PaidCampaignDetails extends StatefulWidget {
  final CampaignModel campaign;

  const PaidCampaignDetails({super.key, required this.campaign});

  @override
  State<PaidCampaignDetails> createState() => _PaidCampaignDetailsState();
}

class _PaidCampaignDetailsState extends State<PaidCampaignDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Paid Campaign Details'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Container(
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
                      CustomNetworkedImage(
                        url: ApiService().baseUrl + widget.campaign.banner,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.campaign.title,
                              style: TextStyle(
                                color: AppColors.dark[50],
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.campaign.brand,
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
                    widget.campaign.title,
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
                        'Due Date: ${widget.campaign.payoutDeadline}',
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
                    children: [
                      Text(
                        'Performance:',
                        style: TextStyle(
                          color: AppColors.dark[50],
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      if (widget.campaign.postLink != null)
                        GestureDetector(
                          onTap: () async {
                            final url = Uri.parse(widget.campaign.postLink!);
                            if (await canLaunchUrl(url)) {
                              launchUrl(url);
                            }
                          },
                          child: Text(
                            'Link',
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationThickness: 3,
                              decorationColor: AppColors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  for (var i
                      in (widget.campaign.matrix as Map<String, dynamic>)
                          .entries)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '${i.key}: ${i.value}',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),

                  if (widget.campaign.screenshot != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Screenshot:',
                          style: TextStyle(
                            color: AppColors.dark[50],
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () async {
                            final url = Uri.parse(widget.campaign.screenshot!);
                            if (await canLaunchUrl(url)) {
                              launchUrl(url);
                            }
                          },
                          child: CustomNetworkedImage(
                            url:
                                ApiService().baseUrl +
                                widget.campaign.screenshot!,
                            height: 80,
                            width: double.infinity,
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
    );
  }
}
