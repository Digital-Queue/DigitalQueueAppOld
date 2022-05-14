import 'package:digital_queue/services/dtos/authentication_result.dart';
import 'package:digital_queue/services/dtos/error_result.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../services/api_client.dart';

class VerifyAuthController extends GetxController {
  final apiClient = Get.find<ApiClient>();
  final userService = Get.find<UserService>();

  VerifyAuthController() {
    // Init firebase token change notifier
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (token) async {
        await userService.saveUser(
          User(
            deviceToken: token,
          ),
        );
      },
    );
  }

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

  late final TextEditingController _codeTextController;
  TextEditingController get codeTextController {
    return _codeTextController;
  }

  Future verifyAuthCode() async {
    final email = Get.arguments["email"]!;
    final status = Get.arguments["status"]!;
    final code = codeTextController.value.text;

    // add firebase token for FCM use case
    final deviceToken = await FirebaseMessaging.instance.getToken();

    final result = await apiClient.verifyAuthenticationCode(
      email: email,
      code: code,
      deviceToken: deviceToken,
    );

    if (result is ErrorResult) {
      Get.dialog(
        AlertDialog(
          content: Text(
            "Error: ${result.message}",
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
      return;
    }

    final auth = result as AuthenticationResult;
    await userService.saveUser(
      User(
        accessToken: auth.accessToken,
        refreshToken: auth.refreshToken,
        email: email,
        deviceToken: deviceToken,
      ),
    );

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
