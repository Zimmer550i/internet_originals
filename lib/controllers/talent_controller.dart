import 'dart:convert';

import 'package:get/get.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/social_platform.dart';
import 'package:internet_originals/models/task_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class TalentController extends GetxController {
  // Fields
  final api = ApiService();

  RxList<TaskModel> tasks = RxList.empty();
  RxList<CampaignModel> campaigns = RxList.empty();

  RxBool isLoading = RxBool(false);
  RxBool taskLoading = RxBool(false);
  RxBool campaignLoading = RxBool(false);
  RxBool paymentLoading = RxBool(false);
  RxnInt totalPages = RxnInt();

  RxList<SocialPlatformModel> socialPlatforms = RxList();

  // Tasks
  Future<String> getTasks({int page = 1}) async {
    try {
      taskLoading(true);
      final response = await api.get(
        "/influencer/tasks",
        queryParams: {"page": page.toString()},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        totalPages.value = body['meta']['pagination']['totalPages'];

        List<TaskModel> temp = [];
        for (var i in data) {
          temp.add(TaskModel.fromJson(i));
        }
        if (page == 1) {
          tasks.assignAll(temp);
        } else {
          tasks.addAll(temp);
        }

        return "success";
      } else {
        return body["message"] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      taskLoading(false);
    }
  }

  Future<String> submitPostLink(String taskid, String link) async {
    try {
      taskLoading(true);
      final response = await api.post(
        "/influencer/tasks/$taskid/submit-post-link",
        {"postLink": link},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return body['message'] ?? "Unexpected error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      taskLoading(false);
    }
  }

  // Campaigns
  Future<String> getCampaigns({int page = 1, String? status}) async {
    try {
      campaignLoading(true);

      var queryParams = {"page": page.toString()};
      if (status != null) {
        queryParams['status'] = status;
      }

      final response = await api.get(
        "/influencer/campaigns",
        queryParams: queryParams,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        totalPages.value = body['meta']['pagination']['totalPages'];

        List<CampaignModel> temp = [];
        for (var i in data) {
          temp.add(CampaignModel.fromJson(i));
        }
        if (page == 1) {
          campaigns.assignAll(temp);
        } else {
          campaigns.addAll(temp);
        }

        return "success";
      } else {
        return body["message"] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      campaignLoading(false);
    }
  }

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
