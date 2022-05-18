import 'package:digital_queue/pages/queue/course_queue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/queue_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final QueueController controller = Get.put(QueueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queue"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/profile");
            },
            icon: const Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.isTeacher(),
        builder: (context, snapshot) {
          return CourseQueueWidget();
        },
      ),
    );
  }
}
