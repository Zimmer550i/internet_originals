import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/notification_model.dart';
import 'package:internet_originals/models/social_platform.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class ManagerController extends GetxController {
  // Fields
  final api = ApiService();

  RxList<UserModel> influencers = RxList.empty();
  RxList<CampaignModel> tasks = RxList.empty();
  RxList<CampaignModel> campaigns = RxList.empty();
  RxList<CampaignModel> payments = RxList.empty();
  RxList<NotificationModel> notifications = RxList.empty();
  RxList<SocialPlatformModel> socialPlatforms = RxList();

  RxBool isLoading = RxBool(false);
  RxBool taskLoading = RxBool(false);
  RxBool campaignLoading = RxBool(false);
  RxBool paymentLoading = RxBool(false);
  RxBool notificationLoading = RxBool(false);
  RxBool influencerLoading = RxBool(false);

  RxInt totalPages = RxInt(1);
  RxInt currentPage = RxInt(1);
  RxInt activeCampaigns = RxInt(0);
  RxInt pendingMetrics = RxInt(0);
  RxInt connectedTalents = RxInt(0);
  RxnNum totalEarning = RxnNum();
  RxnNum pendingPayments = RxnNum();
  RxnNum paidEarning = RxnNum();

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
        "/manager/pending-tasks",
        queryParams: queryParams,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        currentPage.value = body['meta']['pagination']['page'];
        totalPages.value = body['meta']['pagination']['totalPages'];

        activeCampaigns.value = body['meta']['activeCampaigns'];
        pendingMetrics.value = body['meta']['pendingMetrics'];
        connectedTalents.value = body['meta']['connectedInfluencers'];

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
        "/manager/campaigns/$taskid/submit-post-link",
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
        queryParams['tab'] = status;
      }

      final response = await api.get(
        "/manager/campaigns",
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
        "/manager/campaigns/$id/cancel",
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
        "/manager/campaigns/$id/accept",
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
      final response = await api.post("/manager/campaigns/$id/report-issue", {
        "content": complain,
      }, authReq: true);
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
        "/manager/campaigns/$id/review",
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
        "/manager/campaigns/$id/upload-matrix",
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
        "/manager/payments?tab=pending",
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
        "/manager/payments?tab=paid",
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
      final resposne = await api.get("/manager/earnings", authReq: true);
      final body = jsonDecode(resposne.body);

      if (resposne.statusCode == 200) {
        final data = body['data'];
        pendingPayments.value = num.tryParse(data['pending']);
        paidEarning.value = num.tryParse(data['paid']);
        totalEarning.value = num.tryParse(data['total']);

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
        "/manager/campaigns/$id/request-for-payment",
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
      final response = await api.post("/manager/notifications/$id/compromise", {
        "date": dateTime.toIso8601String(),
      }, authReq: true);
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
        "/manager/notifications",
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

  void readAllNotifications() async {
    try {
      final response = await api.post(
        "/manager/notifications/read-all",
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

  // Influencers
  Future<String> getInfluencers(
    int selectedOption, {
    String? searchText,
    bool loadMore = false,
  }) async {
    try {
      Map<String, dynamic> queryParams = {};
      if (searchText != null && searchText != "") {
        queryParams['search'] = searchText;
      }

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

      if (selectedOption == 0) {
        queryParams['tab'] = "all";
      } else {
        queryParams['tab'] = "connected";
      }

      influencerLoading(true);
      final response = await api.get(
        "/manager/influencers",
        authReq: true,
        queryParams: queryParams,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        currentPage.value = body['meta']['pagination']['page'];
        totalPages.value = body['meta']['pagination']['totalPages'];

        final List<UserModel> temp = [];
        for (var i in data) {
          temp.add(UserModel.fromJson(i));
        }

        if (temp.isNotEmpty) {
          influencers.value = temp;
        } else {
          influencers.clear();
        }

        return "success";
      } else {
        return body['message'] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      influencerLoading(false);
    }
  }
}
