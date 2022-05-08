import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/error_result.dart';
import 'package:digital_queue/services/profile_result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final storage = const FlutterSecureStorage();
  final apiClient = Get.find<ApiClient>();

  var name = "".obs;
  var email = "".obs;

  Future initialize() async {
    final accessToken = await storage.read(key: "user_access_token");

    if (accessToken == null) {
      throw Error();
    }

    final result = await apiClient.getProfile(accessToken: accessToken);

    if (result is ErrorResult) {
      throw Error();
    }

    final profile = result as ProfileResult;
    name.value = profile.name;
    email.value = profile.email;
  }

  void changeEmail() {}

  void exit() {}
}
