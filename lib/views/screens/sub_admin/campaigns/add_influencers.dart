// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:internet_originals/utils/app_colors.dart';
// import 'package:internet_originals/views/base/custom_app_bar.dart';
// import 'package:internet_originals/views/base/custom_button.dart';
// import 'package:internet_originals/views/base/custom_searchbar.dart';
// import 'package:internet_originals/views/base/influencer_card.dart';

// class AddInfluencers extends StatefulWidget {
//   const AddInfluencers({super.key});

//   @override
//   State<AddInfluencers> createState() => _AddInfluencersState();
// }

// class _AddInfluencersState extends State<AddInfluencers> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "Add Influencers"),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20.0, top: 12),
//               child: CustomSearchBar(
//                 hintText: "Search by name or social handle",
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     child: InfluencerCard(
//                       action: CustomButton(
//                         text: "Assign",
//                         height: 40,
//                         width: null,
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return Dialog(
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                     vertical: 32,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.green[600],
//                                     borderRadius: BorderRadius.circular(4),
//                                     border: Border.all(
//                                       color: AppColors.green[400]!,
//                                     ),
//                                   ),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         "Are you sure you want to assign",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           height: 24 / 16,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8,),
//                                       Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius: BorderRadius.circular(
//                                               2,
//                                             ),
//                                             child: Image.network(
//                                               "https://picsum.photos/200/200",
//                                               height: 24,
//                                               width: 24,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 4),
//                                           Text(
//                                             "Sophia Carter",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 16,
//                                               color: AppColors.green[25],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8,),
//                                       Text("To"),
//                                       const SizedBox(height: 8,),
//                                       Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius: BorderRadius.circular(
//                                               2,
//                                             ),
//                                             child: Image.network(
//                                               "https://picsum.photos/200/200",
//                                               height: 24,
//                                               width: 24,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 4),
//                                           Text(
//                                             "Samsung Galaxy Unpacked",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 16,
//                                               color: AppColors.green[25],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 32),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           CustomButton(
//                                             text: "Cancel",
//                                             height: 40,
//                                             width: null,
//                                             isSecondary: true,
//                                             onTap: () => Get.back(),
//                                           ),
//                                           const SizedBox(width: 20),
//                                           CustomButton(
//                                             text: "Confirm",
//                                             height: 40,
//                                             width: null,
//                                             onTap: () {
//                                               Get.back();
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
