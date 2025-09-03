import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/base/influencer_card.dart';

class InfluencerHome extends StatefulWidget {
  const InfluencerHome({super.key});

  @override
  State<InfluencerHome> createState() => _InfluencerHomeState();
}

class _InfluencerHomeState extends State<InfluencerHome> {
  int selectedOption = 0;
  final sub = Get.find<SubAdminController>();

  @override
  void initState() {
    super.initState();
    sub.getInfluencers(getPending: true).then((message) {
      if (message != "success") {
        showSnackBar(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeBar(isHome: false),
      backgroundColor: AppColors.green[700],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 12),
              CustomTabBar(
                options: ['Pending', 'Approved'],
                onChange: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                  sub.getInfluencers(getPending: selectedOption == 0).then((
                    message,
                  ) {
                    if (message != "success") {
                      showSnackBar(message);
                    }
                  });
                },
              ),
              SizedBox(height: 12),
              if (selectedOption == 1)
                CustomSearchBar(
                  hintText: 'Search by name or social handle',
                  onChanged: (val) {
                    sub
                        .getInfluencers(
                          getPending: selectedOption == 0,
                          searchText: val,
                        )
                        .then((message) {
                          if (message != "success") {
                            showSnackBar(message);
                          }
                        });
                  },
                ),

              Obx(
                () =>
                    sub.influencerLoading.value
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomLoading(),
                        )
                        : sub.influencers.isEmpty
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "No influencers available",
                            style: TextStyle(color: AppColors.green.shade100),
                          ),
                        )
                        : Column(
                          children: [
                            for (var i in sub.influencers)
                              Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: InfluencerCard(influencer: i),
                              ),
                          ],
                        ),
              ),
              // if (selectedOption == 1)
              //   ...approved.map((item) {
              //     return Padding(
              //       padding: const EdgeInsets.only(top: 12),
              //       child: ApprovedInfluencerItem(
              //         name: item['name'],
              //         avatar: item['avatar'],
              //         followers: item['followers'],
              //         rating: item['rating'],
              //         username: item['username'],
              //       ),
              //     );
              //   }),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
