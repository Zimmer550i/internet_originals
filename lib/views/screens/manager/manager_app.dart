import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/screens/manager/campaign/manager_campaign.dart';
import 'package:internet_originals/views/screens/manager/home/manager_home.dart';
import 'package:internet_originals/views/screens/manager/influencer/manager_influencer_home.dart';
import 'package:internet_originals/views/screens/manager/payments/manager_payments_home.dart';
import 'package:internet_originals/views/screens/sub_admin/settings/settings.dart';

final GlobalKey<ManagerAppState> managerAppKey = GlobalKey<ManagerAppState>();

class ManagerApp extends StatefulWidget {
  const ManagerApp({super.key});

  @override
  State<ManagerApp> createState() => ManagerAppState();
}

class ManagerAppState extends State<ManagerApp> {
  int index = 0;

  List<Widget> pages = [
    ManagerHome(),
    ManagerCampaign(),
    ManagerPaymentsHome(),
    ManagerInfluencerHome(),
    SettingsHome(),
  ];

  List<String> labels = [
    "Home",
    "Campaigns",
    "Payments",
    "Influencers",
    "Settings",
  ];

  List<String> icons = [
    AppIcons.home,
    AppIcons.campaigns,
    AppIcons.payments,
    AppIcons.influencers,
    AppIcons.settings,
  ];

  List<String> iconsDark = [
    AppIcons.homeDark,
    AppIcons.campaignsDark,
    AppIcons.paymentsDark,
    AppIcons.influencersDark,
    AppIcons.settingsDark,
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
