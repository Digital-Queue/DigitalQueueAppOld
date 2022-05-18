import 'package:digital_queue/services/queue_service.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class QueueController extends GetxController {
  final queueService = Get.put(QueueService());
  final userService = Get.find<UserService>();

  final cache = const FlutterSecureStorage();

  late final TextEditingController _findCourseTextController;

  @override
  void onInit() {
    super.onInit();
    _findCourseTextController = TextEditingController();
  }

  @override
  void dispose() {
    _findCourseTextController.dispose();
    super.dispose();
  }

  get findCourseTextController => _findCourseTextController;

  Future<ViewData> getViewData() async {
    final teacher = await userService.isTeacherUser();
    final queues = await queueService.getQueues();

    return ViewData(queues: {
      "sent": queues.data["sent"],
      "received": queues.data["received"],
    }, teacher: teacher);
  }

  Future<List<Course>> findCourse(String query) async {
    if (query.isEmpty) {
      return List.empty();
    }

    final result = await queueService.search(
      query: query,
    );

    return result.data;
  }

  late Course course;
  void selectCourse(Course suggestion) {
    course = suggestion;
    _findCourseTextController.text = course.title;
  }

  Future<void> submit() async {
    final response = await queueService.createQueueItem(courseId: course.id);
    if (response.error == true) {
      Get.dialog(
        AlertDialog(
          content: Text(
            "Error: ${response.error}",
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

    Get.snackbar("Success", "Item added to ${course.title} queue");
    Get.offAllNamed("/queue");
  }
}

class ViewData {
  late final Map<String, List<CourseQueue>> queues;
  late final bool teacher;
  ViewData({required this.queues, required this.teacher});
}
