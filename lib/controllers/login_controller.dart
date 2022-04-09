import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;

  @override
  void onInit() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  TextEditingController get emailTextController {
    return _emailTextController;
  }

  TextEditingController get passwordTextController {
    return _emailTextController;
  }
}
