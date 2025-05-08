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
  Future<void> getSocialPlatforms() async {
    isLoading.value = true;
    try {
      final response = await api.get(
        "/platform/get-my-platform",
        authReq: true,
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['data']['result'];

        for (var i in data) {
          socialPlatforms.add(SocialPlatformModel.fromJson(i));
        }

        isLoading.value = false;
      } else {
        isLoading.value = false;
        String message =
            jsonDecode(response.body)['message'] ?? "Connection Error";
        showSnackBar(message);
      }
    } catch (e) {
      isLoading.value = false;
      String message = e.toString();
      showSnackBar(message);
    }
  }

  Future<String> addSocialPlatform(
    String platformName,
    String link,
    String followers,
  ) async {
    isLoading.value = true;
    try {
      final payload = {
        "followers": followers.trim(),
        "link": link.trim(),
        "platformName": platformName.trim(),
      };
      final response = await api.post(
        "/platform/create-platform",
        payload,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return e.toString();
    }
  }

  Future<void> deleteSocialPlatform(String id) async {
    try {
      final response = await api.delete(
        "/platform/delete-platform/$id",
        authReq: true,
      );

      if (response.statusCode == 200) {
        socialPlatforms.removeWhere((val) => val.id == id);
      }
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

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
