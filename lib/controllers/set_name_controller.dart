import 'package:digital_queue/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetNameController extends GetxController {
  final userService = Get.find<UserService>();
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
    final response = await userService.updateName(name: name);

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

    Get.offNamed("/queue");
  }
}
