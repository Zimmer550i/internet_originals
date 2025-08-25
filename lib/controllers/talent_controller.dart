import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/notification_model.dart';
import 'package:internet_originals/models/social_platform.dart';
import 'package:internet_originals/models/task_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class TalentController extends GetxController {
  // Fields
  final api = ApiService();

  RxList<TaskModel> tasks = RxList.empty();
  RxList<CampaignModel> campaigns = RxList.empty();
  RxList<NotificationModel> notifications = RxList.empty();
  RxList<SocialPlatformModel> socialPlatforms = RxList();

  RxBool isLoading = RxBool(false);
  RxBool taskLoading = RxBool(false);
  RxBool campaignLoading = RxBool(false);
  RxBool paymentLoading = RxBool(false);
  RxBool notificationLoading = RxBool(false);

  RxInt totalPages = RxInt(1);
  RxInt currentPage = RxInt(1);

  Timer? _notificationTimer;
  Duration notificationRefreshTime = Duration(minutes: 2);

  // Tasks
  Future<String> getTasks({bool getMore = false}) async {
    try {
      taskLoading(true);

      final response = await api.get(
        "/influencer/tasks",
        queryParams: {"page": currentPage.toString(), "limit": "2"},
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
        if (currentPage.value == 1) {
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
  Future<String> getCampaigns({String? status, bool getMore = false}) async {
    try {
      campaignLoading(true);

      var queryParams = {"page": currentPage.toString()};
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
        if (currentPage.value == 1) {
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

  Future<String> cancelCampaign(String id) async {
    try {
      campaignLoading(true);
      final response = await api.post(
        "/influencer/tasks/$id/cancel",
        {},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
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

  Future<String> acceptCampaign(String id, File image) async {
    try {
      campaignLoading(true);
      final response = await api.post(
        "/influencer/tasks/$id/accept",
        {"influencerAgreementProof": image},
        isMultiPart: true,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
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

  // Notifications
  Future<String> getNotifications({bool getMore = false}) async {
    try {
      notificationLoading(true);

      final response = await api.get(
        "/influencer/notifications",
        queryParams: {"page": currentPage.toString()},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        totalPages.value = body['meta']['pagination']['totalPages'];

        List<NotificationModel> temp = [];
        for (var i in data) {
          temp.add(NotificationModel.fromJson(i));
        }
        if (currentPage.value == 1) {
          notifications.assignAll(temp);
        } else {
          notifications.addAll(temp);
        }

        return "success";
      } else {
        return body["message"] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      notificationLoading(false);
    }
  }

  void readAllNotifications() async {
    try {
      final response = await api.post(
        "/influencer/notifications/read-all",
        {},
        authReq: true,
      );

      if (response.statusCode == 200) {
        for (var i in notifications) {
          i.status = "READ";
        }
      } else {
        debugPrint("Error reading notifications");
      }
    } catch (e) {
      debugPrint("Error reading notifications: ${e.toString()}");
    }
  }

  void _startNotificationTimer() {
    _notificationTimer?.cancel();

    _notificationTimer = Timer.periodic(notificationRefreshTime, (timer) {
      getNotifications();
    });
  }

  void _stopNotificationTimer() {
    _notificationTimer?.cancel();
    _notificationTimer = null;
  }

  Future<String> refreshNotifications() async {
    _stopNotificationTimer();
    final result = await getNotifications();
    _startNotificationTimer();
    return result;
  }

  @override
  void onClose() {
    _stopNotificationTimer();
    super.onClose();
  }
}
