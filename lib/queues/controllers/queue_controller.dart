import 'package:digital_queue/queues/models/course.dart';
import 'package:digital_queue/queues/models/course_queue.dart';
import 'package:digital_queue/queues/models/queue_item.dart';
import 'package:digital_queue/queues/models/queue_type.dart';
import 'package:digital_queue/queues/services/queue_service.dart';
import 'package:digital_queue/shared/services/cache_service.dart';
import 'package:digital_queue/users/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueController extends GetxController {
  final queueService = Get.put(
    QueueService(cacheService: Get.find<CacheService>()),
  );
  final userService = Get.put(
    UserService(cacheService: Get.find<CacheService>()),
  );

  @override
  void dispose() {
    findCourseTextController.dispose();
    super.dispose();
  }

  final findCourseTextController = TextEditingController();

  final currentPageIndex = 0.obs;
  final showCreateActionButton = true.obs;

  final sent = List<CourseQueue>.empty().obs;
  final received = List<CourseQueue>.empty().obs;
  final teacher = false.obs;
  final queue = List<QueueItem>.empty().obs;

  Future<bool> isTeacher() async {
    final permissions = await userService.getUserPermissions();
    return permissions.any((element) => element == 'teacher');
  }

  Future<void> initialize() async {
    // verify if user is teacher
    teacher.value = await isTeacher();

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

    sent.value = queues.data?["sent"] ?? List.empty();
    received.value = queues.data?["received"] ?? List.empty();
  }

  Future<List<Course>> findCourse(String query) async {
    if (query.isEmpty) {
      return List.empty();
    }

    final result = await queueService.search(
      query: query,
    );

    return result.data ?? List.empty();
  }

  late Course course;
  void selectCourse(Course suggestion) {
    course = suggestion;
    findCourseTextController.text = course.title;
  }

  Future<void> createQueueItem() async {
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

  Future<void> completeQueueItem(String courseId, String itemId) async {
    final response = await queueService.completeQueueItem(
      itemId: itemId,
      courseId: courseId,
    );
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
    }
  }

  Future<void> getQueueItems(String courseId, QueueType type) async {
    final response = await queueService.getCourseQueue(courseId, type);
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

      queue.value = List.empty();
    }

    queue.value = response.data ?? List.empty();
  }
}
