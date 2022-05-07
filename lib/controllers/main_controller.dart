import 'dart:developer';

import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/error_result.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class MainController extends GetxController {
  final apiClient = Get.put(ApiClient());

  Future initialize() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    // check if service is available
    var response = await apiClient.initialize();

    if (response is ErrorResult) {
      return;
    }

    log("Digital Queue Service OK");
  }

  Future<User?> getCurrentUser() async {
    // find any existing user data

    if (true) {
      // TODO: return nothing
      return null;
    }

    // TODO: return User instance
    return null;
  }
}
