import 'package:digital_queue/controllers/main_controller.dart';
import 'package:digital_queue/controllers/profile_controller.dart';
import 'package:digital_queue/controllers/auth_controller.dart';
import 'package:digital_queue/controllers/set_name_controller.dart';
import 'package:digital_queue/controllers/verify_auth_controller.dart';
import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:get/get.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put(UserService());
    // Get.put(ApiClient());
    // Get.put(MainController());
    Get.put(AuthController());
    Get.put(VerifyAuthController());
    Get.put(SetNameController());
    Get.put(ProfileController());
  }
}
