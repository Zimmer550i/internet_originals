import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/screens/talent/campaign/talent_campaign.dart';
import 'package:internet_originals/views/screens/talent/home/talent_home.dart';
import 'package:internet_originals/views/screens/talent/payments/payments_home.dart';
import 'package:internet_originals/views/screens/talent/profile/profile.dart';

final GlobalKey<ManagerAppState> managerAppKey = GlobalKey<ManagerAppState>();

class ManagerApp extends StatefulWidget {
  const ManagerApp({super.key});

  @override
  State<ManagerApp> createState() => ManagerAppState();
}

class ManagerAppState extends State<ManagerApp> {
  int index = 0;

  List<Widget> pages = [
    TalentHome(),
    TalentCampaign(),
    PaymentsHome(),
    Profile(),
  ];

  List<String> labels = ["Home", "Campaigns", "Payments", "Profile"];

  List<String> icons = [
    AppIcons.home,
    AppIcons.campaigns,
    AppIcons.payments,
    AppIcons.profile,
  ];

  List<String> iconsDark = [
    AppIcons.homeDark,
    AppIcons.campaignsDark,
    AppIcons.paymentsDark,
    AppIcons.profileDark,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pages[index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        selectedItemColor: AppColors.red[400],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [for (int i = 0; i < pages.length; i++) item(i)],
      ),
    );
  }

  BottomNavigationBarItem item(int index) {
    return BottomNavigationBarItem(
      icon: CustomSvg(asset: icons[index]),
      activeIcon: CustomSvg(asset: iconsDark[index]),
      label: labels[index],
    );
  }

  void changePage(int val) {
    setState(() {
      index = val;
    });
  }
}
