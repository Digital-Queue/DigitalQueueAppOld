import 'dart:developer';

import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/dtos/authentication_result.dart';
import 'package:digital_queue/services/dtos/error_result.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../services/user_service.dart';

class MainController extends GetxController {
  final apiClient = Get.put(ApiClient());
  final userService = Get.put(UserService());

  Future initialize() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    // check if service is available
    final response = await apiClient.initialize();
    log("Digital Queue Service OK");

    if (response is ErrorResult) {
      Get.dialog(
        AlertDialog(
          content: const Text(
            "Unable to connect to remote server",
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    }

    return await _getCurrentUser();
  }

  Future<User?> _getCurrentUser() async {
    // find any existing user data
    final currentUser = await userService.getUser();

    if (currentUser == null) {
      // new user, fresh start
      return null;
    }

    // verify session tokens
    final response = await apiClient.refreshSession(
      refreshToken: currentUser.refreshToken!,
    );

    if (response is ErrorResult) {
      return null;
    }

    final auth = response as AuthenticationResult;
    await userService.saveUser(
      User(
        refreshToken: auth.refreshToken,
        accessToken: auth.accessToken,
      ),
    );

    return await userService.getUser();
  }
}
