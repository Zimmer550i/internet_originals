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
      final response = await api.patch("/user/update-profile", data, authReq: true);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
