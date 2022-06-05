import 'package:digital_queue/users/services/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _emailTextController = TextEditingController();
  final _codeTextController = TextEditingController();

  get emailTextController => _emailTextController;
  get codeTextController => _codeTextController;

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  final userService = Get.find<UserService>();

  final _isLoggingIn = false.obs;
  get isLoggingIn => _isLoggingIn.value;

  Future authenticate() async {
    final email = emailTextController.value.text;

    var response = await userService.createAuth(
      email: email,
      deviceToken: await FirebaseMessaging.instance.getToken(),
    );

    if (response.error == true) {
      Get.dialog(
        AlertDialog(
          content: const Text(
            "Unable to authenticate",
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

    final status = response.statusCode == 201 ? "created" : "returning";
    Get.toNamed(
      "/verifyAuth",
      arguments: {
        // `created` flag is need to determine if we should
        // ask user to set their name for the first time.
        "status": status,
        "email": _emailTextController.value.text
      },
    );
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
