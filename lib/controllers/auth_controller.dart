import 'package:digital_queue/services/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final userService = Get.find<UserService>();

  late final TextEditingController _emailTextController;

  @override
  void onInit() {
    _emailTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  TextEditingController get emailTextController {
    return _emailTextController;
  }

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
}
