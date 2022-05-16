import 'package:digital_queue/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeEmailController extends GetxController {
  final _emailTextController = TextEditingController();
  final _codeTextController = TextEditingController();

  final userService = Get.find<UserService>();

  @override
  void dispose() {
    _emailTextController.dispose();
    _codeTextController.dispose();
    super.dispose();
  }

  get emailTextController => _emailTextController;
  get codeTextController => _codeTextController;

  Future sendCode() async {
    final email = _emailTextController.value.text;
    if (email == "") {
      return;
    }

    final response = await userService.getChangeEmailToken(email: email);

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

    Get.toNamed("/confirmCode");
  }

  Future verifyCode() async {
    final email = _emailTextController.value.text;
    final code = _codeTextController.value.text;

    if (code == "") {
      return;
    }

    final response = await userService.changeEmail(
      email: email,
      code: code,
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

    Get.offAndToNamed("/profile");
  }
}
