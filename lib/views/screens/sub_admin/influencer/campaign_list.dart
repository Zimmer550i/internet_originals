import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/campaign_card.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';

class CampaignList extends StatefulWidget {
  final UserModel influencer;
  const CampaignList({super.key, required this.influencer});

  @override
  State<CampaignList> createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
  final sub = Get.find<SubAdminController>();
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sub.getCampaigns().then((message) {
      if (message != "success") {
        showSnackBar(message);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        sub
            .getCampaigns(searchText: searchController.text, loadMore: true)
            .then((message) {
              if (message != "success") {
                showSnackBar(message);
              }
            });
      }
    });
  }

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
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              CustomSearchBar(
                hintText: 'Search Campaigns by name',
                controller: searchController,
                onChanged: (val) {
                  sub.getCampaigns(searchText: val).then((message) {
                    if (message != "success") {
                      showSnackBar(message);
                    }
                  });
                },
              ),
              Obx(
                () => Column(
                  children: [
                    for (var i in sub.campaigns)
                      Padding(
                        padding: EdgeInsets.only(top: 18),
                        child: CampaignCard(
                          campaign: i,
                          influencer: widget.influencer,
                        ),
                      ),
                    if (sub.campaignLoading.value)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CustomLoading()),
                      ),
                  ],
                ),
              ),
              // ..._campaigns.map((item) {
              //   return Padding(
              //     padding: const EdgeInsets.only(top: 18),
              //     child: CampaignCard(
              //       imageUrl: item['imageUrl'],
              //       title: item['title'],
              //       company: item['company'],
              //       amount: item['amount'],
              //     ),
              //   );
              // }),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
