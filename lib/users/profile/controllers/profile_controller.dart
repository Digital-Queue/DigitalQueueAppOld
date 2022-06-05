import 'package:digital_queue/users/models/user.dart';
import 'package:digital_queue/users/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _emailTextController = TextEditingController();
  final _codeTextController = TextEditingController();
  final _nameTextController = TextEditingController();

  get emailTextController => _emailTextController;
  get codeTextController => _codeTextController;
  get nameTextController => _nameTextController;

  @override
  void dispose() {
    _emailTextController.dispose();
    _codeTextController.dispose();
    super.dispose();
  }

  final userService = Get.find<UserService>();

  var name = "".obs;
  var email = "".obs;

  Future initialize() async {
    final response = await userService.profile();

    if (response.error == true) {
      Get.dialog(
        AlertDialog(
          content: const Text(
            "Something went wrong",
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );

      return;
    }

    final User profile = response.data;
    name.value = profile.name!;
    email.value = profile.email!;
  }

  void goToChangeEmail() {
    Get.toNamed("/changeEmail");
  }

  Future setName() async {
    final name = _nameTextController.value.text;
    final response = await userService.updateName(name: name);

    if (response.error == true) {
      Get.dialog(
        AlertDialog(
          content: Text(
            "Error: ${response.message}",
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );

      return;
    }

    Get.offAllNamed("/main");
  }

  Future getCode() async {
    final email = _emailTextController.value.text;
    if (email == "") {
      return;
    }

    final response = await userService.getChangeEmailToken(email: email);

    if (response.error == true) {
      Get.dialog(
        AlertDialog(
          content: Text(
            "Error: ${response.message}",
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );

      return;
    }

    Get.toNamed("/confirmCode");
  }

  Future verifyCode() async {
    final email = _emailTextController.value.text;
    final code = _codeTextController.value.text;

    if (code == "") {
      return;
    }

    final response = await userService.changeEmail(
      email: email,
      code: code,
    );

    if (response.error == true) {
      Get.dialog(
        AlertDialog(
          content: Text(
            "Error: ${response.message}",
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
      return;
    }

    Get.offAndToNamed("/profile");
  }

  Future signOut() async {
    await userService.logout();
    Get.offNamed("/auth");
  }
}
