import 'package:digital_queue/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class RegisterController extends LoginController {
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
