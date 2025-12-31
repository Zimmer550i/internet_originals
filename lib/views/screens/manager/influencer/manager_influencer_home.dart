import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/manager_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';
import 'package:internet_originals/views/base/custom_tab_bar.dart';
import 'package:internet_originals/views/base/home_bar.dart';
import 'package:internet_originals/views/base/influencer_card.dart';

class ManagerInfluencerHome extends StatefulWidget {
  const ManagerInfluencerHome({super.key});

  @override
  State<ManagerInfluencerHome> createState() => _ManagerInfluencerHomeState();
}

class _ManagerInfluencerHomeState extends State<ManagerInfluencerHome> {
  int selectedOption = 0;
  final manager = Get.find<ManagerController>();
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    manager.getInfluencers(selectedOption).then((message) {
      if (message != "success") {
        showSnackBar(message);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        manager
            .getInfluencers(
              selectedOption,
              searchText: searchController.text,
              loadMore: true,
            )
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
      appBar: HomeBar(isHome: false),
      backgroundColor: AppColors.green[700],
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 12),
              CustomTabBar(
                options: ['All', 'Connected'],
                onChange: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                  manager.getInfluencers(selectedOption).then((message) {
                    if (message != "success") {
                      showSnackBar(message);
                    }
                  });
                },
              ),
              SizedBox(height: 12),
              if (selectedOption == 0)
                CustomSearchBar(
                  hintText: 'Search by name or social handle',
                  controller: searchController,
                  onChanged: (val) {
                    manager
                        .getInfluencers(selectedOption, searchText: val)
                        .then((message) {
                          if (message != "success") {
                            showSnackBar(message);
                          }
                        });
                  },
                ),

              Obx(
                () =>
                    manager.influencerLoading.value
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomLoading(),
                        )
                        : Column(
                          children: [
                            for (var i in manager.influencers)
                              Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: InfluencerCard(influencer: i),
                              ),
                            if (manager.influencers.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No influencers available",
                                  style: TextStyle(
                                    color: AppColors.green.shade100,
                                  ),
                                ),
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
