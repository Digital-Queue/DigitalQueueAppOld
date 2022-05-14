import 'package:digital_queue/models/user.dart';
import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/dtos/error_result.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SetNameController extends GetxController {
  final userService = Get.find<UserService>();
  final apiClient = Get.find<ApiClient>();
  late final TextEditingController _nameTextController;

  @override
  void onInit() {
    _nameTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    super.dispose();
  }

  TextEditingController get nameTextController {
    return _nameTextController;
  }

  Future setName() async {
    final name = _nameTextController.value.text;
    final user = await userService.saveUser(
      User(
        name: name,
      ),
    );

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

    final response = await apiClient.setName(
      name: name,
      accessToken: user.accessToken!,
    );

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

    Get.offNamed("/profile");
  }
}
