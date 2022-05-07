import 'dart:developer';

import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/authentication_result.dart';
import 'package:digital_queue/services/error_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final apiClient = Get.find<ApiClient>();

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

    var signInResponse = await apiClient.authenticate(
      email,
    );

    if (signInResponse is ErrorResult) {
      log("login failed: ${signInResponse.message}");
      return null;
    }

    final authResult = signInResponse as AuthenticationStatus;
    final status = authResult.created ? "created" : "logged-in";

    Get.offNamed(
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
