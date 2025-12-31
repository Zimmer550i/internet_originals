import 'package:flutter/material.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/views/base/campaign_card.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';

class TalentCampaignDetails extends StatelessWidget {
  final CampaignModel campaign;
  const TalentCampaignDetails({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Campaign Details"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                CampaignCard(isDetailed: true, campaign: campaign),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
