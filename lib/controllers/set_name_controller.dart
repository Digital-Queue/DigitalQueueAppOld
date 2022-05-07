import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SetNameController extends GetxController {
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
}
