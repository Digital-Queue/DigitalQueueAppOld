import 'package:digital_queue/users/models/user.dart';
import 'package:digital_queue/users/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final userService = Get.find<UserService>();

  var name = "".obs;
  var email = "".obs;

  Future initialize() async {
    final response = await userService.profile();

    if (response.error == true) {
      Get.dialog(
        AlertDialog(
          content: const Text(
            "Something went wrong",
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

    final User profile = response.data;
    name.value = profile.name!;
    email.value = profile.email!;
  }

  void changeEmail() {
    Get.toNamed("/changeEmail");
  }

  Future exit() async {
    await userService.logout();
    Get.offNamed("/auth");
  }
}
