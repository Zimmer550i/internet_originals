// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:internet_originals/views/base/custom_app_bar.dart';
// import 'package:internet_originals/views/base/custom_button.dart';
// import 'package:internet_originals/views/base/influencer_card.dart';
// import 'package:internet_originals/views/screens/sub_admin/campaigns/check_metrics.dart';

// class AssignedInfluencers extends StatelessWidget {
//   const AssignedInfluencers({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "Assigned Influencers"),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
//             child: InfluencerCard(
//               action: CustomButton(
//                 text: "Check Metrics",
//                 height: 40,
//                 width: null,
//                 onTap: () {
//                   Get.to(() => CheckMetrics());
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
