import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/dtos/error_result.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeEmailController extends GetxController {
  final _emailTextController = TextEditingController();
  final _codeTextController = TextEditingController();

  final apiClient = Get.find<ApiClient>();
  final userService = Get.find<UserService>();

  @override
  void dispose() {
    // TODO: implement dispose
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

    final user = await userService.getUser();

    if (user == null) {
      return;
    }

    final response = await apiClient.requestChangeEmailCode(
      email: email,
      accessToken: user.accessToken!,
    );

    if (response is ErrorResult) {
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

    final user = await userService.getUser();

    if (user == null) {
      return;
    }

    final response = await apiClient.verifyChangeEmailCode(
      email: email,
      code: code,
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

    Get.offAndToNamed("/profile");
  }
}
