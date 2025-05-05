import 'dart:convert';
import 'package:get/get.dart';
import 'package:internet_originals/models/user_model.dart';
import 'package:internet_originals/services/api_service.dart';

class UserController extends GetxController {
  final userInfo = Rxn<UserModel>();
  final api = ApiService();

  void setInfo(Map<String, dynamic>? json) {
    if (json != null) {
      userInfo.value = UserModel.fromJson(json);
    }
  }

  Future<String> updateInfo(Map<String, dynamic> data) async {
    try {
      final response = await api.post(
        "/user/update-profile",
        data,
        authReq: true,
        isMultiPart: true,
      );

      if (response.statusCode == 200) {
        setInfo(jsonDecode(response.body)['data']);
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  String? getImageUrl() {
    if (userInfo.value == null || userInfo.value!.image == null) {
      return null;
    }

    String baseUrl = ApiService().baseUrl.replaceAll("/api/v1", "");

    return baseUrl + userInfo.value!.image!;
  }
}
