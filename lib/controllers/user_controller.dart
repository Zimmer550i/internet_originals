import 'package:get/get.dart';
import 'package:internet_originals/models/user_model.dart';

class UserController extends GetxController {
  final userInfo = Rxn<UserModel>();

  void setInfo(Map<String, dynamic>? json) {
    if (json != null) {
      userInfo.value = UserModel.fromJson(json);
    }
  }
}
