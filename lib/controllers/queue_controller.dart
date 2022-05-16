import 'package:digital_queue/services/courses_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueController extends GetxController {
  final courses = Get.put(CoursesService());

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

  Future<List<Course>> findCourse(String query) async {
    if (query.isEmpty) {
      return List.empty();
    }

    final result = await courses.search(
      query: query,
    );

    return result.data;
  }

  late Course course;
  void selectCourse(Course suggestion) {
    course = suggestion;
    _findCourseTextController.text = course.title;
  }

  void submit() {
    Get.offAllNamed("/queue");
  }
}
