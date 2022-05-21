import 'package:digital_queue/services/queue_service.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueController extends GetxController {
  final queueService = Get.put(QueueService());
  final userService = Get.find<UserService>();

  @override
  void onInit() {
    super.onInit();
    findCourseTextController = TextEditingController();
  }

  @override
  void dispose() {
    findCourseTextController.dispose();
    super.dispose();
  }

  late final TextEditingController findCourseTextController;

  final currentPageIndex = 0.obs;
  final showCreateActionButton = true.obs;

  final sent = List<CourseQueue>.empty().obs;
  final received = List<CourseQueue>.empty().obs;
  final teacher = false.obs;

  Future<void> initialize() async {
    // fetch queues and update lists
    final queues = await queueService.getQueues();
    if (queues.error == true) {
      Get.dialog(
        AlertDialog(
          content: Text(
            "Error: ${queues.message}",
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

    sent.value = queues.data["sent"];
    received.value = queues.data["received"];

    // verify if user is teacher
    teacher.value = await userService.isTeacherUser();
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
    findCourseTextController.text = course.title;
  }

  Future<void> submit() async {
    final response = await queueService.createQueueItem(courseId: course.id);
    if (response.error == true) {
      Get.dialog(
        AlertDialog(
          content: Text(
            response.message ?? "Error",
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
    Get.offAllNamed("/main");
  }

  void viewQueue(CourseQueue queue) {
    Get.offAndToNamed("/queue", arguments: queue);
  }

  Future<void> completeItem(String itemId) async {
    await queueService.completeQueueItem(requestId: itemId);
  }
}
