import 'dart:convert';
import 'package:get/get.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';

class UserController extends GetxController {
  final userInfo = Rxn<UserModel>();
  final api = ApiService();

  RxBool isLoading = RxBool(false);

  Future<String> getInfo() async {
    isLoading.value = true;
    try {
      final response = await api.get("/profile", authReq: true);

      if (response.statusCode == 200) {
        setInfo(jsonDecode(response.body)['data']);
        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return e.toString();
    }
  }

  void setInfo(Map<String, dynamic>? json) {
    if (json != null) {
      userInfo.value = UserModel.fromJson(json);
    }
  }

  Future<String> updateInfo(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final response = await api.patch(
        "/profile/edit",
        data,
        authReq: true,
        isMultiPart: true,
      );

      if (response.statusCode == 200) {
        setInfo(jsonDecode(response.body)['data']);
        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return e.toString();
    }
  }

  Future<String> changePassword(
    String oldPass,
    String newPass,
  ) async {
    isLoading.value = true;
    try {
      final response = await api.post("/profile/change-password", {
        "oldPassword": oldPass,
        "newPassword": newPass,
      }, authReq: true);

      if (response.statusCode == 200) {
        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return e.toString();
    }
  }

  String? getImageUrl() {
    if (userInfo.value == null || userInfo.value!.avatar == null) {
      return null;
    }

    String baseUrl = ApiService().baseUrl.replaceAll("/api/v1", "");

    return baseUrl + userInfo.value!.avatar!;
  }
}
