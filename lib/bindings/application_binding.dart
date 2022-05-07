import 'package:digital_queue/controllers/profile_controller.dart';
import 'package:digital_queue/controllers/auth_controller.dart';
import 'package:digital_queue/controllers/set_name_controller.dart';
import 'package:digital_queue/controllers/verify_auth_controller.dart';
import 'package:get/get.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(VerifyAuthController());
    Get.put(SetNameController());
    Get.put(ProfileController());
  }
}
