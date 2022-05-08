import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/error_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SetNameController extends GetxController {
  final storage = const FlutterSecureStorage();
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
    final accessToken = await storage.read(key: "user_access_token");

    if (accessToken == null) {
      // TODO: show error popup
      return;
    }

    final response =
        await apiClient.setName(name: name, accessToken: accessToken);

    if (response is ErrorResult) {
      // TODO: show error popup
      return;
    }

    Get.offNamed("/profile");
  }
}
