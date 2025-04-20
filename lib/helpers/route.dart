import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/design_pattern.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/notification_history.dart';
import 'package:internet_originals/views/screens/sub_admin/notification/send_notification.dart';
import 'package:internet_originals/views/screens/sub_admin/settings/about_us.dart';
import 'package:internet_originals/views/screens/sub_admin/settings/personal_information.dart';
import 'package:internet_originals/views/screens/sub_admin/settings/privacy_policy.dart';
import 'package:internet_originals/views/screens/sub_admin/settings/terms_service.dart';
import 'package:internet_originals/views/screens/sub_admin/sub_admin_app.dart';
import 'package:internet_originals/views/screens/talent/payments/cach_payment_submitted.dart';
import 'package:internet_originals/views/screens/talent/payments/invoice_submitted.dart';
import 'package:internet_originals/views/screens/talent/payments/payment_selection.dart';
import 'package:internet_originals/views/screens/talent/payments/payment_terms.dart';
import 'package:internet_originals/views/screens/talent/payments/submit_invoice.dart';
import 'package:internet_originals/views/screens/talent/profile/about_us.dart';
import 'package:internet_originals/views/screens/talent/profile/add_socials.dart';
import 'package:internet_originals/views/screens/talent/profile/change_password.dart';
import 'package:internet_originals/views/screens/talent/profile/personal_information.dart';
import 'package:internet_originals/views/screens/talent/profile/privacy_policy.dart';
import 'package:internet_originals/views/screens/talent/profile/settings_security.dart';
import 'package:internet_originals/views/screens/talent/profile/social_added.dart';
import 'package:internet_originals/views/screens/talent/profile/social_platforms.dart';
import 'package:internet_originals/views/screens/talent/profile/terms_service.dart';
import 'package:internet_originals/views/screens/talent/talent_app.dart';

final GlobalKey subAdminAppKey = GlobalKey();

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
  static String addSocials = "/add_socials";
  static String socialAdded = "/social_added";
  static String paymentSelection = "/payment_selection";
  static String submitInvoice = "/submit_invoice";
  static String paymentTerms = "/payment_terms";
  static String invoiceSubmitted = "/invoice_submitted";
  static String cashPaymentSubmitted = "/cash_payment_submitted";
  static String adminPersonalInformation = "/admin_personal_information";
  static String adminPrivacyPolicy = "/admin_privacy_policy";
  static String adminTermsService = "/admin_terms_service";
  static String adminAboutUs = "/admin_about_us";
  static String notificationHistory = "/notification_history";
  static String sendNotification = "/send_notification";


  static Map<String, Widget> routeWidgets = {
    designPattern: DesignPattern(),
    talentApp: TalentApp(key: talentAppKey),
    subAdminApp: SubAdminApp(key: subAdminAppKey),
    personalInformation: PersonalInformation(),
    socialPlatforms: SocialPlatforms(),
    settingsSecurity: SettingsSecurity(),
    changePassword: ChangePassword(),
    privacyPolicy: PrivacyPolicy(),
    termsService: TermsService(),
    aboutUs: AboutUs(),
    addSocials: AddSocials(),
    socialAdded: SocialAdded(),
    paymentSelection: PaymentSelection(),
    submitInvoice: SubmitInvoice(),
    paymentTerms: PaymentTerms(),
    invoiceSubmitted: InvoiceSubmitted(),
    cashPaymentSubmitted: CashPaymentSubmitted(),
    adminPersonalInformation: AdminPersonalInformation(),
    adminPrivacyPolicy: AdminPrivacyPolicy(),
    adminTermsService: AdminTermsService(),
    adminAboutUs: AdminAboutUs(),
    notificationHistory: NotificationHistory(),
    sendNotification: SendNotification(),
  };

  static List<GetPage> pages = [
    ...routeWidgets.entries.map(
      (e) => GetPage(name: e.key, page: () => e.value),
    ),
  ];
}
