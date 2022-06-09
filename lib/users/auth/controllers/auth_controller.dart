import 'package:digital_queue/users/services/auth_service.dart';
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
    _codeTextController.dispose();
    super.dispose();
  }

  final userService = Get.find<AuthService>();

  // flag to indicate whether a processing is running
  final executing = false.obs;

  Future getAuthToken() async {
    final email = emailTextController.value.text;

    var result = await userService.getAuthenticationCode(
      email: email,
      deviceToken: await FirebaseMessaging.instance.getToken(),
    );

    if (result.error == true) {
      Get.dialog(
        AlertDialog(
          content: Text(
            result.message!,
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

    final status = result.data["status"];
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

  Future verifyAuthToken() async {
    final email = Get.arguments["email"]!;
    final status = Get.arguments["status"]!;
    final code = codeTextController.value.text;

    // add firebase token for FCM use case
    final deviceToken = await FirebaseMessaging.instance.getToken();

    final result = await userService.verifyAuthenticationCode(
      email: email,
      code: code,
      deviceToken: deviceToken,
    );

    if (result.error == true) {
      Get.dialog(
        AlertDialog(
          content: Text(
            result.message!,
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
