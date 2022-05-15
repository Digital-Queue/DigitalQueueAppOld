import 'dart:developer';

import 'package:digital_queue/services/api_client.dart';
import 'package:digital_queue/services/dtos/course.dart';
import 'package:digital_queue/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class QueueController extends GetxController {
  final apiClient = Get.find<ApiClient>();
  final userService = Get.find<UserService>();

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

  late User? _user;
  Future initialize() async {
    _user = await userService.getUser();
  }

  get findCourseTextController => _findCourseTextController;

  Future<List<Course>> findCourse(String query) async {
    if (_user == null) {
      return List.empty();
    }

    if (query.isEmpty) {
      return List.empty();
    }

    final accessToken = _user?.accessToken!;
    final result = await apiClient.searchCourse(
      query: query,
      accessToken: accessToken!,
    );

    return result;
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
