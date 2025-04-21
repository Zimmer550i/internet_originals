import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';
import 'package:internet_originals/views/screens/sub_admin/influencer/campaign_assigned.dart';

class CampaignList extends StatefulWidget {
  const CampaignList({super.key});

  @override
  State<CampaignList> createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
  final List<Map<String, dynamic>> _campaigns = [
    {
      "imageUrl": "https://picsum.photos/200/200",
      "title": "Nike Air Max Campaign",
      "company": "Nike",
      "amount": 300,
    },
    {
      "imageUrl": "https://picsum.photos/200/200",
      "title": "McDonalds Campaign",
      "company": "McDonalds",
      "amount": 200,
    },
    {
      "imageUrl": "https://picsum.photos/200/200",
      "title": "Coca-Cola Campaign",
      "company": "Coca-Cola",
      "amount": 500,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Campaign List'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              CustomSearchBar(hintText: 'Search Campaigns by name'),
              ..._campaigns.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: CampaignCard(
                    imageUrl: item['imageUrl'],
                    title: item['title'],
                    company: item['company'],
                    amount: item['amount'],
                  ),
                );
              }),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}

class CampaignCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String company;
  final int amount;

  const CampaignCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.company,
    required this.amount,
  });

  @override
  State<CampaignCard> createState() => _CampaignCardState();
}

class _CampaignCardState extends State<CampaignCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.green[600],
        border: Border.all(color: AppColors.green[400]!),
      ),
      child: Column(
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
          const SizedBox(height: 18),
          Text(
            'Promote event on instagram',
            style: TextStyle(
              color: AppColors.dark[50],
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Metrics Needed: 10K+ Views, 1,500+ Likes & 300+ Shares',
            style: TextStyle(
              color: AppColors.dark[50],
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
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
              Text(
                ' (Within 60 days of completion)',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Center(
            child: CustomButton(
              text: "Assign",
              width: null,
              textSize: 14,
              height: 36,
              onTap: () {
                showCampaignAssignModal(
                  context: context,
                  campaignName: widget.title,
                  campaignImage: widget.imageUrl,
                  influencerImage: 'https://picsum.photos/200/200',
                  influencerName: 'John Doe',
                  onConfirm: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CampaignAssigned(
                            campaignName: widget.title,
                            campaignImage: widget.imageUrl,
                            influencerName: 'John Doe',
                            influencerImage: 'https://picsum.photos/200/200',
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

showCampaignAssignModal({
  required BuildContext context,
  required String influencerName,
  required String influencerImage,
  required String campaignName,
  required String campaignImage,
  Function()? onConfirm,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    elevation: 0,
    builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {
                // Do nothing here, this prevents the gesture detector of the whole container
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 36,
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.dark[600],
                  border: Border.all(color: AppColors.dark[400]!, width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      'Are you sure you want to assign',
                      style: TextStyle(
                        color: AppColors.dark[50],
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.network(
                            influencerImage,
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          influencerName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'to',
                          style: TextStyle(
                            color: AppColors.dark[50],
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.network(
                            campaignImage,
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          campaignName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 36),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Cancel',
                            isSecondary: true,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            text: 'Confirm',
                            onTap: () {
                              Navigator.of(context).pop();
                              onConfirm?.call();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
