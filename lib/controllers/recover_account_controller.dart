import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class RecoverAccountController extends GetxController {
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
}
