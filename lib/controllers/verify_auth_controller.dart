import 'package:digital_queue/controllers/auth_controller.dart';
import 'package:digital_queue/services/error_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyAuthController extends AuthController {
  late final TextEditingController _codeTextController;

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

  TextEditingController get codeTextController {
    return _codeTextController;
  }

  Future verifyAuthCode() async {
    final email = Get.parameters["email"]!;
    final status = Get.parameters["status"]!;
    final code = codeTextController.value.text;

    final result = await apiClient.verifyAuthenticationCode(
      email,
      code,
    );

    if (result is ErrorResult) {
      // TODO: show error
      return;
    }

    // TODO: populate a user object

    if (status == "created") {
      Get.toNamed("/setName");
      return;
    }

    Get.offNamed("/profile");
  }
}
