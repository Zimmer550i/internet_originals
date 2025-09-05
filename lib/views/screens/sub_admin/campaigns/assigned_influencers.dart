import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/sub_admin_controller.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/matrix_model.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/influencer_card.dart';
import 'package:internet_originals/views/screens/sub_admin/campaigns/check_metrics.dart';

class AssignedInfluencers extends StatefulWidget {
  final CampaignModel campaign;
  const AssignedInfluencers({super.key, required this.campaign});

  @override
  State<AssignedInfluencers> createState() => _AssignedInfluencersState();
}

class _AssignedInfluencersState extends State<AssignedInfluencers> {
  final sub = Get.find<SubAdminController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sub.assignedInfluencers(widget.campaign.id).then((message) {
        if (message != "success") {
          showSnackBar(message);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Assigned Influencers"),
      body: Obx(
        () =>
            sub.campaignLoading.value
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomLoading(),
                  ),
                )
                : ListView.builder(
                  itemCount: sub.apiData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        left: 16,
                        right: 16,
                      ),
                      child: InfluencerCard(
                        influencer: UserModel.fromJson(
                          sub.apiData.elementAt(index)['influencer'],
                        ),
                        status: sub.apiData.elementAt(index)['status'],
                        callbackButton: () {
                          Get.to(
                            () => CheckMetrics(
                              matrix: MatrixModel.fromJson(
                                sub.apiData.elementAt(index),
                              ),
                            ),
                          );
                        },
                        // action: CustomButton(
                        //   text: "Check Metrics",
                        //   height: 40,
                        //   width: null,
                        //   onTap: () {
                        //     Get.to(() => CheckMetrics());
                        //   },
                        // ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
