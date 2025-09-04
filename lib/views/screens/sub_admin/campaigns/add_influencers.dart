import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';
import 'package:internet_originals/views/base/influencer_card.dart';

class AddInfluencers extends StatefulWidget {
  final CampaignModel campaign;
  const AddInfluencers({super.key, required this.campaign});

  @override
  State<AddInfluencers> createState() => _AddInfluencersState();
}

class _AddInfluencersState extends State<AddInfluencers> {
  final sub = Get.find<SubAdminController>();

  @override
  void initState() {
    super.initState();
    sub.getInfluencers().then((message) {
      if (message != "success") {
        showSnackBar(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Influencers"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 12),
              child: CustomSearchBar(
                hintText: "Search by name or social handle",
              ),
            ),
            Expanded(
              child: Obx(
                () =>
                    sub.influencerLoading.value
                        ? CustomLoading()
                        : ListView.builder(
                          itemCount: sub.influencers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: InfluencerCard(
                                influencer: sub.influencers.elementAt(index),
                                campaign: widget.campaign,
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}