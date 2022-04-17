import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = "John Doe".obs;
  var email = "john.doe@mail.com".obs;
  var emailConfirmed = false.obs;
  var confirmEmailCode = "".obs;

  void changeEmail() {}

  void confirmEmail() {
    Get.toNamed("/confirm-email", parameters: {"sendCode": "true"});
    emailConfirmed.value = true;
  }

  void changePassword() {
    Get.toNamed("/reset-password", parameters: {"sendCode": "true"});
  }

  void save() {}

  void exit() {}
}
