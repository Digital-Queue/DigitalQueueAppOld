import 'package:digital_queue/services/authentication_result.dart';
import 'package:digital_queue/services/error_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../services/api_client.dart';

class VerifyAuthController extends GetxController {
  final apiClient = Get.find<ApiClient>();
  final storage = const FlutterSecureStorage();

  late final TextEditingController _codeTextController;

  @override
  void onInit() {
    _codeTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    _codeTextController.dispose();
    super.dispose();
  }

  TextEditingController get codeTextController {
    return _codeTextController;
  }

  Future verifyAuthCode() async {
    final email = Get.arguments["email"]!;
    final status = Get.arguments["status"]!;
    final code = codeTextController.value.text;

    final result = await apiClient.verifyAuthenticationCode(
      email: email,
      code: code,
    );

    if (result is ErrorResult) {
      // TODO: show error popup
      return;
    }

    // TODO: populate a user object

    // TODO: add firebase token for FCM use case
    // await storage.write(key: "user_device_token", value: "");

    final auth = result as AuthenticationResult;
    await storage.write(key: "user_access_token", value: auth.accessToken);
    await storage.write(key: "user_refresh_token", value: auth.refreshToken);
    await storage.write(key: "user_email", value: email);

    if (status == "created") {
      Get.toNamed("/setName", arguments: {
        "email": email,
      });

      // TODO: ???
      return;
    }

    Get.offNamed("/profile");
  }
}
