import 'dart:convert';

import 'package:get/get.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/utils/show_snackbar.dart';

class SubAdminController extends GetxController {
  // Fields
  final api = ApiService();

  RxBool isLoading = RxBool(false);

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
