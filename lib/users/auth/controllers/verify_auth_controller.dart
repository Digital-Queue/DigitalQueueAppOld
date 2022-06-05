import 'package:digital_queue/users/services/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyAuthController extends GetxController {
  final userService = Get.find<UserService>();

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

  var _isLoggingIn = false.obs;
  bool get isLoggingIn {
    return _isLoggingIn.value;
  }

  Future verifyAuthCode() async {
    final email = Get.arguments["email"]!;
    final status = Get.arguments["status"]!;
    final code = codeTextController.value.text;

    // add firebase token for FCM use case
    final deviceToken = await FirebaseMessaging.instance.getToken();

    final response = await userService.verifyAuth(
      email: email,
      code: code,
      deviceToken: deviceToken,
    );

    if (response.error == true) {
      Get.dialog(
        AlertDialog(
          content: Text(
            "Error: ${response.message}",
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

    if (status == "created") {
      Get.toNamed(
        "/setName",
        arguments: {
          "email": email,
        },
      );
      return;
    }

    Get.offAllNamed("/main");
  }
}
