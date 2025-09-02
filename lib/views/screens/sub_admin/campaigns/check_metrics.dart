// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:internet_originals/utils/app_colors.dart';
// import 'package:internet_originals/utils/custom_svg.dart';
// import 'package:internet_originals/views/base/custom_app_bar.dart';
// import 'package:internet_originals/views/base/custom_button.dart';
// import 'package:internet_originals/views/base/influencer_card.dart';
// import 'package:internet_originals/views/screens/sub_admin/campaigns/rating.dart';

// class CheckMetrics extends StatelessWidget {
//   const CheckMetrics({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "Campaign Metrics"),
//       body: Align(
//         alignment: Alignment.topCenter,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 const SizedBox(height: 12),
//                 InfluencerCard(
//                   action: Column(
//                     spacing: 16,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 8),
//                       Text(
//                         "Performance Metrics",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                           height: 28 / 18,
//                         ),
//                       ),
//                       field("Views", "12,500", "11,000"),
//                       field("Likes", "1,800", "1,500"),
//                       field("Shares", "280", "300"),

//                       Container(
//                         height: 52,
//                         padding: EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                           border: Border(
//                             bottom: BorderSide(color: AppColors.green[400]!),
//                           ),
//                         ),
//                         child: Center(
//                           child: Row(
//                             children: [
//                               Text(
//                                 "View Link",
//                                 style: TextStyle(
//                                   color: AppColors.red[300],
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               const SizedBox(width: 4),
//                               CustomSvg(
//                                 asset: "assets/icons/payments/arrow_tr.svg",
//                                 size: 20,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 52,
//                         padding: EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                           border: Border(
//                             bottom: BorderSide(color: AppColors.green[400]!),
//                           ),
//                         ),
//                         child: Center(
//                           child: Row(
//                             children: [
//                               Text(
//                                 "Download Insight Screenshot",
//                                 style: TextStyle(
//                                   color: AppColors.red[300],
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               const SizedBox(width: 4),
//                               CustomSvg(
//                                 asset: "assets/icons/payments/arrow_down.svg",
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: CustomButton(
//                                 text: "Request Revision",
//                                 height: 40,
//                                 width: null,
//                                 isSecondary: true,
//                                 padding: EdgeInsets.symmetric(vertical: 10),
//                               ),
//                             ),
//                             const SizedBox(width: 20),
//                             Expanded(
//                               child: CustomButton(
//                                 text: "Approve Metrics",
//                                 height: 40,
//                                 width: null,
//                                 padding: EdgeInsets.symmetric(vertical: 10),
//                                 onTap: () {
//                                   Get.to(() => Rating());
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget field(String metric, String achieved, String goal) {
//     return Container(
//       height: 52,
//       padding: EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: AppColors.green[400]!)),
//       ),
//       child: Center(
//         child: Row(
//           children: [
//             Text("$metric: $achieved"),
//             Text(
//               " (Goal: $goal)",
//               style: TextStyle(color: AppColors.green[200]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
