import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/design_pattern.dart';
import 'package:internet_originals/views/screens/sub_admin/sub_admin_app.dart';
import 'package:internet_originals/views/screens/talent/profile/about_us.dart';
import 'package:internet_originals/views/screens/talent/profile/change_password.dart';
import 'package:internet_originals/views/screens/talent/profile/personal_information.dart';
import 'package:internet_originals/views/screens/talent/profile/privacy_policy.dart';
import 'package:internet_originals/views/screens/talent/profile/settings_security.dart';
import 'package:internet_originals/views/screens/talent/profile/social_platforms.dart';
import 'package:internet_originals/views/screens/talent/profile/terms_service.dart';
import 'package:internet_originals/views/screens/talent/talent_app.dart';

class AppRoutes {
  static String designPattern = "/design_pattern";
  static String talentApp = "/talent_home";
  static String subAdminApp = "/sub_admin_home";
  static String personalInformation = "/personal_information";
  static String socialPlatforms = "/social_platforms";
  static String settingsSecurity = "/settings_security";
  static String changePassword = "/change_password";
  static String privacyPolicy = "/privacy_policy";
  static String termsService = "/terms_service";
  static String aboutUs = "/about_us";

  static Map<String, Widget> routeWidgets = {
    designPattern: DesignPattern(),
    talentApp: TalentApp(),
    subAdminApp: SubAdminApp(),
    personalInformation: PersonalInformation(),
    socialPlatforms: SocialPlatforms(),
    settingsSecurity: SettingsSecurity(),
    changePassword: ChangePassword(),
    privacyPolicy: PrivacyPolicy(),
    termsService: TermsService(),
    aboutUs: AboutUs(),
  };

  static List<GetPage> pages = [
    ...routeWidgets.entries.map(
      (e) => GetPage(name: e.key, page: () => e.value),
    ),
  ];
}
