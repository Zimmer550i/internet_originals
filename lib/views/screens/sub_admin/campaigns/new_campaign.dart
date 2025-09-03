import 'package:flutter/material.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/views/base/campaign_card.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';

class NewCampaign extends StatelessWidget {
  final CampaignModel campaign;
  const NewCampaign({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "New Campaign"),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "You just create a campaign",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CampaignCard(campaign: campaign, isDetailed: true,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
