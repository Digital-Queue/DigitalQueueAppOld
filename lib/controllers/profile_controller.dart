import 'package:digital_queue/models/user.dart';
import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/dtos/error_result.dart';
import 'package:digital_queue/services/dtos/profile_result.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final userService = Get.find<UserService>();
  final apiClient = Get.find<ApiClient>();

  var name = "".obs;
  var email = "".obs;

  Future initialize() async {
    final user = await userService.getUser();

    if (user == null) {
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

    final response = await apiClient.getProfile(accessToken: user.accessToken!);

    if (response is ErrorResult) {
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

    final profile = response as ProfileResult;
    await userService.saveUser(
      User(
        id: profile.id,
        name: profile.name,
        email: profile.email,
      ),
    );
    name.value = profile.name;
    email.value = profile.email;
  }

  void changeEmail() {
    Get.toNamed("/changeEmail");
  }

  Future exit() async {
    final user = await userService.getUser();
    if (user != null) {
      await apiClient.terminateSession(accessToken: user.accessToken!);
    }
    await userService.clearUser();

    Get.offNamed("/auth");
  }
}
