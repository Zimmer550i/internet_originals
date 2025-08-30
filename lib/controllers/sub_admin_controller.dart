import 'dart:convert';

import 'package:get/get.dart';
import 'package:internet_originals/models/payment_model.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class SubAdminController extends GetxController {
  // Fields
  final api = ApiService();

  RxList<PaymentModel> payments = RxList.empty();
  Rxn<PaymentModel> singlePayment = Rxn(null);

  RxBool isLoading = RxBool(false);
  RxBool paymentLoading = RxBool(false);
  RxBool campaignLoading = RxBool(false);
  RxBool taskLoading = RxBool(false);

  // Tasks

  // Campaigns

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
