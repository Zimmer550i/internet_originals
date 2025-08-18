import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/user_controller.dart';
import 'package:internet_originals/services/api_service.dart';
import 'package:internet_originals/services/shared_prefs_service.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = RxBool(false);
  final api = ApiService();

  Future<String> login(String email, String password) async {
    try {
      final response = await api.post("/auth/login", {
        "email": email,
        "password": password,
      });
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        if (data != null) {
          Get.find<UserController>().setInfo(data['user']);
          setToken(data['access_token']);
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> signup(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    try {
      final response = await api.post("/auth/register", {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      });
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = body["data"];

        if (data != null) {
          Get.find<UserController>().setInfo(data['user']);
          setToken(data['access_token']);
        }

        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  // Future<String> getUserInfo() async {}

  Future<String> forgotPassword(String email) async {
    try {
      final response = await api.post("/auth/reset-password-otp-send", {
        "email": email,
      });

      if (response.statusCode == 200) {
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> sendOtp(String email) async {
    try {
      final response = await api.get(
        "/auth/account-verify-otp-send",
        authReq: true,
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> verifyEmail(
    String email,
    String code, {
    bool isResetingPassword = false,
  }) async {
    try {
      final response = await api.post(
        isResetingPassword
            ? "/auth/reset-password-otp-verify"
            : "/auth/account-verify",
        isResetingPassword ? {"email": email, "otp": code} : {"otp": code},
        authReq: true,
      );

      if (response.statusCode == 200) {
        if (isResetingPassword) {
          final token = jsonDecode(response.body)['data']['reset_token'];

          return "token $token";
        } else {
          final data = jsonDecode(response.body)['data'];

          if (data != null) {
            Get.find<UserController>().setInfo(data['user']);
          }
        }
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> requestForInfluencer(
    File? avatar,
    String address,
    String platform,
    String link,
    String followers,
  ) async {
    try {
      Map<String, String> data = {
        "address": address,
        "platform": platform,
        "link": link,
        "followers": followers,
      };

      Map<String, dynamic> payload = {"data": data};

      if (avatar != null) {
        payload["avatar"] = avatar;
      }

      final response = await api.post(
        "/profile/request-for-influencer",
        payload,
        isMultiPart: true,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        Get.find<UserController>().setInfo(data);
        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> resetPassword(
    String pass,
    String token,
  ) async {
    try {
      final response = await api.post("/auth/reset-password?reset_token=$token", {
        "password": pass,
      });

      if (response.statusCode == 200) {
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> checkLoginStatus() async {
    String? token = await SharedPrefsService.get('token');
    if (token != null) {
      // debugPrint('🔍 Token found. Fetching user info...');
      // final message = await getUserInfo();
      // if (message == "Success") {
      //   isLoggedIn.value = true;
      //   return true;
      // }
    }
    isLoggedIn.value = false;
    return false;
  }

  Future<void> logout() async {
    await SharedPrefsService.clear();
    isLoggedIn.value = false;
  }

  Future<void> setToken(String value) async {
    await SharedPrefsService.set('token', value);
    debugPrint('💾 Token Saved: $value');
  }
}
