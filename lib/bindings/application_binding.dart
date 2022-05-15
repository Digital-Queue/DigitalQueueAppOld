import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:get/get.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserService());
    Get.put(ApiClient());
  }
}
