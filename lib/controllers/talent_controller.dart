import 'dart:convert';

import 'package:get/get.dart';
import 'package:internet_originals/models/social_platform.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class TalentController extends GetxController {
  // Fields
  final api = ApiService();

  RxBool isLoading = RxBool(false);

  RxList<SocialPlatformModel> socialPlatforms = RxList();

  // Tasks

  // Campaigns

  // Payments

  // Profile
  Future<String?> getPolicies(String specific) async {
    try {
      final response = await api.get("/setting/get/$specific", authReq: true);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body)['data']['description'];
      } else {
        showSnackBar(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      showSnackBar(e.toString());
    }

    return null;
  }
}
