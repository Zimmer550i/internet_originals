import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/connection_model.dart';
import 'package:internet_originals/models/notification_model.dart';
import 'package:internet_originals/models/social_platform.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class TalentController extends GetxController {
  // Fields
  final api = ApiService();

  RxList<CampaignModel> tasks = RxList.empty();
  RxList<CampaignModel> campaigns = RxList.empty();
  RxList<CampaignModel> payments = RxList.empty();
  RxList<NotificationModel> notifications = RxList.empty();
  RxList<SocialPlatformModel> socialPlatforms = RxList();
  RxList<ConnectionModel> connections = RxList.empty();

  RxBool isLoading = RxBool(false);
  RxBool taskLoading = RxBool(false);
  RxBool campaignLoading = RxBool(false);
  RxBool paymentLoading = RxBool(false);
  RxBool notificationLoading = RxBool(false);

  RxInt totalPages = RxInt(1);
  RxInt currentPage = RxInt(1);
  RxnNum totalEarning = RxnNum();
  RxnNum pendingPayments = RxnNum();
  RxnNum paidEarning = RxnNum();

  Timer? _notificationTimer;
  Duration notificationRefreshTime = Duration(minutes: 2);

  @override
  void dispose() {
    super.dispose();
    _stopNotificationTimer();
  }

  // Tasks
  Future<String> getTasks({bool loadMore = false}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (loadMore) {
        if (campaignLoading.value) {
          return "success";
        }
        if (currentPage.value < totalPages.value) {
          currentPage.value = currentPage.value + 1;
        } else {
          return "success";
        }

        queryParams['page'] = (currentPage.value).toString();
      }

      taskLoading(true);

      final response = await api.get(
        "/influencer/tasks/pending",
        queryParams: queryParams,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        currentPage.value = body['meta']['pagination']['page'];
        totalPages.value = body['meta']['pagination']['totalPages'];

        List<CampaignModel> temp = [];
        for (var i in data) {
          temp.add(CampaignModel.fromJson(i));
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
        "/influencer/campaigns/$taskid/submit-post-link",
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
  Future<String> getCampaigns({String? status, bool loadMore = false}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (loadMore) {
        if (campaignLoading.value) {
          return "success";
        }
        if (currentPage.value < totalPages.value) {
          currentPage.value = currentPage.value + 1;
        } else {
          return "success";
        }

        queryParams['page'] = (currentPage.value).toString();
      }

      campaignLoading(true);

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
        currentPage.value = body['meta']['pagination']['page'];
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
        "/influencer/campaigns/$id/cancel",
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
        "/influencer/campaigns/$id/accept",
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

  Future<String> reportAnIssue(String id, String complain) async {
    try {
      campaignLoading(true);
      final response = await api.post(
        "/influencer/campaigns/$id/report-issue",
        {"content": complain},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && response.statusCode == 201) {
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

  Future<String> giveCampaignFeedback(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      campaignLoading(true);
      final response = await api.post(
        "/influencer/campaigns/$id/review",
        data,
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

  Future<String> uploadMatrix(String id, Map<String, dynamic> data) async {
    try {
      campaignLoading(true);
      final response = await api.post(
        "/influencer/campaigns/$id/upload-matrix",
        data,
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
  Future<String> getPendingPayment({bool loadMore = false}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (loadMore) {
        if (campaignLoading.value) {
          return "success";
        }
        if (currentPage.value < totalPages.value) {
          currentPage.value = currentPage.value + 1;
        } else {
          return "success";
        }

        queryParams['page'] = (currentPage.value).toString();
      }

      paymentLoading(true);
      final response = await api.get(
        "/influencer/payments/pending-payment",
        queryParams: queryParams,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        currentPage.value = body['meta']['pagination']['page'];
        totalPages.value = body['meta']['pagination']['totalPages'];

        List<CampaignModel> temp = [];

        for (var i in data) {
          temp.add(CampaignModel.fromJson(i));
        }

        if (currentPage.value == 1) {
          payments.assignAll(temp);
        } else {
          payments.addAll(temp);
        }

        return "success";
      } else {
        return body["message"] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      paymentLoading(false);
    }
  }

  Future<String> getPaidPayment({bool loadMore = false}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (loadMore) {
        if (campaignLoading.value) {
          return "success";
        }
        if (currentPage.value < totalPages.value) {
          currentPage.value = currentPage.value + 1;
        } else {
          return "success";
        }

        queryParams['page'] = (currentPage.value).toString();
      }

      paymentLoading(true);
      final response = await api.get(
        "/influencer/payments/paid-payment",
        queryParams: queryParams,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        currentPage.value = body['meta']['pagination']['page'];
        totalPages.value = body['meta']['pagination']['totalPages'];

        List<CampaignModel> temp = [];

        for (var i in data) {
          temp.add(CampaignModel.fromJson(i));
        }

        if (currentPage.value == 1) {
          payments.assignAll(temp);
        } else {
          payments.addAll(temp);
        }

        return "success";
      } else {
        return body["message"] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      paymentLoading(false);
    }
  }

  Future<String> getEarnings() async {
    try {
      paymentLoading(true);
      final resposne = await api.get(
        "/influencer/payments/get-earnings",
        authReq: true,
      );
      final body = jsonDecode(resposne.body);

      if (resposne.statusCode == 200) {
        final data = body['data'];
        pendingPayments.value = data['pending'];
        paidEarning.value = data['paid'];
        totalEarning.value = data['total'];

        return "success";
      } else {
        return body['message'] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      paymentLoading(false);
    }
  }

  Future<String> requestForPayment(String id, List<File>? files) async {
    try {
      paymentLoading(true);
      final resposne = await api.post(
        "/influencer/campaigns/$id/request-for-payment",
        files == null ? {} : {"invoices": files},
        queryParams: {"method": files == null ? "cash" : "invoice"},
        authReq: true,
        isMultiPart: files != null,
      );
      final body = jsonDecode(resposne.body);

      if (resposne.statusCode == 200 || resposne.statusCode == 201) {
        return "success";
      } else {
        return body['message'] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      paymentLoading(false);
    }
  }

  // Profile
  Future<String?> getPolicies(String specific) async {
    try {
      isLoading(true);
      final response = await api.get("/context-pages/$specific", authReq: true);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body)['data'];
      } else {
        showSnackBar(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      showSnackBar(e.toString());
    } finally {
      isLoading(false);
    }

    return null;
  }

  // Notifications
  Future<String> compromiseNotification(String id, DateTime dateTime) async {
    try {
      final response = await api.post(
        "/influencer/notifications/$id/compromise",
        {"date": dateTime.toIso8601String()},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "success";
      } else {
        return body['message'] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getNotifications({bool loadMore = false}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (loadMore) {
        if (campaignLoading.value) {
          return "success";
        }
        if (currentPage.value < totalPages.value) {
          currentPage.value = currentPage.value + 1;
        } else {
          return "success";
        }

        queryParams['page'] = (currentPage.value).toString();
      }

      notificationLoading(true);

      final response = await api.get(
        "/influencer/notifications",
        queryParams: queryParams,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        currentPage.value = body['meta']['pagination']['page'];
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

  Future<String> getConnections() async {
    try {
      isLoading(true);

      final response = await api.get("/influencer/manager", authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        connections.clear();
        for (var i in data) {
          try {
            connections.add(ConnectionModel.fromJson(i));
          } catch (e) {
            debugPrint(e.toString());
            debugPrint("Data: $i");
          }
        }

        return "success";
      } else {
        return body["message"] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> addConnection(String id) async {
    try {
      isLoading(true);

      final response = await api.post("/influencer/manager", {
        "managerId": id,
      }, authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final index = connections.indexWhere((i) => i.id == id);
        if (index != -1) {
          connections[index] = connections[index].copyWith(isConnected: true);
        }
        return "success";
      } else {
        return body["message"] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> removeConnection(String id) async {
    try {
      isLoading(true);

      final response = await api.delete(
        "/influencer/manager",
        data: {"managerId": id},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final index = connections.indexWhere((i) => i.id == id);
        if (index != -1) {
          connections[index] = connections[index].copyWith(isConnected: false);
        }
        return "success";
      } else {
        return body["message"] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
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

  void readNotifications(String id) async {
    try {
      final response = await api.post(
        "/influencer/notifications/$id/read",
        {},
        authReq: true,
      );

      if (response.statusCode == 200) {
        notifications.firstWhere((val) => val.id == id).status = "READ";
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
    if (result == "success") {
      _startNotificationTimer();
    } else {
      _stopNotificationTimer();
    }
    return result;
  }

  @override
  void onClose() {
    _stopNotificationTimer();
    super.onClose();
  }
}
