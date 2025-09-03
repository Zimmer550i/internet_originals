import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:internet_originals/models/campaign_model.dart';
import 'package:internet_originals/models/issue_model.dart';
import 'package:internet_originals/models/payment_model.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class SubAdminController extends GetxController {
  // Fields
  final api = ApiService();

  RxList<UserModel> influencers = RxList.empty();
  RxList<CampaignModel> campaigns = RxList.empty();
  Rxn<CampaignModel> singleCampaign = Rxn(null);
  RxList<IssueModel> issues = RxList.empty();
  RxList<PaymentModel> payments = RxList.empty();
  Rxn<PaymentModel> singlePayment = Rxn(null);

  RxBool isLoading = RxBool(false);
  RxBool issueLoading = RxBool(false);
  RxBool paymentLoading = RxBool(false);
  RxBool campaignLoading = RxBool(false);
  RxBool influencerLoading = RxBool(false);

  // Campaigns
  Future<String> getCampaigns({
    String? searchText,
    bool showCompleted = false,
  }) async {
    try {
      campaignLoading(true);

      Map<String, dynamic> queryParams = {};
      if (searchText != null) {
        queryParams['search'] = searchText;
      }

      final response = await api.get(
        "/sub-admin/campaigns/${showCompleted ? "completed" : "active"}",
        queryParams: queryParams,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        // totalPages.value = body['meta']['pagination']['totalPages'];

        List<CampaignModel> temp = [];
        for (var i in data) {
          temp.add(CampaignModel.fromJson(i));
        }

        campaigns.value = temp;

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

  Future<String> assignCampaign(String influencerId, String campaignId) async {
    try {
      campaignLoading(true);
      final response = await api.post(
        "/sub-admin/campaigns/$campaignId/create-task",
        {"influencerId": influencerId},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<String> createCampaign(
    String title,
    String description,
    String brand,
    File image,
    String campaignType,
    double budget,
    DateTime duration,
    String contentType,
    String payoutDeadline,
    Map<String, dynamic> expectedMetrics,
    Map<String, String> otherFields,
  ) async {
    try {
      campaignLoading(true);
      final data = {
        "title": title,
        "description": description,
        "brand": brand,
        "campaign_type": campaignType,
        "budget": budget,
        "duration": duration.toIso8601String(),
        "content_type": contentType,
        "payout_deadline": payoutDeadline,
        "expected_metrics": expectedMetrics,
        "other_fields": otherFields,
      };
      final response = await api.post(
        "/sub-admin/campaigns/create",
        {"data": data, "banner": image},
        authReq: true,
        isMultiPart: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        singleCampaign.value = CampaignModel.fromJson(body["data"]);

        return "success";
      } else {
        return body['message'] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      campaignLoading(false);
    }
  }

  Future<String> updateCampaign(
    String id,
    String title,
    String description,
    String brand,
    File? image,
    String campaignType,
    double budget,
    DateTime duration,
    String contentType,
    String payoutDeadline,
    Map<String, dynamic> expectedMetrics,
    Map<String, String> otherFields,
  ) async {
    try {
      campaignLoading(true);
      final data = {
        "title": title,
        "description": description,
        "brand": brand,
        "campaign_type": campaignType,
        "budget": budget,
        "duration": duration.toIso8601String(),
        "content_type": contentType,
        "payout_deadline": payoutDeadline,
        "expected_metrics": expectedMetrics,
        "other_fields": otherFields,
      };

      Map<String, dynamic> payload = {"data": data};
      if (image != null) {
        payload.addAll({"banner": image});
      }

      final response = await api.patch(
        "/sub-admin/campaigns/$id/edit",
        payload,
        authReq: true,
        isMultiPart: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        singleCampaign.value = CampaignModel.fromJson(body["data"]);

        for (int i = 0; i < campaigns.length; i++) {
          if (campaigns.elementAt(i).id == id) {
            campaigns.removeAt(i);
            campaigns.insert(i, singleCampaign.value!);
          }
        }

        return "success";
      } else {
        return body['message'] ?? "Unexpected Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      campaignLoading(false);
    }
  }

  Future<String> getIssues(String id) async {
    try {
      issueLoading(true);
      final response = await api.get(
        "/sub-admin/campaigns/$id/issues",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        issues.clear();
        for (var i in data) {
          issues.add(IssueModel.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? "Unexpected Error!";
      }
    } catch (e) {
      return e.toString();
    } finally {
      issueLoading(false);
    }
  }

  
  Future<String> readIssue(String id) async {
    try {
      final response = await api.get(
        "/sub-admin/issues/$id/mark-as-read",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return "success";
      } else {
        return body['message'] ?? "Unexpected Error!";
      }
    } catch (e) {
      return e.toString();
    }
  }

  

  // Influencers
  Future<String> getInfluencers({
    bool getPending = false,
    String? searchText,
  }) async {
    try {
      influencerLoading(true);
      final response = await api.get(
        "/sub-admin/influencers${getPending ? "/pending-influencers" : ""}",
        authReq: true,
        queryParams: searchText != null ? {"search": searchText} : null,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

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

  Future<String> approveInfluencer(String id) async {
    try {
      influencerLoading(true);
      final response = await api.get(
        "/sub-admin/influencers/$id/approve",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
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

  Future<String> declineInfluencer(String id) async {
    try {
      influencerLoading(true);
      final response = await api.get(
        "/sub-admin/influencers/$id/decline",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
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

  // Payments
  Future<String> getPayments(String status) async {
    try {
      paymentLoading(true);
      final response = await api.get(
        "/sub-admin/payments",
        authReq: true,
        queryParams: {"status": status},
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        final List<PaymentModel> temp = [];
        for (var i in data) {
          temp.add(PaymentModel.fromJson(i));
        }

        if (temp.isNotEmpty) {
          payments.value = temp;
        } else {
          payments.clear();
        }

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

  Future<String> getSinglePayments(String id) async {
    try {
      paymentLoading(true);
      final response = await api.get("/sub-admin/payments/$id", authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        singlePayment.value = PaymentModel.fromJson(data);

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

  Future<String> approvePayment(String id) async {
    try {
      paymentLoading(true);
      final response = await api.post(
        "/sub-admin/payments/$id/paid",
        {},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
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

  Future<String> cancelPayment(String id) async {
    try {
      paymentLoading(true);
      final response = await api.post(
        "/sub-admin/payments/$id/cancel",
        {},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
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
      final response = await api.get("/setting/get/$specific", authReq: true);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body)['data']['description'];
      } else {
        showSnackBar(
          jsonDecode(response.body)['message'] ?? "Connection Error",
        );
      }
    } catch (e) {
      showSnackBar(e.toString());
    }

    return null;
  }

  Future<void> updatePolicies(String specific, String data) async {
    isLoading.value = true;

    try {
      final payload = <String, dynamic>{"description": data, "type": specific};
      final response = await api.post(
        "/setting/create",
        payload,
        authReq: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBar("Updated Successfully", isError: false);
      } else {
        showSnackBar(
          jsonDecode(response.body)['message'] ?? "Connection Error",
        );
      }
    } catch (e) {
      showSnackBar(e.toString());
    }

    isLoading.value = false;
  }
}
