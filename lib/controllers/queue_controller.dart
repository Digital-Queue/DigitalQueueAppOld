import 'package:digital_queue/services/queue_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class QueueController extends GetxController {
  final queueService = Get.put(QueueService());
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

  Future<bool> isTeacher() async {
    final accessToken = await cache.read(key: 'user_access_token');
    final data = Jwt.parseJwt(accessToken!);

    final isTeacher = data.keys.any((element) => element == 'teacher');
    return isTeacher;
  }

  Future<List<CourseQueue>> getQueues() async {
    final queues = await queueService.getQueues();
    return queues.data as List<CourseQueue>;
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
