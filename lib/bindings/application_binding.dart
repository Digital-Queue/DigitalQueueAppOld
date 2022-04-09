import 'package:digital_queue/controllers/login_controller.dart';
import 'package:digital_queue/controllers/recover_account_controller.dart';
import 'package:digital_queue/controllers/register_controller.dart';
import 'package:digital_queue/controllers/reset_password_controller.dart';
import 'package:get/get.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(RegisterController());
    Get.put(RecoverAccountController());
    Get.put(ResetPasswordController());
  }
}
