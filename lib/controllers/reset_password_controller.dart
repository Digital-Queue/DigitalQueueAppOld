import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ResetPasswordController extends GetxController {
  late final TextEditingController _codeTextController;
  late final TextEditingController _newPasswordTextController;

  @override
  void onInit() {
    _codeTextController = TextEditingController();
    _newPasswordTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    _codeTextController.dispose();
    _newPasswordTextController.dispose();
    super.dispose();
  }

  TextEditingController get codeTextController {
    return _codeTextController;
  }

  TextEditingController get newPasswordTextController {
    return _newPasswordTextController;
  }
}
