import 'dart:convert';
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
          setToken(data['accessToken']);
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
      final response = await api.post("/user/create-influencer", {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      });
      if (response.statusCode == 200) {
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
      final response = await api.post("/auth/forgot-password", {
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

  // Future<String> resetPassword(
  //   String first,
  //   String second,
  //   String data,
  // ) async {}

  // Future<String> signup(Map<String, String> data) async {}

  Future<String> sendOtp(String email) async {
    try {
      final response = await api.post("/auth/resend-otp", {"email": email});

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
      final response = await api.post("/auth/verify-email", {
        "email": email,
        "oneTimeCode": int.parse(code),
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
  }
}
