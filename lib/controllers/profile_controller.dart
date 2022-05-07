import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = "John Doe".obs;
  var email = "john.doe@mail.com".obs;
  var emailConfirmed = false.obs;
  var confirmEmailCode = "".obs;

  void initialize() {
    // TODO: fetch profile
  }

  void changeEmail() {}

  void exit() {}
}
